
import 'package:flutter/material.dart';
import 'package:hand_car/features/Subscriptions/view/pages/base_plan_screen.dart';

class CarWashPlanScreen extends BasePlanScreen {
  const CarWashPlanScreen({super.key}) : super(serviceType: 'Car Wash');

  @override
  String get screenTitle => 'A Plan for Every Car Washing Need';

  @override
  String get screenDescription =>
      'Whether its a quick rinse or a detailed clean, we offer customized services to meet every car washing need. Experience the difference with our specialized care and attention to detail.';

  @override
  LinearGradient get backgroundGradient => const LinearGradient(
        colors: [Color(0xFFDA1E21), Color(0xFFF77577)],
      );

  @override
  Color get primaryColor => const Color(0xFFDA1E21);

  @override
  Color get secondaryColor => const Color(0xFFF77577);

  @override
  Color get containerColor => const Color(0xFFF5E1E1);

  // Override for duration button
  @override
  Color get durationButtonColor => const Color(0xffFFD9D9); // Light Blue
  @override
  Color get durationButtonTextColor1 => const Color(0xffDA1E21); // Dark Blue
  @override
  Color get durationButtonTextColor2 => const Color(0xffE7696B); // Medium Blue
}
