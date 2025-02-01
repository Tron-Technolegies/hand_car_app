import 'dart:convert';
import 'dart:core';
import 'dart:developer';
import 'package:dio/dio.dart';

import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:synchronized/synchronized.dart';

class BaseApiService {
  final Dio dio;
  final TokenStorage tokenStorage;
  bool _isRefreshing = false;
  final _refreshLock = Lock();

  BaseApiService({String? customBaseUrl})
      : dio = Dio(BaseOptions(
          baseUrl: customBaseUrl ?? baseUrl,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Cache-Control': 'no-cache',
          },
          extra: {
            'withCredentials': true,
          },
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        )),
        tokenStorage = TokenStorage() {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            await _refreshLock.synchronized(() async {
              if (await _shouldRefreshToken()) {
                final success = await _refreshToken();
                if (!success) {
                  throw DioException(
                    requestOptions: options,
                    error: 'Token refresh failed',
                  );
                }
              }
            });

            final token = tokenStorage.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
              log('Adding access token to headers: $token');
              options.headers['Cookie'] = 'access_token=$token';
              log('Adding cookie to headers: access_token=$token');
            }
            return handler.next(options);
          } catch (e) {
            return handler.reject(DioException(
              requestOptions: options,
              error: 'Request preparation failed: $e',
            ));
          }
        },
        onError: (error, handler) async {
          if (isTokenExpiredError(error)) {
            try {
              final success =
                  await _refreshLock.synchronized(() => _refreshToken());
              if (success) {
                final newToken = tokenStorage.getAccessToken();
                if (newToken != null) {
                  error.requestOptions.headers['Authorization'] =
                      'Bearer $newToken';
                  log('Adding access token to headers: $newToken');
                  error.requestOptions.headers['Cookie'] =
                      'access_token=$newToken';
                  log('Adding cookie to headers: access_token=$newToken');
                  final response = await dio.fetch(error.requestOptions);
                  return handler.resolve(response);
                }
              }
              await tokenStorage.clearTokens();
            } catch (e) {
              log('Token refresh error during error handling: $e');
              await tokenStorage.clearTokens();
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> _shouldRefreshToken() async {
    if (!tokenStorage.hasValidTokens) return false;

    try {
      final token = tokenStorage.getAccessToken();
      if (token == null) return true;

      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = _decodeJwtPayload(parts[1]);
      final expiration =
          DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
      final now = DateTime.now();
      final refreshThreshold = expiration.subtract(const Duration(minutes: 15));

      log('Token expiration check:'
          '\nCurrent time: ${now.toIso8601String()}'
          '\nExpiration time: ${expiration.toIso8601String()}'
          '\nRefresh threshold: ${refreshThreshold.toIso8601String()}'
          '\nShould refresh: ${now.isAfter(refreshThreshold)}');

      return now.isAfter(refreshThreshold);
    } catch (e) {
      log('Error checking token expiration: $e');
      return true;
    }
  }

  Future<bool> _refreshToken() async {
    return _refreshLock.synchronized(() async {
      if (_isRefreshing) return false;
      _isRefreshing = true;

      try {
        final refreshToken = tokenStorage.getRefreshToken();
        if (refreshToken == null) {
          throw Exception('No refresh token available');
        }

        final response = await dio.post(
          '/refresh_token',
          data: {'refresh': refreshToken},
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Cookie': 'refresh_token=$refreshToken'
            },
            extra: {
              'withCredentials': true,
            },
          ),
        );

        if (response.statusCode == 200 && response.data != null) {
          final accessToken = response.data['access'];
          log('Token refreshed: $accessToken');
          final newRefreshToken = response.data['refresh'] ?? refreshToken;
          log('New refresh token: $newRefreshToken');

          if (accessToken != null) {
            await tokenStorage.saveTokens(
              accessToken: accessToken,
              refreshToken: newRefreshToken,
            );
            return true;
          }
        }

        log('Token refresh failed: Invalid response format');
        return false;
      } catch (e) {
        log('Token refresh error: $e');
        await tokenStorage.clearTokens();
        return false;
      } finally {
        _isRefreshing = false;
      }
    });
  }

  Future<T> withRetry<T>(Future<T> Function() apiCall) async {
    int attempts = 0;
    Duration delay = const Duration(seconds: 2);
    const maxAttempts = 3;

    while (attempts < maxAttempts) {
      try {
        return await apiCall();
      } on DioException catch (e) {
        attempts++;
        if (attempts == maxAttempts ||
            !(e.type == DioExceptionType.receiveTimeout ||
                e.type == DioExceptionType.connectionTimeout ||
                e.type == DioExceptionType.sendTimeout)) {
          rethrow;
        }
        log('Retry attempt $attempts after ${delay.inSeconds}s delay');
        await Future.delayed(delay);
        delay *= 2;
      }
    }
    throw Exception('Failed after $maxAttempts attempts');
  }

  Map<String, dynamic> _decodeJwtPayload(String str) {
    try {
      String normalized = str.replaceAll('-', '+').replaceAll('_', '/');

      switch (normalized.length % 4) {
        case 0:
          break;
        case 2:
          normalized += '==';
          break;
        case 3:
          normalized += '=';
          break;
        default:
          throw FormatException('Invalid base64 string');
      }

      final decoded = utf8.decode(base64Url.decode(normalized));
      return Map<String, dynamic>.from(jsonDecode(decoded));
    } catch (e) {
      throw Exception('Failed to decode JWT payload: $e');
    }
  }

  bool isTokenExpiredError(DioException e) {
    final response = e.response;
    if (response == null) return false;

    if (response.statusCode == 401) {
      final errorMessage =
          response.data?['detail']?.toString().toLowerCase() ?? '';
      return errorMessage.contains('expired') ||
          errorMessage.contains('invalid') ||
          errorMessage.contains('token');
    }
    return false;
  }

  Exception handleApiError(Response response) {
    final message = response.data?['error'] ?? response.data?['detail'];
    return Exception(message ?? 'Operation failed');
  }
}
