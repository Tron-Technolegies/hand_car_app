import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/view/pages/car_wash_subscription.dart';
import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';

class SubscriptionPage extends HookWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    // Use useState to re-render when active index changes
    final activeIndex = useState(0); 

    useEffect(() {
      // Listener to update active index on tab changes
      void onTabChanged() {
        activeIndex.value = tabController.index;
      }

      tabController.addListener(onTabChanged);
      return () => tabController.removeListener(onTabChanged);
    }, [tabController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subscription'),
        centerTitle: true,
        bottom: TabBar(
          controller: tabController,
          indicatorColor: activeIndex.value == 1 ? context.colors.primaryTxt : context.colors.primary,
          labelColor: activeIndex.value == 1 ? context.colors.primaryTxt : context.colors.primary,
          labelStyle: context.typography.bodyLarge,
          unselectedLabelColor: context.colors.primaryTxt.withOpacity(0.5),
          unselectedLabelStyle: context.typography.bodyLarge,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Car Wash'),
            Tab(text: 'Car Maintainance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          CarWashPlanScreen(),
          ServicePlanScreen(),
        ],
      ),
    );
  }
}