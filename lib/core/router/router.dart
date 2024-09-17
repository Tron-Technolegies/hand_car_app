
import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/navigation',
      builder: (context, state) => const NavigationPage(),
    ),
    GoRoute(path: '/servicePlans', builder: (context, state) =>  const ServicePlanScreen()),
  ],
);