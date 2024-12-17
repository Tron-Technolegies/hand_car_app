import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
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
        onError: (error, handler) {
          if (error.response?.statusCode == 401) {
            // Handle token expiration
            _handleTokenExpiration(error);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<void> _handleTokenExpiration(DioException error) async {
    // Get refresh token
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await logout();
      throw 'Session expired. Please login again.';
    }

    try {
      final response = await _dio.post(
        '/refresh-token/',
        data: {'refresh_token': refreshToken},
      );

      final newAuthModel = AuthModel.fromJson(response.data);
      await _tokenStorage.saveTokens(
        accessToken: newAuthModel.accessToken,
        refreshToken: newAuthModel.refreshToken,
      );
    } catch (e) {
      await logout();
      throw 'Session expired. Please login again.';
    }
  }

  Future<AuthModel> login(String username, String password) async {
    try {
      final response = await _dio.post(
        '/login/',
        data: {
          'username': username,
          'password': password,
        },
      );

      final authModel = AuthModel.fromJson(response.data);
      await _tokenStorage.saveTokens(
        accessToken: authModel.accessToken,
        refreshToken: authModel.refreshToken,
      );

      return authModel;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<AuthModel> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/signup/',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        },
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);
        await _tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
        return authModel;
      }

      throw 'Signup failed: ${response.data['error'] ?? 'Unknown error'}';
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> logout() async {
    try {
      // Call logout endpoint if your API has one
      await _dio.post('/logout/');
    } catch (e) {
      // Ignore errors during logout
    } finally {
      await _tokenStorage.clearTokens();
    }
  }

  String _handleDioError(DioException e) {
    if (e.response != null) {
      if (e.response?.statusCode == 401) {
        return 'Invalid credentials';
      }
      if (e.response?.statusCode == 422) {
        return 'Invalid input data';
      }
      return e.response?.data['error'] ?? 'An error occurred';
    }
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    }
    if (e.type == DioExceptionType.receiveTimeout) {
      return 'Server is not responding. Please try again.';
    }
    return 'Network error occurred. Please try again.';
  }

  bool get isAuthenticated => _tokenStorage.hasTokens;
}

@riverpod
ApiServiceAuthentication apiService(Ref ref) {
  return ApiServiceAuthentication();
}
