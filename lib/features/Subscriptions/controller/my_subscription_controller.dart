import 'dart:developer';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Subscriptions/service/subscription_service.dart';

part 'my_subscription_controller.g.dart';

@riverpod
class MySubscriptionController extends _$MySubscriptionController {
  @override
  FutureOr<Map<String, dynamic>> build() async {
    log('Building MySubscriptionController');
    return await fetchSubscriptionStatus();
  }

  Future<Map<String, dynamic>> fetchSubscriptionStatus() async {
    try {
      final subscriptionService = SubscriptionService();
      final status = await subscriptionService.getSubscriptionStatus();
      log('Fetched subscription status: $status');
      return status;
    } catch (e) {
      log('Error in _fetchSubscriptionStatus: $e');
      throw Exception('Failed to fetch subscription status: $e');
    }
  }
}