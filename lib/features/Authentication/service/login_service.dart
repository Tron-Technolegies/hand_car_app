// api_service.dart

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiServiceAuthentication {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.33:8000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<Map<String, dynamic>> signUp(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    try {
      final response = await _dio.post(
        '/signup/',
        data: FormData.fromMap({
          'name': name,
          'email': email,
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Extract token from response

        return {
          'success': true,
          'message': 'Signup successful!',
        };
      } else {
        // If signup is successful but no token (might be a 201 response)
        return {
          'success': true,
          'message': 'Signup successful! Please login.',
        };
      }

      // Unexpected response
    } on DioException catch (e) {
      // Handle specific error cases
      if (e.response != null) {
        if (e.response?.statusCode == 400) {
          // Handle validation errors
          final errorData = e.response?.data;
          String errorMessage = 'Validation error';

          if (errorData is Map<String, dynamic>) {
            if (errorData.containsKey('error')) {
              errorMessage = errorData['error'];
            } else if (errorData.containsKey('message')) {
              errorMessage = errorData['message'];
            }
          }

          return {
            'success': false,
            'error': errorMessage,
          };
        }

        return {
          'success': false,
          'error':
              'Server error: ${e.response?.statusCode}. ${e.response?.data}',
        };
      }

      return {
        'success': false,
        'error': 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'An unexpected error occurred: $e',
      };
    }
  }
 Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        '/login/password/',
        data: FormData.fromMap({
          'phone': phone,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Assuming the session ID is returned in a field called "sessionid"
        final sessionId = response.data['sessionid'];

        if (sessionId != null) {
          // Save session ID to SharedPreferences
          await _saveSessionId(sessionId);
        }

        return {'success': true, 'message': response.data['message']};
      }

      return {'success': false, 'error': response.data['error']};
    } on DioException catch (e) {
      return {'success': false, 'error': _handleDioError(e)};
    }
  }

  // Helper method to save session ID
  Future<void> _saveSessionId(String sessionId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_id', sessionId);
    log('Session ID saved successfully');
  }

  // Helper method to retrieve session ID
  static Future<String?> getSessionId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_id');
  }



  // static Future<Map<String, dynamic>> getCart() async {
  //   try {
  //     final token = await AuthTokenService.getToken();
  //     if (token == null) {
  //       return {'success': false, 'error': 'Not authenticated'};
  //     }

  //     await setAuthToken(token);
  //     final response = await _dio.get('/cart/');

  //     return {
  //       'success': true,
  //       'cart': response.data['cart_items'],
  //       'total': response.data['total_price']
  //     };
  //   } on DioException catch (e) {
  //     return {'success': false, 'error': _handleDioError(e)};
  //   }
  // }

  static String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Error ${e.response?.statusCode}: ${e.response?.data['error'] ?? 'Unknown error'}';
    }
    return 'Network error: ${e.message}';
  }
}
