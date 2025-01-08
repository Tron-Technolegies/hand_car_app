import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
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
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.clear(); // Clear any existing interceptors
    _dio.interceptors.add(
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
      final token = await _tokenStorage.getAccessToken();
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
        final newToken = await _tokenStorage.getAccessToken();
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

    return await _dio.request(
      requestOptions.path,
      options: options,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
    );
  }

  Future<void> _refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available');
    }

    try {
      final response = await _dio.post(
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
    print('LOGIN ATTEMPT - Username: $username, Password: $password');
    
    // Create FormData object
    final formData = FormData.fromMap({
      'username': username,
      'password': password,
    });

    print('Sending FormData: ${formData.fields}');

    final response = await _dio.post(
      '/UserLogin',
      data: formData,  // Use formData instead of JSON
      options: Options(
        contentType: 'multipart/form-data',  // Set content type to multipart/form-data
        headers: {
          'Accept': 'application/json',
        },
      ),
    );

    print('Login response: ${response.data}');

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
    print('DIO ERROR DETAILS:');
    print('Type: ${e.type}');
    print('Error Message: ${e.message}');
    print('Response Status Code: ${e.response?.statusCode}');
    print('Response Data: ${e.response?.data}');
    print('Request Path: ${e.requestOptions.path}');
    print('Request Data: ${e.requestOptions.data}');
    final errorMessage = _handleDioError(e);
    throw Exception(errorMessage);
  } catch (e) {
    print('Unexpected login error: $e');
    throw Exception('An unexpected error occurred');
  }
}

  Future<void> logout() async {
    try {
      final token = await _tokenStorage.getAccessToken();
      if (token != null) {
        await _dio.post(
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
    _dio.options.headers.remove('Authorization');
  }

  Future<String> signUp(UserModel user) async {
  try {
    // Add logging to see what's being sent
    log('Attempting signup with data: ${user.toJson()}');
    
    final response = await _dio.post(
      '/signup',
      data: user.toJson(),
      options: Options(
        contentType: 'application/json',
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );

    log('Signup response: ${response.data}');

    if (response.statusCode == 201 || response.statusCode == 200) {
      return response.data['message'] ?? 'Signup successful';
    } else {
      throw Exception(response.data['error'] ?? 'Signup failed');
    }
  } on DioException catch (e) {
    log('DioError during signup: ${e.message}');
    log('DioError response: ${e.response?.data}');
    final errorMessage = _handleDioError(e);
    throw Exception(errorMessage);
  } catch (e) {
    log('Unexpected signup error: $e');
    throw Exception('An unexpected error occurred during signup');
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
ApiServiceAuthentication apiService( ref) {
  return ApiServiceAuthentication();
}