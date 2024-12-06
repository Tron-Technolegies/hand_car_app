import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Subscriptions/controller/model/plan_model.dart';
import 'package:hand_car/features/Subscriptions/service/plan_service.dart';

part 'subscription_controller.g.dart';

@riverpod
class PlanNotifier extends _$PlanNotifier {
  Future<PlanModel> build() async {
    // Initial loading of plans
    return await _fetchPlans();
  }

  Future<PlanModel> _fetchPlans() async {
    try {
      return await PlanServices.getSubscription();
    } catch (e) {
      // Handle error - you might want to log this or handle more specifically
      throw Exception('Failed to fetch plans: $e');
    }
  }

  // Method to manually refresh plans
  Future<void> refreshPlans() async {
    // Set state to loading
    state = const AsyncValue.loading();

    try {
      final plans = await _fetchPlans();
      state = AsyncValue.data(plans);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}