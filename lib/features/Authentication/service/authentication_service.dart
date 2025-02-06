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
      // Log tokens check start
      log('Starting token comparison...');

      // Split tokens into parts
      final accessParts = accessToken.split('.');
      final refreshParts = refreshToken.split('.');

      if (accessParts.length != 3 || refreshParts.length != 3) {
        log('Invalid token format - expected 3 parts (header.payload.signature)');
        return false;
      }

      final accessPayload = tokenStorage.decodeJwtPayload(accessParts[1]);
      final refreshPayload = tokenStorage.decodeJwtPayload(refreshParts[1]);

      // Compare user IDs and validate expiration
      bool sameUser = accessPayload['user_id'] == refreshPayload['user_id'];
      final accessExpiry =
          DateTime.fromMillisecondsSinceEpoch(accessPayload['exp'] * 1000);
      final refreshExpiry =
          DateTime.fromMillisecondsSinceEpoch(refreshPayload['exp'] * 1000);
      final now = DateTime.now();

      // Log token details
      log('Token Comparison Results:'
          '\nAccess Token User ID: ${accessPayload['user_id']}'
          '\nRefresh Token User ID: ${refreshPayload['user_id']}'
          '\nTokens match: $sameUser'
          '\nAccess Token Expiry: $accessExpiry'
          '\nRefresh Token Expiry: $refreshExpiry');

      return sameUser &&
          accessExpiry.isAfter(now) &&
          refreshExpiry.isAfter(now);
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
          validateStatus: (status) => true,
        ),
      );

      log('Login response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final authModel = AuthModel.fromJson(response.data);

        // Validate tokens
        if (!compareTokens(authModel.accessToken, authModel.refreshToken)) {
          log('Warning: Token validation failed');
          throw Exception('Token validation failed');
        }

        // Save tokens to storage
        await tokenStorage.saveTokens(
          accessToken: authModel.accessToken,
          refreshToken: authModel.refreshToken,
        );

        // Update dio default headers
        _updateDioHeaders(authModel.accessToken);

        log('Login successful - tokens saved and verified');
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

        // Check if tokens are valid
        if (!tokenStorage.hasValidTokens) {
          log('No valid tokens available, attempting to refresh');

          // Check if refresh token is expired
          if (tokenStorage.isRefreshTokenExpired()) {
            log('Refresh token is expired');
            await tokenStorage.clearTokens();
            throw Exception('Authentication expired. Please log in again.');
          }

          // Attempt to refresh access token
          final refreshSuccess = await refreshToken();
          if (!refreshSuccess) {
            log('Token refresh failed');
            await tokenStorage.clearTokens();
            throw Exception(
                'Failed to refresh authentication. Please log in again.');
          }
        }

        // Get the current valid access token after potential refresh
        final currentToken = tokenStorage.getAccessToken();
        if (currentToken == null) {
          log('No valid access token found after refresh');
          await tokenStorage.clearTokens();
          throw Exception('Authentication expired. Please log in again.');
        }

        // Perform user fetch with retry mechanism
        try {
          final response = await dio.get(
            '/get_logged_in_user',
            options: Options(
              headers: {
                'Authorization': 'Bearer $currentToken',
                'Cookie': 'access_token=$currentToken',
              },
              validateStatus: (status) => true,
              extra: {
                'withCredentials': true,
              },
            ),
          );

          log('Get user response status: ${response.statusCode}');
          log('Get user response data: ${response.data}');

          // Handle different response scenarios
          switch (response.statusCode) {
            case 200:
              if (response.data != null) {
                return _parseUserResponse(response.data);
              }
              throw Exception('Empty user data received');

            case 401:
              log('Authentication failed: ${response.data}');
              await tokenStorage.clearTokens();
              throw Exception('Authentication expired. Please log in again.');

            default:
              log('Unexpected response: ${response.statusCode}');
              throw handleApiError(response);
          }
        } on DioException catch (dioError) {
          // Handle Dio-specific errors
          if (dioError.response?.statusCode == 401) {
            log('Unauthorized access during user fetch');
            await tokenStorage.clearTokens();
            throw Exception('Authentication failed. Please log in again.');
          }
          rethrow;
        }
      } catch (e) {
        log('Comprehensive error in getCurrentUser: $e');

        // Additional error handling
        if (e is DioException) {
          if (e.response?.statusCode == 401) {
            await tokenStorage.clearTokens();
          }
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
        data: userData, // Sending as JSON
        options: Options(
          contentType:
              Headers.jsonContentType, // Explicitly set JSON content type
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
