import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/core/service/base_api_service.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_service.g.dart';

class ApiServiceAuthentication extends BaseApiService {
  ApiServiceAuthentication() : super();

  

  Future<AuthModel> login(String username, String password) async {
    return withRetry(() async {
      log('Starting login attempt for username: $username');

      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await dio.post(
        '/UserLogin',
        data: formData,
        options: Options(
          contentType: 'multipart/form-data',
          headers: {
            'Accept': 'application/json',
          },
          validateStatus: (status) => true,
        ),
      );

      log('Login response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);

        // Save tokens to storage
        await tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );

        // Update dio default headers
        _updateDioHeaders(authModel.accessToken);

        log('Login successful - tokens saved');
        return authModel;
      }

      log('Login failed: ${response.data}');
      throw handleApiError(response);
    });
  }

 
  Future<UserModel> getCurrentUser() async {
    return withRetry(() async {
      try {
        log('Fetching current user...');

        final currentToken = tokenStorage.getAccessToken();
        if (currentToken == null) {
          throw Exception('Authentication required. Please log in.');
        }

        final response = await dio.get(
          '/get_logged_in_user',
          options: Options(
            headers: {
              'Authorization': 'Bearer $currentToken',
              'Cookie': 'access_token=$currentToken',
            },
            validateStatus: (status) => true,
          ),
        );

        log('Get user response status: ${response.statusCode}');
        log('Get user response data: ${response.data}');

        if (response.statusCode == 200 && response.data != null) {
          return _parseUserResponse(response.data);
        }

        if (response.statusCode == 401) {
          await tokenStorage.clearTokens();
          throw Exception('Session expired. Please log in again.');
        }

        throw handleApiError(response);
      } catch (e) {
        log('Error in getCurrentUser: $e');
        if (e is DioException && e.response?.statusCode == 401) {
          await tokenStorage.clearTokens();
        }
        rethrow;
      }
    });
  }

  // Helper method to update Dio headers
  void _updateDioHeaders(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers['Cookie'] = 'access_token=$token';
  }

  // Helper method to parse user response
  UserModel _parseUserResponse(Map<String, dynamic> userData) {
    try {
      if (userData.containsKey('first_name')) {
        return UserModel(
          name: '${userData['first_name']} ${userData['last_name']}'.trim(),
          email: userData['email'] ?? '',
          phone: userData['phone'] ?? '',
          address: userData['address'],
          profileImage: userData['profile_image'],
        );
      }
      return UserModel.fromJson(userData);
    } catch (e) {
      log('Error parsing user data: $e');
      throw Exception('Failed to parse user data');
    }
  }

  Future<AuthModel> verifyOtp(String phoneNumber, String otp) async {
    return withRetry(() async {
      final response = await dio.post(
        '/login-with-otp/',
        data: {
          'phone': phoneNumber,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);
        await tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
        return authModel;
      }
      throw handleApiError(response);
    });
  }

  Future<void> sendOtp(String phoneNumber) async {
    return withRetry(() async {
      final response = await dio.post(
        '/send-otp/',
        data: {'phone': phoneNumber},
      );
      if (response.statusCode != 200) {
        throw handleApiError(response);
      }
    });
  }

  Future<void> signUp(UserModel user) async {
  
      try {
        final userData = {
          'name': user.name,
          'email': user.email,
          'phone': user.phone,
          'password': user.password,
        };

        log('Sending signup request with data: $userData');

        final response = await dio.post(
          '/signup',
          data: userData,  // Sending as JSON
          options: Options(
            contentType: Headers.jsonContentType,  // Explicitly set JSON content type
            headers: {
              'Accept': 'application/json',
            },
            validateStatus: (status) => true,
          ),
        );

        log('Signup response status: ${response.statusCode}');
        log('Signup response data: ${response.data}');

        if (response.statusCode == 201 || response.statusCode == 200) {
          log('Signup successful');
          return;
        }

        if (response.statusCode == 400) {
          final errorMessage = response.data['error'] ?? 'Signup failed';
          throw Exception(errorMessage);
        }

        throw handleApiError(response);
      } catch (e) {
        log('Error during signup: $e');
        rethrow;
      }
  
}

  Future<void> logout() async {
    try {
      final token = tokenStorage.getAccessToken();
      if (token != null) {
        final response = await dio.post(
          '/Logout',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode != 200) {
          log('Logout request failed: ${response.statusCode}');
          throw handleApiError(response);
        }
      }
    } finally {
      await _performLocalLogout();
    }
  }

  Future<void> _performLocalLogout() async {
    try {
      await tokenStorage.clearTokens();
      dio.options.headers.clear();
      setupInterceptors();
      log('Local logout completed');
    } catch (e) {
      log('Error during logout cleanup: $e');
      throw Exception('Failed to complete logout');
    }
  }

  Future<UserModel> updateUserProfile(UserModel profile) async {
    return withRetry(() async {
      final response = await dio.post(
        '/Edit_UserProfile_By_user',
        data: {
          'first_name': profile.name.split(' ').first,
          'last_name': profile.name.split(' ').skip(1).join(' '),
          'email': profile.email,
        },
      );

      if (response.statusCode == 200) {
        return UserModel(
          name:
              '${response.data['user']['first_name']} ${response.data['user']['last_name']}'
                  .trim(),
          email: response.data['user']['email'],
          phone: profile.phone,
          address: profile.address,
        );
      }
      throw handleApiError(response);
    });
  }

  Future<void> requestPasswordReset(String email) async {
    return withRetry(() async {
      final response = await dio.post(
        '/forgot_password/',
        data: {'email': email},
      );
      if (response.statusCode != 200) {
        throw handleApiError(response);
      }
    });
  }

  Future<void> resetPassword(String uid, String token, String password) async {
    return withRetry(() async {
      final response = await dio.post(
        '/reset_password/$uid/$token/',
        data: {'new_password': password},
      );
      if (response.statusCode != 200) {
        throw handleApiError(response);
      }
    });
  }

  bool get isAuthenticated => tokenStorage.hasValidTokens;
}

@riverpod
ApiServiceAuthentication apiService(ref) {
  return ApiServiceAuthentication();
}
