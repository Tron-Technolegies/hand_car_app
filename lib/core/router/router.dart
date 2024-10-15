import 'package:go_router/go_router.dart';
import 'package:hand_car/core/widgets/animated_page_view.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/name_and_email_page.dart';
import 'package:hand_car/features/Authentication/view/pages/otp_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
import 'package:hand_car/features/Home/view/pages/home_page.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/splash_screen_page.dart';
import 'package:hand_car/features/SpareParts/view/pages/spares_page.dart';

import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';
import 'package:hand_car/features/service/view/pages/service_details_page.dart';
import 'package:hand_car/features/service/view/pages/services_page.dart';

final GoRouter router = GoRouter(initialLocation: '/splash', routes: [
  GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const NavigationPage(), );
    },
  ),
   GoRoute(
    path: '/onboarding',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const OnbordingScreenPage(), );
    },
  ),
  GoRoute(
    path: '/splash',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const SplashScreen(), );
    },
  ),
  GoRoute(path: '/login', builder: (context, state) => const LoginPage(),),
  GoRoute(path: '/otp', builder: (context, state) => const OtpPage(),),
GoRoute(path: '/name_and_email', builder: (context, state) => const NameAndEmailPage(),),
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const HomePage(), );
    },
  ),
  GoRoute(
    path: '/spares',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const SparesPage(), );
    },
  ),
  GoRoute(
    path: '/accessories',
pageBuilder: (context, state) {
      return customTransitionPage(child: const AccessoriesPage(), );
    },
  ),
  GoRoute(
    path: '/services',
    pageBuilder: (context, state) {
      return customTransitionPage(child:  ServicesPage(), );
    },
  ),
  GoRoute(
      path: '/servicePlans',
      pageBuilder: (context, state) {
        return customTransitionPage(child: const ServicePlanScreen(), );
      },),
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
  GoRoute(
    path: '/cart',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const CartPage(), );
    },
  ),
]);
// import 'package:go_router/go_router.dart';
// import 'package:flutter/material.dart';
// import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
// import 'package:hand_car/features/Home/view/pages/home_page.dart';
// import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
// import 'package:hand_car/features/Home/view/pages/spares_page.dart';
// import 'package:hand_car/features/Subscriptions/view/pages/service_subscription_page.dart';
// import 'package:hand_car/features/service/view/pages/service_details_page.dart';
// import 'package:hand_car/features/service/view/pages/services_page.dart';

// final GlobalKey<NavigatorState> _rootNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'root');
// final GlobalKey<NavigatorState> _shellNavigatorKey =
//     GlobalKey<NavigatorState>(debugLabel: 'shell');

// final GoRouter router = GoRouter(
//   navigatorKey: _rootNavigatorKey,

//   // routes: [
//   //   ShellRoute(
//   //     navigatorKey: _shellNavigatorKey,
//   //     builder: (context, state, child) {
//   //       return NavigationPage(child: child);
//   //     },
//       routes: [
//         GoRoute(path: '/', builder: (context, state) => const NavigationPage()),
//         GoRoute(
//           path: '/home',
//           builder: (context, state) => const HomePage(),
//         ),
//         GoRoute(
//           path: '/spares',
//           builder: (context, state) => const SparesPage(),
//         ),
//         GoRoute(
//           path: '/accessories',
//           builder: (context, state) => const AccessoriesPage(),
//         ),
//         GoRoute(
//           path: '/services',
//           builder: (context, state) => ServicesPage(),
//         ),
//         GoRoute(
//           path: '/servicePlans',
//           builder: (context, state) => const ServicePlanScreen(),
//         ),
    
//     GoRoute(
//       path: '/serviceDetailsPage',
//       parentNavigatorKey: _rootNavigatorKey,
//       builder: (context, state) {
//         final Map<String, dynamic> data = state.extra as Map<String, dynamic>;
//         return ServiceDetailsPage(
//           image: data['image'],
//           title: data['title'],
//           title2: data['title2'],
//           rating: data['rating'],
//           price: data['price'],
//         );
//       },
//     ),
//   ],
// );