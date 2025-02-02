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
      final formData = FormData.fromMap({
        'username': username,
        'password': password,
      });

      final response = await dio.post(
        '/UserLogin',
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );

      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);
        await tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );
        return authModel;
      }
      throw _handleApiError(response);
    });
  }

  Future<void> sendOtp(String phoneNumber) async {
    return withRetry(() async {
      final response = await dio.post(
        '/send-otp/',
        data: {'phone': phoneNumber},
      );
      if (response.statusCode != 200) {
        throw _handleApiError(response);
      }
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
      throw _handleApiError(response);
    });
  }

  Future<UserModel> getCurrentUser() async {
  return withRetry(() async {
    try {
      log('Fetching current user...');
      final response = await dio.get(
        '/get_logged_in_user',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      log('Current user response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final userData = response.data;
        
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
            throw Exception('Failed to parse user data');
          }
        }
        throw Exception('Invalid response format: ${response.data}');
      }
      throw handleApiError(response);
    } on DioException catch (e) {
      log('DioException getting user: ${e.message}');
      log('DioException response: ${e.response?.data}');
      
      if (e.response?.statusCode == 401) {
        // Token might be invalid/expired
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
    
      final response = await dio.post(
        '/signup/',
        data: user.toJson(),
      );

      if (response.statusCode == 200) {
        return response.data['message'] ?? 'Signup successful';
      }
      throw _handleApiError(response);
    
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
              'Cookie': 'access_token=$token'
            },
          ),
        );

        if (response.statusCode != 200) {
          log('Logout request failed: ${response.statusCode}');
          throw handleApiError(response);
        }
      }
    } catch (e) {
      log('Error during logout: $e');
      // Continue with local cleanup even if server request fails
    } finally {
      // Always perform local cleanup
      await _performLocalLogout();
    }
  }

  Future<void> _performLocalLogout() async {
    try {
      // Clear tokens from storage
      await tokenStorage.clearTokens();
      
      // Clear Dio headers
      dio.options.headers.remove('Authorization');
      dio.options.headers.remove('Cookie');
      
      // Reset Dio to initial state
      dio.interceptors.clear();
        // Re-setup clean interceptors
      
      // Optional: Clear any other local storage or state
      // await GetStorage().erase();  // If you want to clear all storage
      
      log('Local logout cleanup completed');
    } catch (e) {
      log('Error during local logout cleanup: $e');
      throw Exception('Failed to complete logout cleanup');
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
      throw _handleApiError(response);
    });
  }

  Future<void> requestPasswordReset(String email) async {
    return withRetry(() async {
      final response = await dio.post(
        '/forgot_password/',
        data: {'email': email},
      );
      if (response.statusCode != 200) {
        throw _handleApiError(response);
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
        throw _handleApiError(response);
      }
    });
  }

  Exception _handleApiError(Response response) {
    final message = response.data?['error'] ?? response.data?['detail'];
    return Exception(message ?? 'Operation failed');
  }

  bool get isAuthenticated => tokenStorage.hasValidTokens;
}

@riverpod
ApiServiceAuthentication apiService(ref) {
  return ApiServiceAuthentication();
}
