import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_service.g.dart';

class ApiServiceAuthentication {
  final Dio _dio;
  final TokenStorage _tokenStorage;

  ApiServiceAuthentication()
      : _dio = Dio(
          BaseOptions(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 5),
            receiveTimeout: const Duration(seconds: 3),
          ),
        ),
        _tokenStorage = TokenStorage() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final token = _tokenStorage.getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            // Token expired, handle token refresh
            try {
              await _handleTokenExpiration();

              // Retry the failed request with the new token
              final refreshedRequest = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: {
                    ...error.requestOptions.headers,
                    'Authorization': 'Bearer ${_tokenStorage.getAccessToken()}',
                  },
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );

              return handler.resolve(refreshedRequest);
            } catch (e) {
              // Logout and propagate the error
              await logout();
              return handler.reject(error);
            }
          }
          return handler.next(error); // Forward other errors
        },
      ),
    );
  }

  /// Handles token expiration by refreshing the access token.
  Future<void> _handleTokenExpiration() async {
    final refreshToken = _tokenStorage.getRefreshToken();

    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available.');
    }

    try {
      final response = await _dio.post(
        '/refresh-token/',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newAuthModel = AuthModel.fromJson(response.data);

        await _tokenStorage.saveTokens(
          accessToken: newAuthModel.accessToken,
          refreshToken: newAuthModel.refreshToken,
        );
      } else {
        throw Exception('Failed to refresh token.');
      }
    } catch (e) {
      throw Exception('Session expired. Please login again.');
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
  try {
    final response = await _dio.post('/UserLogin',
        data: FormData.fromMap(
          {'username': username, 'password': password},
        ));

    log('Login Response Status Code: ${response.statusCode}');
    log('Login Response Data: ${response.data}');

    if (response.statusCode == 200) {
      final authModel = AuthModel.fromJson(response.data);
      await _tokenStorage.saveTokens(
        accessToken: authModel.accessToken,
        refreshToken: authModel.refreshToken,
      );
      return authModel.toJson();
    }

    throw Exception('Login failed. Please check your credentials.');
  } on DioException catch (e) {
    log('Dio Error: ${e.response?.statusCode}');
    log('Dio Error Data: ${e.response?.data}');
    throw Exception(_handleDioError(e));
  }
}

  Future<String> signUp(
  UserModel user
  ) async {
    try {
      final response = await _dio.post(
        '/signup',
        data: user.toJson(),
      );
      return response.data['message'];
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['error'] ?? 'Signup failed');
      }
      throw Exception('Failed to connect to server');
    }
  
  }

 Future<void> logout() async {
    try {
      // Add access token to the request if available
      final accessToken = _tokenStorage.getAccessToken();
      if (accessToken != null) {
        _dio.options.headers['Authorization'] = 'Bearer $accessToken';
      }

      await _dio.post('/Logout');
      
      // Clear stored tokens
      await _tokenStorage.clearTokens();
      
      // Clear auth header from dio instance
      _dio.options.headers.remove('Authorization');
      
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['error'] ?? 'Logout failed');
      }
      throw Exception('Failed to connect to server');
    }
  
}


  /// Handles Dio errors and provides human-readable messages
  String _handleDioError(DioException e) {
    if (e.response != null) {
      switch (e.response?.statusCode) {
        case 401:
          return 'Invalid credentials';
        case 422:
          return 'Invalid input data';
        default:
          return e.response?.data['error'] ?? 'An unknown error occurred';
      }
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        return 'Connection timeout. Please check your internet.';
      case DioExceptionType.receiveTimeout:
        return 'Server not responding. Please try again later.';
      default:
        return 'Network error. Please try again.';
    }
  }

  bool get isAuthenticated => _tokenStorage.hasTokens;
}

@riverpod
ApiServiceAuthentication apiService(Ref ref) {
  return ApiServiceAuthentication();
}
