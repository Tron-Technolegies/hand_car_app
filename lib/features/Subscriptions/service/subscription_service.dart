import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'dart:developer';

class SubscriptionService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => status! < 500,
  ));

  Future<Map<String, dynamic>> getSubscriptionStatus() async {
    try {
      final token = TokenStorage().getAccessToken();
      if (token == null) {
        throw Exception('Please login to continue');
      }
      final response = await dio.get(
        '/get_subscription_status',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      log('API Response: ${response.data}');
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      log('Dio Error: ${e.message}');
      log('Error Response: ${e.response?.data}');
      throw Exception('Failed to fetch subscription status: ${e.message}');
    }
  }
}