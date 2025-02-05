import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/core/service/base_api_service.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'authentication_service.g.dart';

class ApiServiceAuthentication extends BaseApiService {
  ApiServiceAuthentication() : super();

  bool compareTokens(String accessToken, String refreshToken) {
    try {
      // Log the full tokens
      log('Full Tokens Comparison:'
          '\nAccess Token: $accessToken'
          '\nRefresh Token: $refreshToken');

      // Split tokens into parts
      final accessParts = accessToken.split('.');
      final refreshParts = refreshToken.split('.');

      if (accessParts.length != 3 || refreshParts.length != 3) {
        log('Invalid token format - expected 3 parts (header.payload.signature)');
        return false;
      }

      // Get the decoded payloads using TokenStorage's method
      final accessPayload = tokenStorage.decodeJwtPayload(accessParts[1]);
      final refreshPayload = tokenStorage.decodeJwtPayload(refreshParts[1]);

      // Log decoded parts
      log('Decoded Token Parts:'
          '\nAccess Token Header: ${tokenStorage.decodeJwtPayload(accessParts[0])}'
          '\nAccess Token Payload: $accessPayload'
          '\nAccess Token Signature: ${accessParts[2]}'
          '\n\nRefresh Token Header: ${tokenStorage.decodeJwtPayload(refreshParts[0])}'
          '\nRefresh Token Payload: $refreshPayload'
          '\nRefresh Token Signature: ${refreshParts[2]}');

      // Compare key identifiers
      bool sameUser = accessPayload['user_id'] == refreshPayload['user_id'];

      // Log comparison results
      log('Token Comparison Results:'
          '\nAccess Token User ID: ${accessPayload['user_id']}'
          '\nRefresh Token User ID: ${refreshPayload['user_id']}'
          '\nTokens match: $sameUser'
          '\nAccess Token Expiry: ${DateTime.fromMillisecondsSinceEpoch(accessPayload['exp'] * 1000)}'
          '\nRefresh Token Expiry: ${DateTime.fromMillisecondsSinceEpoch(refreshPayload['exp'] * 1000)}');

      return sameUser;
    } catch (e) {
      log('Error comparing tokens: $e');
      return false;
    }
  }

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
        ),
      );

      log('Login response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        log('Login successful, parsing response...');
        final authModel = AuthModel.fromJson(response.data);

        // Add token comparison check
        if (!compareTokens(authModel.accessToken, authModel.refreshToken)) {
          log('Warning: Access and Refresh tokens mismatch');
          throw Exception('Token validation failed');
        }

        log('Saving tokens to storage...');
        await tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
        
        // Verify saved tokens
        if (!tokenStorage.hasValidTokens) {
          throw Exception('Token verification failed after save');
        }

        log('Tokens saved and verified successfully');
        return authModel;
      }

      log('Login failed with status code: ${response.statusCode}');
      log('Error response: ${response.data}');
      throw handleApiError(response);
    });
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

  Future<UserModel> getCurrentUser() async {
    return withRetry(() async {
      try {
        log('Fetching current user...');
        final token = tokenStorage.getAccessToken();
        if (token == null) {
          log('No access token found');
          throw Exception('Authentication token not found');
        }

        final response = await dio.get(
          '/get_logged_in_user',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
              'Cookie': 'access_token=$token',
            },
            extra: {
              'withCredentials': true,
            },
          ),
        );

        log('Current user response status: ${response.statusCode}');

        if (response.statusCode == 200 && response.data != null) {
          final userData = response.data;
          log('User data received: $userData');

          if (userData is Map<String, dynamic>) {
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
              throw Exception('Failed to parse user data: $e');
            }
          }
          throw Exception('Invalid response format: ${response.data}');
        }

        log('Failed to get user data: ${response.data}');
        throw handleApiError(response);
      } on DioException catch (e) {
        log('DioException getting user: ${e.message}');
        log('DioException response: ${e.response?.data}');

        if (e.response?.statusCode == 401) {
          await tokenStorage.clearTokens();
          throw Exception('Authentication failed');
        }
        throw Exception(e.message ?? 'Failed to get user');
      } catch (e) {
        log('Unexpected error getting user: $e');
        throw Exception('Failed to get user: $e');
      }
    });
  }

  Future<String> signUp(UserModel user) async {
    return withRetry(() async {
      final response = await dio.post(
        '/signup/',
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data['message'] ?? 'Signup successful';
      }
      throw handleApiError(response);
    });
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
          name: '${response.data['user']['first_name']} ${response.data['user']['last_name']}'.trim(),
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