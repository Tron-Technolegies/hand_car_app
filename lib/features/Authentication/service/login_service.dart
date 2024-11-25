// api_service.dart


import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';

class ApiServiceAuthentication {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
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

  //login with phone and password
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
        return {'success': true, 'message': response.data['message']};
      } 
      return {'success': false, 'error': response.data['error']};

    } on DioException catch (e) {
      return {'success': false, 'error': _handleDioError(e)};
    }
  }



  static String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Error ${e.response?.statusCode}: ${e.response?.data['error'] ?? 'Unknown error'}';
    }
    return 'Network error: ${e.message}';
  }
}
