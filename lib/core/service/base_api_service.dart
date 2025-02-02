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
            final token = tokenStorage.getAccessToken();
            if (token != null) {
              // Check if token needs refresh
              if (await _shouldRefreshToken()) {
                log('Token needs refresh before request');
                final success = await _refreshToken();
                if (!success) {
                  log('Token refresh failed');
                  return handler.reject(DioException(
                    requestOptions: options,
                    error: 'Token refresh failed',
                  ));
                }
                // Get new token after refresh
                final newToken = tokenStorage.getAccessToken();
                if (newToken != null) {
                  options.headers['Authorization'] = 'Bearer $newToken';
                  options.headers['Cookie'] = 'access_token=$newToken';
                }
              } else {
                // Use existing token
                options.headers['Authorization'] = 'Bearer $token';
                options.headers['Cookie'] = 'access_token=$token';
              }
              options.extra['withCredentials'] = true;
            }
          });
          return handler.next(options);
        } catch (e) {
          log('Request interceptor error: $e');
          return handler.reject(DioException(
            requestOptions: options,
            error: 'Request preparation failed: $e',
          ));
        }
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) async {
        if (isTokenExpiredError(error)) {
          try {
            final success = await _refreshLock.synchronized(() => _refreshToken());
            if (success) {
              // Retry the failed request with new token
              final newToken = tokenStorage.getAccessToken();
              if (newToken != null) {
                error.requestOptions.headers['Authorization'] = 'Bearer $newToken';
                error.requestOptions.headers['Cookie'] = 'access_token=$newToken';
                
                final retryResponse = await dio.fetch(error.requestOptions);
                return handler.resolve(retryResponse);
              }
            }
            // If refresh failed, clear tokens
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
    final expiration = DateTime.fromMillisecondsSinceEpoch(payload['exp'] * 1000);
    final now = DateTime.now();
    
    // Check if current time is after token expiration
    if (now.isAfter(expiration)) {
      log('Token has expired, needs refresh');
      return true;
    }

    // Get remaining time until expiration
    final timeUntilExpiry = expiration.difference(now);
    
    // If less than 5 minutes remaining, trigger refresh
    final shouldRefresh = timeUntilExpiry.inMinutes <= 5;
    
    log('Token expiration check:'
        '\nCurrent time: ${now.toIso8601String()}'
        '\nExpiration time: ${expiration.toIso8601String()}'
        '\nTime until expiry: ${timeUntilExpiry.inMinutes} minutes'
        '\nShould refresh: $shouldRefresh');

    return shouldRefresh;

  } catch (e) {
    log('Error checking token expiration: $e');
    return true;
  }
}

  Future<bool> _refreshToken() async {
    if (_isRefreshing) {
      log('Skipping refresh - already in progress');
      return false;
    }

    return _refreshLock.synchronized(() async {
      if (_isRefreshing) return false;
      _isRefreshing = true;

      try {
        final refreshToken = tokenStorage.getRefreshToken();
        if (refreshToken == null) {
          log('No refresh token available');
          return false;
        }

        log('Starting token refresh');
        final response = await dio.post(
          '/refresh_token',
          data: {'refresh': refreshToken},
          options: Options(headers: {'Content-Type': 'application/json'}),
        );

        if (response.statusCode == 200 && response.data != null) {
          final accessToken = response.data['access'];
          final newRefreshToken = response.data['refresh'] ?? refreshToken;

          if (accessToken != null) {
            await tokenStorage.saveTokens(
              accessToken: accessToken,
              refreshToken: newRefreshToken,
            );
            log('Token refresh successful');
            return true;
          }
        }

        log('Token refresh failed: Invalid response format');
        return false;
      } catch (e) {
        log('Token refresh error: $e');
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
