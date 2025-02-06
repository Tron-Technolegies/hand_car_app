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
            // Get current access token
            final token = tokenStorage.getAccessToken();

            log('Interceptor Request Details:'
                '\n - Current Token Available: ${token != null}'
                '\n - Token First 10 Chars: ${token?.substring(0, 10)}...');

            if (token != null) {
              // Set authorization headers
              options.headers['Authorization'] = 'Bearer $token';
              options.headers['Cookie'] = 'access_token=$token';

              // Check if token needs refresh
              if (tokenStorage.isAccessTokenExpired()) {
                log('Token Expired - Attempting Refresh');

                final refreshSuccess = await refreshToken();

                if (refreshSuccess) {
                  final newToken = tokenStorage.getAccessToken();
                  if (newToken != null) {
                    options.headers['Authorization'] = 'Bearer $newToken';
                    options.headers['Cookie'] = 'access_token=$newToken';

                    log('Token Refreshed Successfully:'
                        '\n - New Token Used: ${newToken.substring(0, 10)}...');
                  }
                }
              }
            }

            return handler.next(options);
          } catch (e) {
            log('Interceptor Request Error:'
                '\n - Error: $e');
            return handler.next(options);
          }
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            log('Unauthorized Error Detected:'
                '\n - Request Path: ${error.requestOptions.path}'
                '\n - Error Message: ${error.message}');

            try {
              // Attempt to refresh token
              final refreshSuccess = await refreshToken();
              if (refreshSuccess) {
                // Retry the original request
                return handler.resolve(await dio.fetch(error.requestOptions));
              }
            } catch (refreshError) {
              log('Token Refresh Failed:'
                  '\n - Error: $refreshError');
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  // Helper method to set auth headers
  // void _setAuthHeaders(RequestOptions options, String token) {
  //   options.headers['Authorization'] = 'Bearer $token';
  //   options.headers['Cookie'] = 'access_token=$token';
  // }

  // // Helper method to retry a request with new token
  // Future<Response> _retryRequest(
  //     RequestOptions failedRequest, String newToken) async {
  //   final clonedRequest =
  //       await _cloneRequestWithNewToken(failedRequest, newToken);
  //   log('Retrying failed request with new token');
  //   return dio.fetch(clonedRequest);
  // }

  // // Helper method to wait for ongoing refresh
  // Future<String?> _waitForRefresh() async {
  //   int attempts = 0;
  //   const maxAttempts = 3;

  //   while (_isRefreshing && attempts < maxAttempts) {
  //     await Future.delayed(const Duration(seconds: 1));
  //     attempts++;
  //   }

  //   return tokenStorage.getAccessToken();
  // }

  // Future<RequestOptions> _cloneRequestWithNewToken(
  //     RequestOptions request, String newToken) async {
  //   return RequestOptions(
  //     method: request.method,
  //     path: request.path,
  //     data: request.data,
  //     queryParameters: request.queryParameters,
  //     headers: {
  //       ...request.headers,
  //       'Authorization': 'Bearer $newToken',
  //       'Cookie': 'access_token=$newToken',
  //     },
  //     extra: {
  //       'withCredentials': true,
  //     },
  //     baseUrl: request.baseUrl,
  //   );
  // }

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
          log('Invalid Refresh Token:'
              '\n - Refresh Token: $refreshToken'
              '\n - Is Expired: ${tokenStorage.isRefreshTokenExpired()}');
          await tokenStorage.clearTokens();
          return false;
        }

        log('Starting Token Refresh Process:'
            '\n - Base URL: $baseUrl');

        final refreshDio = Dio(BaseOptions(
          baseUrl: baseUrl,
          validateStatus: (status) => true,
        ));

        try {
          final response = await refreshDio.post(
            '/RefreshAccessToken', // Updated endpoint
            options: Options(
              headers: {
                // 'Cookie': 'refresh_token=$refreshToken',
                'Content-Type': 'application/json',
                'Authorization': 'Bearer $refreshToken',
              },
              extra: {
                'withCredentials': true,
              },
            ),
          );

          log('Refresh Response Details:'
              '\n - Status Code: ${response.statusCode}'
              '\n - Response Data: ${response.data}');

          // Handle different response scenarios
          switch (response.statusCode) {
            case 200:
              // Check if access_token exists in response
              if (response.data.containsKey('access_token')) {
                final newAccessToken = response.data['access_token'];

                log('New Access Token Received:'
                    '\n - Token Length: ${newAccessToken.length}'
                    '\n - First 10 Chars: ${newAccessToken.substring(0, 10)}...');

                // Save the new access token
                await tokenStorage.saveRefreshedAccessToken(newAccessToken);

                // Update Dio headers with new token
                _updateDioHeaders(newAccessToken);

                log('Token Refresh Successful:'
                    '\n - New Token Saved'
                    '\n - Dio Headers Updated');
                return true;
              }
              log('No access token in response');
              return false;

            case 400:
              log('Refresh Token Error:'
                  '\n - Missing Refresh Token'
                  '\n - Error: ${response.data['error']}');
              await tokenStorage.clearTokens();
              return false;

            case 401:
              log('Unauthorized Refresh:'
                  '\n - Error: ${response.data['error']}');
              await tokenStorage.clearTokens();
              return false;

            default:
              log('Unexpected Refresh Response:'
                  '\n - Status Code: ${response.statusCode}'
                  '\n - Response Data: ${response.data}');
              return false;
          }
        } catch (requestError) {
          log('Token Refresh Request Error:'
              '\n - Error: $requestError'
              '\n - Error Type: ${requestError.runtimeType}');
          return false;
        }
      } catch (generalError) {
        log('General Token Refresh Error:'
            '\n - Error: $generalError'
            '\n - Error Type: ${generalError.runtimeType}');
        return false;
      } finally {
        _isRefreshing = false;
      }
    });
  }

// Update Dio headers method
  void _updateDioHeaders(String token) {
    try {
      // Update global Dio options
      dio.options.headers['Authorization'] = 'Bearer $token';
      dio.options.headers['Cookie'] = 'access_token=$token';

      log('Dio Global Headers Updated:'
          '\n - Authorization: ${dio.options.headers['Authorization']?.substring(0, 20)}...'
          '\n - Cookie: ${dio.options.headers['Cookie']?.substring(0, 20)}...');
    } catch (e) {
      log('Error updating Dio headers:'
          '\n - Error: $e');
    }
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
