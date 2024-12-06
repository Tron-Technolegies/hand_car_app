import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/controller/subscription_controller.dart';
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Building BasePlanScreen for service type: $serviceType'); // Debug log

    final selectedIndex = useState(0);
    final selectedDurationIndex = useState(0);
    final scrollController = useScrollController();

    final plansAsyncValue = ref.watch(planNotifierProvider(serviceType));

    return Scaffold(
      extendBody: true,
      body: plansAsyncValue.when(
        loading: () {
          print('Loading plans...'); // Debug log
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Loading plans...'),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          print('Error loading plans: $error'); // Debug log
          print('Stack trace: $stackTrace'); // Debug log
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${error.toString()}'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    ref.refresh(planNotifierProvider(serviceType));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
        data: (plans) {
          print('Received ${plans.length} plans'); // Debug log
          if (plans.isEmpty) {
            print('No plans available for $serviceType'); // Debug log
            return const Center(
              child: Text('No plans available for this service type'),
            );
          }

          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(gradient: backgroundGradient),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(context.space.space_250),
                  child: Column(
                    children: [
                      Text(
                        screenTitle,
                        style: context.typography.h3,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.space.space_150),
                      Text(
                        screenDescription,
                        style: context.typography.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: context.space.space_250),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: plans.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: context.space.space_250),
                        itemBuilder: (context, index) {
                          final plan = plans[index];
                          print('Building plan card for: ${plan.name}'); // Debug log

                          return PlansContainer(
                            planName: plan.name,
                            price: plan.price,
                            duration: plan.duration,
                            planFeature1: plan.description,
                            color: primaryColor,
                            containerColor: containerColor,
                            textColor1: primaryColor,
                            textColor2: secondaryColor,
                            selectedDuration: selectedDurationIndex.value,
                            planFeature2: '',
                            child: index == 1 ? const PopularTextConainerWidget() : null,
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