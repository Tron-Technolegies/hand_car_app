import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Subscriptions/model/subscription_model.dart';

class SubscriptionService {
  final Dio dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => status! < 500, // Accept all status codes less than 500
  ));

  
  Future<Map<String, dynamic>> getSubscriptionStatus() async {
    try {
      final token =TokenStorage().getAccessToken();
      if (token == null) {
        throw Exception('Please login to continue');
      }
      final response = await dio.get(
        '/subscribe/',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw Exception('Failed to fetch subscription status: ${e.message}');
    }
  }
 
}
