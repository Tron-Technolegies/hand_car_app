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
  static const int _minimumRefreshMinutes = 5;

  BaseApiService({String? customBaseUrl})
      : dio = Dio(BaseOptions(
          baseUrl: customBaseUrl ?? baseUrl,
          validateStatus: (status) => true,
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
        )),
        tokenStorage = TokenStorage() {
    setupInterceptors();
  }

  void setupInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(
      QueuedInterceptorsWrapper(
        onRequest: (options, handler) async {
          try {
            final token = tokenStorage.getAccessToken();
            if (token != null) {
              options.headers['Authorization'] = 'Bearer $token';
              
              // Check if token needs refresh
              if (tokenStorage.isAccessTokenExpired() || await shouldRefreshToken()) {
                log('Token needs refresh, attempting refresh...');
                final success = await refreshToken();
                if (success) {
                  final newToken = tokenStorage.getAccessToken();
                  options.headers['Authorization'] = 'Bearer $newToken';
                  log('Token refreshed successfully, proceeding with request');
                  return handler.next(options);
                } else {
                  log('Token refresh failed, rejecting request');
                  return handler.reject(
                    DioException(
                      requestOptions: options,
                      error: 'Token refresh failed',
                      type: DioExceptionType.badResponse,
                    ),
                  );
                }
              }
            }
            return handler.next(options);
          } catch (e) {
            log('Request interceptor error: $e');
            return handler.reject(
              DioException(
                requestOptions: options,
                error: e.toString(),
                type: DioExceptionType.unknown,
              ),
            );
          }
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            log('Received 401 error, attempting token refresh');
            try {
              // Store the failed request
              final failedRequest = error.requestOptions;
              
              if (!_isRefreshing) {
                final success = await refreshToken();
                if (success) {
                  // Retry the failed request with new token
                  final newToken = tokenStorage.getAccessToken();
                  failedRequest.headers['Authorization'] = 'Bearer $newToken';
                  
                  log('Retrying failed request with new token');
                  final response = await dio.fetch(failedRequest);
                  return handler.resolve(response);
                }
              } else {
                // Wait for ongoing refresh to complete
                await Future.delayed(const Duration(seconds: 1));
                final newToken = tokenStorage.getAccessToken();
                if (newToken != null) {
                  failedRequest.headers['Authorization'] = 'Bearer $newToken';
                  final response = await dio.fetch(failedRequest);
                  return handler.resolve(response);
                }
              }
            } catch (e) {
              log('Error during token refresh: $e');
            }
            // Clear tokens if refresh failed
            await tokenStorage.clearTokens();
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<bool> refreshToken() async {
    if (_isRefreshing) {
      log('Token refresh already in progress');
      return false;
    }

    return _refreshLock.synchronized(() async {
      if (_isRefreshing) return false;
      _isRefreshing = true;

      try {
        final refreshToken = tokenStorage.getRefreshToken();
        if (refreshToken == null || tokenStorage.isRefreshTokenExpired()) {
          log('No valid refresh token available');
          return false;
        }

        log('Starting token refresh process');
        final response = await dio.post(
          '/refresh_token',
          options: Options(
            headers: {
              'Authorization': 'Bearer $refreshToken',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

        log('Refresh response status: ${response.statusCode}');

        if (response.statusCode == 200 && response.data != null) {
          final accessToken = response.data['access_token'];
          if (accessToken != null) {
            await tokenStorage.saveTokens(
              accessToken: accessToken,
              refreshToken: refreshToken, 
            );
            log('Token refresh successful');
            return true;
          }
        }
        
        log('Token refresh failed with status: ${response.statusCode}');
        return false;
      } catch (e) {
        log('Error during token refresh: $e');
        return false;
      } finally {
        _isRefreshing = false;
      }
    });
  }

  Future<bool> shouldRefreshToken() async {
    try {
      final remainingTime = tokenStorage.getAccessTokenRemainingTime();
      if (remainingTime == null) return true;

      final shouldRefresh = remainingTime.inMinutes <= _minimumRefreshMinutes;
      log('Token check: expires in ${remainingTime.inMinutes} minutes, should refresh: $shouldRefresh');
      return shouldRefresh;
    } catch (e) {
      log('Error checking token expiration: $e');
      return true;
    }
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
        log('Retry attempt $attempts after error: ${e.message}');
        await Future.delayed(delay);
        delay *= 2;
      }
    }
    throw Exception('Failed after $maxAttempts attempts');
  }

  Exception handleApiError(Response response) {
    final message = response.data?['error'] ?? response.data?['detail'];
    return Exception(message ?? 'Operation failed');
  }
}