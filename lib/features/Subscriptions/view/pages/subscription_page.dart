import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Subscriptions/controller/my_subscription_controller.dart';
import 'package:hand_car/features/Subscriptions/view/pages/car_wash_subscription.dart';
import 'package:hand_car/features/Subscriptions/view/pages/my_plan_screen.dart';
import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final GlobalKey<ScaffoldState> scaffoldKey5 = GlobalKey<ScaffoldState>();

class SubscriptionPage extends HookConsumerWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionAsync = ref.watch(mySubscriptionControllerProvider);

    return subscriptionAsync.when(
      data: (data) {
        final isSubscribed = data['subscribed'] as bool? ?? false;
        if (isSubscribed) {
          final plan = data['plan'] as Map<String, dynamic>? ?? {};
          final serviceType =
              (plan['category'] as String?)?.toLowerCase() ?? 'car_wash';
          return _buildSubscribedInterface(context, serviceType);
        } else {
          return _buildTabbedInterface(context);
        }
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Scaffold(
        body: Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildSubscribedInterface(BuildContext context, String serviceType) {
    final tabController = useTabController(initialLength: 2);
    final activeIndex = useState(0);

    useEffect(() {
      void onTabChanged() {
        activeIndex.value = tabController.index;
      }

      tabController.addListener(onTabChanged);
      return () => tabController.removeListener(onTabChanged);
    }, [tabController]);

    return Scaffold(
      key: scaffoldKey5,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(context.space.space_100),
          child: SvgPicture.asset(
            Assets.icons.handCarIcon,
            height: 30,
            width: 30,
          ),
        ),
        title: const Text('My Subscription'),
        centerTitle: true,
        actions: [],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: activeIndex.value == 1
              ? context.colors.primary
              : context.colors.primary,
          labelColor: activeIndex.value == 1
              ? context.colors.primary
              : context.colors.primary,
          labelStyle: context.typography.bodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor:
              context.colors.primaryTxt.withValues(alpha: 0.5),
          unselectedLabelStyle: context.typography.bodyLarge,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'My Plan'),
            Tab(text: 'Upgrade Plans'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: [
          MyPlanScreen(serviceType: serviceType),
          _buildComprehensiveUpgradeSection(context, serviceType),
        ],
      ),
    );
  }

  Widget _buildComprehensiveUpgradeSection(
      BuildContext context, String serviceType) {
    final tabController = useTabController(initialLength: 2);
    final activeIndex = useState(0);

    useEffect(() {
      void onTabChanged() {
        activeIndex.value = tabController.index;
      }

      tabController.addListener(onTabChanged);
      return () => tabController.removeListener(onTabChanged);
    }, [tabController]);

    return Column(
      children: [
        TabBar(
          controller: tabController,
          isScrollable: true,
          indicatorColor: context.colors.primary,
          labelColor: context.colors.primary,
          labelStyle: context.typography.bodyMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelColor:
              context.colors.primaryTxt.withValues(alpha: 0.6),
          unselectedLabelStyle: context.typography.bodyMedium,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: [
            Tab(text: 'Car Wash Plans'),
            Tab(text: 'Maintenance Plans'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [
              // Same category upgrade options
              // MyPlanScreen(
              //   serviceType: serviceType,
              //   showUpgradeOptions: true,
              // ),
              // Car Wash plans
              const CarWashPlanScreen(),
              // Maintenance plans
              const MaintenancePlanScreen(),
            ],
          ),
        ),
      ],
    );
  }

  String _formatServiceType(String serviceType) {
    return serviceType
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _buildTabbedInterface(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    final activeIndex = useState(0);

    useEffect(() {
      void onTabChanged() {
        activeIndex.value = tabController.index;
      }

      tabController.addListener(onTabChanged);
      return () => tabController.removeListener(onTabChanged);
    }, [tabController]);

    return Scaffold(
      key: scaffoldKey5,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(context.space.space_100),
          child: SvgPicture.asset(
            Assets.icons.handCarIcon,
            height: 30,
            width: 30,
          ),
        ),
        title: const Text('Subscriptions'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              scaffoldKey5.currentState?.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          indicatorColor: activeIndex.value == 1
              ? context.colors.primaryTxt
              : context.colors.primary,
          labelColor: activeIndex.value == 1
              ? context.colors.primaryTxt
              : context.colors.primary,
          labelStyle: context.typography.bodyLarge,
          unselectedLabelColor:
              context.colors.primaryTxt.withValues(alpha: 0.5),
          unselectedLabelStyle: context.typography.bodyLarge,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Car Wash'),
            Tab(text: 'Car Maintenance'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: const [
          CarWashPlanScreen(),
          MaintenancePlanScreen(),
        ],
      ),
    );
  }
}
