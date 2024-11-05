import 'package:dio/dio.dart';
import 'package:hand_car/core/utils/snackbar.dart';

class ApiServicesAuthentication {
  static final _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.50:8000',
    connectTimeout: const Duration(seconds: 10),
    contentType: 'application/json',
    validateStatus: (status) => true,
     // Allow all status codes for debugging
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  static Future<bool> loginWithEmailAndPassword(
      String phone, String password) async {
    try {
      final response = await _dio.post(
        '/login/password/',
        data: {
          "phone": phone,
      "password": password,
    },
  );

  if (response.statusCode == 200) {
    print(response.data);
    // Login successful, proceed with navigation or success actions
  } else if (response.statusCode == 404) {
    // Handle user not found specifically
    print("Login failed with status 404: User does not exist");
    SnackbarUtil.showsnackbar(
      message: "User does not exist. Please check your credentials.",
      showretry: false,
    );
  } else {
    // Handle other error responses
    print("Login failed with status ${response.statusCode}");
    SnackbarUtil.showsnackbar(
      message: "An error occurred. Please try again.",
      showretry: true,
    );
  }
} catch (e) {
  print("Login error: $e");
  SnackbarUtil.showsnackbar(
    message: "A network error occurred. Please check your connection.",
    showretry: true,
  );
}
    return false;

  }
 static  Future<bool> loginWithOtp(String phone, String otp) async {
    try {
      final response = await _dio.post(
        '/login_with_otp', // Adjust this endpoint if it differs
        data: {
          "phone": phone,
          "otp": otp,
        },
      );

      if (response.statusCode == 200) {
        print("Login successful: ${response.data}");
        return true;
      } else if (response.statusCode == 404) {
        print("User does not exist: ${response.data}");
        return false;
      } else {
        print("Failed to log in: ${response.data}");
        return false;
      }
    } catch (e) {
      print("Dio error: $e");
      return false;
    }
  }

  static  Future<bool> sendOtp(String phone) async {
    try {
      final response = await _dio.post(
        '/send_otp', // Adjust endpoint
        data: {"phone": phone},
      );
      return response.statusCode == 200;
    } catch (e) {
      print("Error sending OTP: $e");
      return false;
    }
  }
}

