import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_service.g.dart';

class ApiServiceAuthentication {
  final Dio dio;
  final TokenStorage _tokenStorage;

  ApiServiceAuthentication()
      : dio = Dio(
          BaseOptions(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            baseUrl: baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ),
        _tokenStorage = TokenStorage() {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.clear(); // Clear any existing interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: _handleRequest,
        onError: _handleError,
      ),
    );
  }

  void _handleRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      final token = _tokenStorage.getAccessToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    } catch (e) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: 'Failed to get access token',
        ),
      );
    }
  }

  Future<void> _handleError(
    DioException error,
    ErrorInterceptorHandler handler,
  ) async {
    if (error.response?.statusCode == 401) {
      try {
        await _refreshToken();

        // Retry the original request with new token
        final newToken = _tokenStorage.getAccessToken();
        if (newToken == null) throw Exception('No access token after refresh');

        final response = await _retryRequest(error.requestOptions, newToken);
        return handler.resolve(response);
      } catch (e) {
        log('Token refresh failed: $e');
        await _handleLogout();
        return handler.reject(error);
      }
    }
    return handler.next(error);
  }

  Future<Response<dynamic>> _retryRequest(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        'Authorization': 'Bearer $newToken',
      },
    );

    return await dio.request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  Future<void> _refreshToken() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }

    try {
      final response = await dio.post(
        '/refresh-token/',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);
        await _tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
      } else {
        throw Exception('Token refresh failed');
      }
    } catch (e) {
      log('Error refreshing token: $e');
      throw Exception('Session expired');
    }
  }

  Future<AuthModel> login(String username, String password) async {
    try {
      log('LOGIN ATTEMPT - Username: $username, Password: $password');

      // Create FormData object
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      log('Sending FormData: ${formData.fields}');

      final response = await dio.post(
        '/UserLogin',
        data: formData, // Use formData instead of JSON
        options: Options(
          contentType:
              'multipart/form-data', // Set content type to multipart/form-data
          headers: {
            'Accept': 'application/json',
          },
        ),
      );

      log('Login response: ${response.data}');

      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);
        await _tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
        return authModel;
      } else {
        throw Exception(response.data['error'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      log('DIO ERROR DETAILS:');
      log('Type: ${e.type}');
      log('Error Message: ${e.message}');
      log('Response Status Code: ${e.response?.statusCode}');
      log('Response Data: ${e.response?.data}');
      log('Request Path: ${e.requestOptions.path}');
      log('Request Data: ${e.requestOptions.data}');
      final errorMessage = _handleDioError(e);
      throw Exception(errorMessage);
    } catch (e) {
      log('Unexpected login error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> logout() async {
    try {
      final token = _tokenStorage.getAccessToken();
      if (token != null) {
        await dio.post(
          '/Logout',
          options: Options(
            headers: {'Authorization': 'Bearer $token'},
          ),
        );
      }
    } catch (e) {
      log('Logout error: $e');
    } finally {
      await _handleLogout();
    }
  }

  Future<void> _handleLogout() async {
    await _tokenStorage.clearTokens();
    dio.options.headers.remove('Authorization');
  }

Future<String> signUp(UserModel user) async {
  int retryCount = 0;
  const maxRetries = 3;
  
  while (retryCount < maxRetries) {
    try {
      final response = await dio.post(
        '/signup/',
        data: user.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Signup failed');
      }
      return response.data['message'] ?? 'Signup successful';
    } on DioException catch (e) {
      if (e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.connectionTimeout) {
        retryCount++;
        if (retryCount == maxRetries) {
          rethrow;
        }
        await Future.delayed(Duration(seconds: 2 * retryCount));
        continue;
      }
      rethrow;
    }
  }
  throw Exception('Failed after $maxRetries retries');
}

  Future<void> requestPasswordReset(String email) async {
    try {
      final response = await dio.post(
        '/forgot_password',
        data: {'email': email},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Failed to send reset email');
      }
    } on DioException catch (e) {
      final errorMessage = _handleDioError(e);
      throw Exception(errorMessage);
    } catch (e) {
      log('Password reset request error: $e');
      throw Exception('An unexpected error occurred');
    }
  }

  Future<void> resetPassword(String uid, String token, String newPassword) async {
    try {
      final response = await dio.post(
        '/reset_password/$uid/$token',
        data: {'new_password': newPassword},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Failed to reset password');
      }
    } on DioException catch (e) {
      final errorMessage = _handleDioError(e);
      throw Exception(errorMessage);
    } catch (e) {
      log('Password reset error: $e');
      throw Exception('An unexpected error occurred');
    }
  }


  String _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;

      switch (statusCode) {
        case 400:
          return data?['message'] ?? 'Invalid request';
        case 401:
          return 'Invalid credentials';
        case 403:
          return 'Access denied';
        case 404:
          return 'Resource not found';
        case 422:
          return 'Invalid input data';
        case 429:
          return 'Too many attempts. Please try again later';
        case 500:
          return 'Server error. Please try again later';
        default:
          return data?['message'] ?? 'An unknown error occurred';
      }
    }

    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection timeout. Please check your internet';
      case DioExceptionType.receiveTimeout:
        return 'Server not responding. Please try again later';
      case DioExceptionType.cancel:
        return 'Request cancelled';
      default:
        return 'Network error. Please check your connection';
    }
  }

  bool get isAuthenticated => _tokenStorage.hasTokens;
}

@riverpod
ApiServiceAuthentication apiService(ref) {
  return ApiServiceAuthentication();
}
