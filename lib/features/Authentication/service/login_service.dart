import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';

class ApiServiceAuthentication {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

 static Future<Map<String, dynamic>> login(String phone, String password) async {
    try {
      final response = await _dio.post(
        '/login/password/',
        data: FormData.fromMap({
          'phone': phone,
          'password': password,
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        // Ensure token is saved
        if (response.data['token'] != null) {
          await AuthManager.saveAuthToken(response.data['token']);
        }
        
        // Save user data if available
        if (response.data['user'] != null) {
          await AuthManager.saveUserData(response.data['user']);
        }
        
        return {'success': true, 'message': response.data['message'] ?? 'Login successful'};
      }
      return {'success': false, 'error': response.data['error'] ?? 'Login failed'};
    } on DioException catch (e) {
      return {'success': false, 'error': _handleDioError(e)};
    }
  }

  static Future<Map<String, dynamic>> signUp(
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
        // Save auth token if provided
        if (response.data['token'] != null) {
          await AuthManager.saveAuthToken(response.data['token']);
        }
        
        // Save user data if available
        if (response.data['user'] != null) {
          await AuthManager.saveUserData(response.data['user']);
        }
        
        return {
          'success': true,
          'message': 'Signup successful!',
        };
      }
      return {
        'success': false,
        'error': response.data['error'] ?? 'Signup failed',
      };
    } on DioException catch (e) {
      return {'success': false, 'error': _handleDioError(e)};
    }
  }

  static String _handleDioError(DioException e) {
    if (e.response != null) {
      return e.response!.data['error'] ?? 'An error occurred';
    }
    return 'Network error';
  }
}