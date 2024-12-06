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
    ),
  );

  static Future<List<PlanModel>> getPlans(String serviceType) async {
    try {
      print('Fetching plans for service type: $serviceType'); // Debug log
      final response = await _dio.get(
        '/view_plans',
        queryParameters: {'service_type': serviceType},
      );
      print('API Response: ${response.data}'); // Debug log

      final planResponse = PlanResponse.fromJson(response.data);

      final filteredPlans = planResponse.plan.where((plan) {
        final normalizedServiceType = plan.serviceType.trim().toLowerCase();
        final normalizedInput = serviceType.replaceAll('_', '').trim().toLowerCase();
        return normalizedServiceType == normalizedInput;
      }).toList();

      print('Filtered Plans: $filteredPlans'); // Debug log
      return filteredPlans;
    } on DioException catch (e) {
      print('Dio Error: ${e.message}'); // Debug log
      print('Error Response: ${e.response?.data}'); // Debug log
      throw Exception('Failed to fetch plans: ${e.message}');
    }
  }
}