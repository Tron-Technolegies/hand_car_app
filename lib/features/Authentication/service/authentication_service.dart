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
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            sendTimeout: const Duration(seconds: 30),
            validateStatus: (status) => true,
          ),
        ),
        _tokenStorage = TokenStorage() {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = _tokenStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            // Set both cookie and Authorization header
            options.headers['Cookie'] = 'access_token=$token';
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          // Extract tokens from cookies if present
          String? accessToken =
              _extractCookie(response.headers['set-cookie'], 'access_token');
          String? refreshToken =
              _extractCookie(response.headers['set-cookie'], 'refresh_token');

          if (accessToken != null && refreshToken != null) {
            await _tokenStorage.saveTokens(
              accessToken: accessToken,
              refreshToken: refreshToken,
            );
          }
          return handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            try {
              await _refreshToken();
              final newToken = _tokenStorage.getAccessToken();
              if (newToken != null) {
                error.requestOptions.headers['Cookie'] =
                    'access_token=$newToken';
                error.requestOptions.headers['Authorization'] =
                    'Bearer $newToken';
                final response = await dio.fetch(error.requestOptions);
                return handler.resolve(response);
              }
            } catch (e) {
              log('Token refresh failed: $e');
              await _handleLogout();
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  String? _extractCookie(List<String>? cookies, String key) {
    if (cookies == null) return null;
    for (var cookie in cookies) {
      if (cookie.contains(key)) {
        final match = RegExp('$key=([^;]*)').firstMatch(cookie);
        if (match != null) {
          return match.group(1);
        }
      }
    }
    return null;
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final token = _tokenStorage.getAccessToken();
      if (token == null) {
        throw Exception('No access token available');
      }

      final response = await dio.get(
        '/get_logged_in_user',
        options: Options(
          headers: {
            'Cookie': 'access_token=$token',
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
          validateStatus: (status) => true,
        ),
      );

      log('User data response: ${response.data}');

      if (response.statusCode == 200) {
        return UserModel(
          name: '${response.data['first_name']} ${response.data['last_name']}'
              .trim(),
          email: response.data['email'] ?? '',
          phone: response.data['phone'] ?? '',
          address: response.data['address'],
          profileImage: response.data['profile_image'],
        );
      }

      throw Exception(response.data['detail'] ?? 'Failed to get user details');
    } on DioException catch (e) {
      _logDioError(e);
      throw Exception(_handleDioError(e));
    }
  }

  Future<void> _refreshToken() async {
    try {
      final refreshToken = _tokenStorage.getRefreshToken();
      if (refreshToken == null) {
        throw Exception('No refresh token available');
      }

      final response = await dio.post(
        '/api/token/refresh',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Cookie': 'refresh_token=$refreshToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        final accessToken = response.data['access'];
        if (accessToken != null) {
          await _tokenStorage.saveTokens(
            accessToken: accessToken,
            refreshToken: refreshToken, // Keep existing refresh token
          );
        } else {
          throw Exception('Invalid token refresh response');
        }
      } else {
        throw Exception('Token refresh failed');
      }
    } catch (e) {
      log('Error refreshing token: $e');
      throw Exception('Session expired');
    }
  }

  Future<AuthModel> login(String username, String password) async {
    return _withRetry(() async {
      try {
        log('LOGIN ATTEMPT - Username: $username');

        final formData = FormData.fromMap({
          'username': username,
          'password': password,
        });

        log('Sending FormData: ${formData.fields}');

        final response = await dio.post(
          '/UserLogin',
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
            headers: {'Accept': 'application/json'},
            receiveTimeout: const Duration(seconds: 45),
            sendTimeout: const Duration(seconds: 45),
            validateStatus: (status) => true,
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
        _logDioError(e);
        throw Exception(_handleDioError(e));
      } catch (e) {
        log('Unexpected login error: $e');
        throw Exception('An unexpected error occurred');
      }
    });
  }

  void _logDioError(DioException e) {
    log('DIO ERROR DETAILS:');
    log('Type: ${e.type}');
    log('Error Message: ${e.message}');
    log('Response Status Code: ${e.response?.statusCode}');
    log('Response Data: ${e.response?.data}');
    log('Request Path: ${e.requestOptions.path}');
    log('Request Data: ${e.requestOptions.data}');
  }

  Future<void> logout() async {
    try {
      final token = _tokenStorage.getAccessToken();
      if (token != null) {
        await _withRetry(() => dio.post(
              '/Logout/',
              options: Options(headers: {'Authorization': 'Bearer $token'}),
            ));
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
    return _withRetry(() async {
      final response = await dio.post(
        '/signup/',
        data: user.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Signup failed');
      }
      return response.data['message'] ?? 'Signup successful';
    });
  }

  Future<UserModel> updateUserProfile(UserModel updatedProfile) async {
    return _withRetry(() async {
      try {
        final formData = FormData.fromMap({
          'first_name': updatedProfile.name.split(' ').first,
          'last_name': updatedProfile.name.split(' ').length > 1
              ? updatedProfile.name.split(' ').skip(1).join(' ')
              : '',
          'email': updatedProfile.email,
          if (updatedProfile.profileImage != null)
            'profile_image':
                await MultipartFile.fromFile(updatedProfile.profileImage!),
        });

        final response = await dio.post(
          '/edit-user-profile/',
          data: formData,
          options: Options(
            contentType: 'multipart/form-data',
            headers: {'Accept': 'application/json'},
          ),
        );

        if (response.statusCode == 200) {
          return UserModel.fromJson(response.data['user']);
        } else {
          throw Exception(response.data['error'] ?? 'Profile update failed');
        }
      } on DioException catch (e) {
        throw Exception(_handleDioError(e));
      }
    });
  }

  Future<void> requestPasswordReset(String email) async {
    return _withRetry(() async {
      final response = await dio.post(
        '/forgot_password/',
        data: {'email': email},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Failed to send reset email');
      }
    });
  }

  Future<void> resetPassword(
      String uid, String token, String newPassword) async {
    return _withRetry(() async {
      final response = await dio.post(
        '/reset_password/$uid/$token/',
        data: {'new_password': newPassword},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Failed to reset password');
      }
    });
  }

  Future<void> sendOtp(String phoneNumber) async {
    return _withRetry(() async {
      final response = await dio.post(
        '/send-otp/',
        data: {'phone': phoneNumber},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode != 200) {
        throw Exception(response.data['error'] ?? 'Failed to send OTP');
      }
    });
  }

  Future<AuthModel> verifyOtp(String phoneNumber, String otp) async {
    return _withRetry(() async {
      final response = await dio.post(
        '/login-with-otp/',
        data: {
          'phone': phoneNumber,
          'otp': otp,
        },
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);
        await _tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
        return authModel;
      } else {
        throw Exception(response.data['error'] ?? 'OTP verification failed');
      }
    });
  }

  Future<T> _withRetry<T>(Future<T> Function() apiCall) async {
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
        return 'Connection timeout. Please check your internet and try again.';
      case DioExceptionType.sendTimeout:
        return 'Request timeout. Please try again.';
      case DioExceptionType.receiveTimeout:
        return 'Server is taking too long to respond. Please try again in a moment.';
      case DioExceptionType.badResponse:
        return 'Server returned an invalid response. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled';
      default:
        return 'Network error. Please check your connection and try again';
    }
  }

  bool get isAuthenticated => _tokenStorage.hasTokens;
}

@riverpod
ApiServiceAuthentication apiService(ref) {
  return ApiServiceAuthentication();
}
