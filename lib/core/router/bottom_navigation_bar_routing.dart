// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
// import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
// import 'package:hand_car/features/Home/view/pages/home_page.dart';
// import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
// import 'package:hand_car/features/SpareParts/view/pages/spares_page.dart';
// import 'package:hand_car/features/Subscriptions/view/pages/subscription_page.dart';
// import 'package:hand_car/features/service/view/pages/service_details_page.dart';
// import 'package:hand_car/features/service/view/pages/services_page.dart';

// // Main app entry point with GoRouter and Nested Navigation


//  final GlobalKey<NavigatorState> _rootNavigatorKey =
//       GlobalKey<NavigatorState>(debugLabel: 'root');
  
//   final GoRouter router = GoRouter(
//     navigatorKey: _rootNavigatorKey,
//     initialLocation: '/home',
//     routes: <RouteBase>[
//       StatefulShellRoute.indexedStack(
//         builder: (BuildContext context, GoRouterState state,
//             StatefulNavigationShell navigationShell) {
//           return NavigationPage(navigationShell: navigationShell);  // Pass the navigationShell to NavigationPage
//         },
//         branches: <StatefulShellBranch>[
//           // First tab (Spares)
//           StatefulShellBranch(
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/spares',
//                 builder: (BuildContext context, GoRouterState state) =>
//                     const SparesPage(),
//               ),
//             ],
//           ),
//           // Second tab (Accessories)
//           StatefulShellBranch(
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/accessories',
//                 builder: (BuildContext context, GoRouterState state) =>
//                     const AccessoriesPage(),
//               ),
//             ],
//           ),
//           // Third tab (Home)
//           StatefulShellBranch(
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/home',
//                 builder: (BuildContext context, GoRouterState state) =>
//                     const HomePage(),
//               ),
//             ],
//           ),
//           // Fourth tab (Services)
//           StatefulShellBranch(
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/services',
//                 builder: (BuildContext context, GoRouterState state) =>
//                     ServicesPage(),
//               ),
//             ],
//           ),
//           // Fifth tab (Service Subscription)
//           StatefulShellBranch(
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/subscription',
//                 builder: (BuildContext context, GoRouterState state) =>
//                     const SubscriptionPage(),
//               ),
//             ],
//           ),
//            StatefulShellBranch(
//             routes: <RouteBase>[
//               GoRoute(
//                 path: '/cart',
//                 builder: (BuildContext context, GoRouterState state) =>
//                     const CartPage(),
//               ),
//             ],
//           ),
//         ],
//       ),
//        GoRoute(
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
        
//     }),
//     ]
    
//   );



