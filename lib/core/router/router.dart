
import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';
import 'package:hand_car/features/service/view/pages/service_details_page.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NavigationPage(),
    ),
    GoRoute(path: '/servicePlans', builder: (context, state) =>  const ServicePlanScreen()),
 GoRoute(
  path: '/serviceDetailsPage',
  builder: (context, state) {
    final Map<String, dynamic> data = state.extra as Map<String, dynamic>;

    // Extract parameters from the 'extra' map
    final String image = data['image'];
    final String title = data['title'];
    final String title2 = data['title2'];
    final String rating = data['rating'];
    final String price = data['price'];

    // Pass the extracted parameters to the ServiceDetailsPage
    return ServiceDetailsPage(
      image: image,
      title: title,
      title2: title2,
      rating: rating,
      price: price,
    );
  },
),
  ],
);