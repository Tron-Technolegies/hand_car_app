import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';


class BaseApiService {
  final Dio dio;
  final TokenStorage tokenStorage;

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
              options.headers['Cookie'] = 'access_token=$token';
            }
            return handler.next(options);
          } catch (e) {
            log('Interceptor Request Error: $e');
            return handler.next(options);
          }
        },
        onError: (DioException error, handler) async {
          if (error.response?.statusCode == 401) {
            await tokenStorage.clearTokens();
          }
          return handler.next(error);
        },
      ),
    );
  }



  // Rest of your BaseApiService code remains the same


  

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