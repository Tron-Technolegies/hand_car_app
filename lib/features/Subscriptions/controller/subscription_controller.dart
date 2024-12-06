import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Subscriptions/controller/model/plan_model.dart';
import 'package:hand_car/features/Subscriptions/service/plan_service.dart';

part 'subscription_controller.g.dart';

@riverpod
class PlanNotifier extends _$PlanNotifier {
  @override
  Future<List<PlanModel>> build(String serviceType) async {
    print('Building PlanNotifier for service type: $serviceType'); // Debug log
    return await _fetchPlans(serviceType);
  }

  Future<List<PlanModel>> _fetchPlans(String serviceType) async {
    try {
      final plans = await PlanServices.getPlans(serviceType);
      print('Fetched ${plans.length} plans'); // Debug log
      return plans;
    } catch (e) {
      print('Error in _fetchPlans: $e'); // Debug log
      throw Exception('Failed to fetch plans: $e');
    }
  }
}