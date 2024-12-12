import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Subscriptions/model/plan_model.dart';

class PlanServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<List<PlanModel>> getPlans(String serviceType) async {
    try {
      log('Fetching plans for service type: $serviceType'); // Debug log
      final response = await _dio.get(
        '/view_plans',
        queryParameters: {'service_type': serviceType},
      );
      log('API Response: ${response.data}'); // Debug log

      final planResponse = PlanResponse.fromJson(response.data);

      final filteredPlans = planResponse.plan.where((plan) {
        final normalizedServiceType = plan.serviceType.trim().toLowerCase();
        final normalizedInput = serviceType.replaceAll('_', '').trim().toLowerCase();
        return normalizedServiceType == normalizedInput;
      }).toList();

      log('Filtered Plans: $filteredPlans'); // Debug log
      return filteredPlans;
    } on DioException catch (e) {
      log('Dio Error: ${e.message}'); // Debug log
      log('Error Response: ${e.response?.data}'); // Debug log
      throw Exception('Failed to fetch plans: ${e.message}');
    }
  }
}