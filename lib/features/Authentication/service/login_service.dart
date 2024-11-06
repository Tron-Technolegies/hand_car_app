import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/core/utils/snackbar.dart';

class ApiServicesAuthentication {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'http://192.168.1.56:8000',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  //Signup With Name Email Phone Password

  static Future<bool> signUp(
      String name, String email, String phone, String password) async {
    try {
      log("Sending signup request");
      log("Payload: name=$name, email=$email, phone=$phone");

      final response = await _dio.post(
        '/signup/',
        data: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": password,
        },
      );

      log("Response status: ${response.statusCode}");
      log("Response data: ${response.data}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      }

      final message =
          response.data['message'] ?? response.data['error'] ?? 'Signup failed';
      SnackbarUtil.showsnackbar(message: message, showretry: false);
      return false;
    } on DioException catch (e) {
      log("DioError: ${e.type}");
      log("DioError message: ${e.message}");
      log("DioError response: ${e.response?.data}");

      String errorMessage = 'Network error occurred';

      if (e.response != null) {
        // Handle specific API error responses
        if (e.response?.statusCode == 400) {
          errorMessage = e.response?.data['message'] ??
              e.response?.data['error'] ??
              'Invalid data provided';
        } else if (e.response?.statusCode == 409) {
          errorMessage = 'User already exists';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timed out';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection';
      }

      SnackbarUtil.showsnackbar(
        message: errorMessage,
        showretry: true,
      );
      return false;
    } catch (e) {
      log("General error during signup: $e");
      SnackbarUtil.showsnackbar(
        message: "An unexpected error occurred",
        showretry: true,
      );
      return false;
    }
  }
//Login with Phone Password
  static Future<bool> loginWithPassword(String phone, String password) async {
    try {
      final response = await _dio.post(
        '/login/password/',
        data: {
          'phone': phone,
          'password': password,
        },
      );

      log("Response status: ${response.statusCode}");
      log("Response data: ${response.data}");

      if (response.statusCode == 200) {
        return true;
      }

      final message =
          response.data['message'] ?? response.data['error'] ?? 'Login failed';
      SnackbarUtil.showsnackbar(message: message, showretry: false);
      return false;
    } on DioException catch (e) {
      log("DioError: ${e.type}");
      log("DioError message: ${e.message}");
      log("DioError response: ${e.response?.data}");

      String errorMessage = 'Network error occurred';

      if (e.response != null) {
        if (e.response?.statusCode == 401) {
          errorMessage = 'Invalid credentials';
        } else if (e.response?.statusCode == 400) {
          errorMessage = e.response?.data['message'] ??
              e.response?.data['error'] ??
              'Invalid data provided';
        }
      } else if (e.type == DioExceptionType.connectionTimeout) {
        errorMessage = 'Connection timed out';
      } else if (e.type == DioExceptionType.connectionError) {
        errorMessage = 'No internet connection';
      }

      SnackbarUtil.showsnackbar(
        message: errorMessage,
        showretry: true,
      );
      return false;
    } catch (e) {
      log("General error during login: $e");
      SnackbarUtil.showsnackbar(
        message: "An unexpected error occurred",
        showretry: true,
      );
      return false;
    }
  }

}
