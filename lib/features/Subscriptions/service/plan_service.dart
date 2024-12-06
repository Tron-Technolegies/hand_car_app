import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Subscriptions/controller/model/plan_model.dart';

class PlanServices {
  static final Dio _dio = Dio(
  BaseOptions(
    baseUrl: baseUrl,
    headers: {
      'Content-Type': 'application/json',
    },
  )
  );

  static Future<PlanModel> getSubscription() async {
    try {
      final response = await _dio.get('/subscribe/');
      return PlanModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception('Failed to fetch products: ${e.message}');
    }
  }
}