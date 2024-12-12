import 'dart:async';
import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Subscriptions/model/plan_model.dart';
import 'package:hand_car/features/Subscriptions/service/plan_service.dart';

part 'subscription_controller.g.dart';

@riverpod
class PlanNotifier extends _$PlanNotifier {
  @override
  Future<List<PlanModel>> build(String serviceType) async {
    log('Building PlanNotifier for service type: $serviceType'); // Debug log
    return await _fetchPlans(serviceType);
  }

  Future<List<PlanModel>> _fetchPlans(String serviceType) async {
    try {
      final plans = await PlanServices.getPlans(serviceType);
      log('Fetched ${plans.length} plans'); // Debug log
      return plans;
    } catch (e) {
      log('Error in _fetchPlans: $e'); // Debug log
      throw Exception('Failed to fetch plans: $e');
    }
  }
}