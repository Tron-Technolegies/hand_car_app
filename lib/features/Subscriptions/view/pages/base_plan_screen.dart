import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/controller/subscription_controller.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/duration_button_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/plans_container_widget.dart';
import 'package:hand_car/features/Subscriptions/view/widgets/popular_text_container_widegr.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BasePlanScreen extends HookConsumerWidget {
  final String serviceType;

  const BasePlanScreen({
    required this.serviceType,
    super.key,
  });

  String get screenTitle;
  String get screenDescription;
  LinearGradient get backgroundGradient;
  Color get primaryColor;
  Color get secondaryColor;
  Color get containerColor;

  // Duration button colors
  Color get durationButtonColor;
  Color get durationButtonTextColor1;
  Color get durationButtonTextColor2;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('Building BasePlanScreen for service type: $serviceType');

    final selectedDurationIndex = useState(0);
    final scrollController = useScrollController();

    final plansAsyncValue = ref.watch(planNotifierProvider(serviceType));

    return Scaffold(
      extendBody: true,
      body: plansAsyncValue.when(
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text('Loading plans...'),
            ],
          ),
        ),
        error: (error, stackTrace) {
          log('Error loading plans: $error');
          log('Stack trace: $stackTrace');
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${error.toString()}'),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
        data: (plans) {
          log('Received ${plans.length} plans');
          if (plans.isEmpty) {
            return const Center(
              child: Text('No plans available for this service type'),
            );
          }

          // Determine target duration based on selection
          final int targetDuration;
          if (selectedDurationIndex.value == 0) {
            targetDuration = 6;
          } else {
            targetDuration = 12;
          }

          log('Selected duration: $targetDuration months');
          final filteredPlans = plans.where((plan) {
            // Convert both to integers for comparison
            final planDuration = int.tryParse(plan.duration.toString());
            return planDuration == targetDuration;
          }).toList();

          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(gradient: backgroundGradient),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        screenTitle,
                        style: context.typography.h2.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        screenDescription,
                        style: context.typography.body.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          DurationButtons(
                            selectedIndex: selectedDurationIndex.value,
                            onSelectPlan: (index) {
                              selectedDurationIndex.value = index;
                            },
                            containerColor: durationButtonColor,
                            textColor1: durationButtonTextColor1,
                            textColor2: durationButtonTextColor2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      if (filteredPlans.isEmpty)
                        Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Text(
                            'No plans available for $targetDuration months',
                            style: context.typography.bodyLarge
                                .copyWith(color: Colors.white),
                          ),
                        )
                      else
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredPlans.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 16),
                          itemBuilder: (context, index) {
                            final plan = filteredPlans[index];
                            return PlansContainer(
                              planName: plan.name,
                              price: plan.price,
                              duration: plan.duration,
                              description: plan.description ?? '',
                              color: primaryColor,
                              containerColor: containerColor,
                              textColor1: primaryColor,
                              textColor2: secondaryColor,
                              child: index == 1
                                  ? const PopularTextConainerWidget()
                                  : null,
                            );
                          },
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
