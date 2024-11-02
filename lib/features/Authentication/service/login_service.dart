import 'package:dio/dio.dart';

class ApiServicesAuthentication {
  static final _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.53:8000',
  ));
  static Future<bool> sendOtp(String phone) async {
    try {
      final response = await _dio.post(
        '/send_otp',
        data: {'phone': phone},
      );
      print(
          "Request URL: ${_dio.options.baseUrl}/send_otp"); // Log the full URL

      return response.statusCode == 200;
    } catch (e) {
      print("OTP Request Error: $e"); // Log the exact error
      return false;
    }
  }

  static Future<bool> verifyOtp(String phone, String otp) async {
    try {
      final response = await _dio.post(
        '/login_with_otp',
        data: {
          'phone': phone,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> completeRegistration(
      String phone, String name, String email) async {
    try {
      final response = await _dio.post(
        '/complete_registration',
        data: {
          'phone': phone,
          'name': name,
          'email': email,
        },
      );

      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> loginWithEmailAndPassword(
      String phone, String password) async {
    try {
      final response = await _dio.post('/login/password/',
          data: {'phone': phone, 'password': password});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
