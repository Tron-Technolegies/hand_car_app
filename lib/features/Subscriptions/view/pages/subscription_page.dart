import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Home/view/widgets/drawer_widget.dart';
import 'package:hand_car/features/Subscriptions/view/pages/car_wash_subscription.dart';
import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';
import 'package:hand_car/gen/assets.gen.dart';

final GlobalKey<ScaffoldState> scaffoldKey5 = GlobalKey<ScaffoldState>();

/// This is the Subscription Page
class SubscriptionPage extends HookWidget {
  const SubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Tab Controller
    final tabController = useTabController(initialLength: 2);
    // Active Index
    final activeIndex = useState(0);

    // Tab Changed Listener
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
          unselectedLabelColor: context.colors.primaryTxt.withValues(alpha:0.5),
          unselectedLabelStyle: context.typography.bodyLarge,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: const [
            Tab(text: 'Car Wash'),
            Tab(text: 'Car Maintainance'),
          ],
        ),
      ),
      drawer: const DrawerWidget(),
      endDrawerEnableOpenDragGesture: true,
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
