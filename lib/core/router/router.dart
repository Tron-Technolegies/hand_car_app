import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Import necessary page routes
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
import 'package:hand_car/features/Home/view/pages/splash_screen_page.dart';
import 'package:hand_car/features/service/view/pages/service_details_page.dart';

/// Global navigator key
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// GoRouter provider
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: SplashScreen.route, // Start at the splash screen
    routes: _routes,

    // Redirect logic based on authentication state
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        data: (auth) => auth != null, // If `auth` is not null, user is logged in
        orElse: () => false,
      );

      const authExemptRoutes = [
        SplashScreen.route,
        OnbordingScreenPage.route,
        LoginPage.route,
        SignupPage.route,
      ];

      final currentPath = state.matchedLocation;

      // Allow SplashScreen to show while loading auth state
      if (currentPath == SplashScreen.route) {
        return null;
      }

      // Redirect unauthenticated users to LoginPage
      

      // Redirect authenticated users to NavigationPage
      if (isAuthenticated && authExemptRoutes.contains(currentPath)) {
        return NavigationPage.route;
      }

      return null; // No redirect needed
    },

    refreshListenable: RouterRefreshNotifier(ref),
    debugLogDiagnostics: true, // Enable logs for debugging
  );
});

/// Routes configuration
final _routes = [
  GoRoute(
    path: SplashScreen.route,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(
    path: OnbordingScreenPage.route,
    builder: (context, state) => const OnbordingScreenPage(),
  ),
  GoRoute(
    path: LoginPage.route,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: SignupPage.route,
    builder: (context, state) => const SignupPage(),
  ),
  GoRoute(
    path: NavigationPage.route,
    builder: (context, state) => const NavigationPage(),
  ),
  GoRoute(
    path: AccessoriesPage.route,
    builder: (context, state) => const AccessoriesPage(),
  ),
  GoRoute(
    path: '${AccessoriesDetailsPage.route}/:id',
    builder: (context, state) {
      final product = state.extra as ProductsModel?;
      return AccessoriesDetailsPage(product: product!);
    },
  ),
  GoRoute(
    path: ServiceDetailsPage.route,
    builder: (context, state) {
      final data = state.extra as Map<String, dynamic>;
      return ServiceDetailsPage(
        image: data['image'] as String,
        title: data['title'] as String,
        title2: data['title2'] as String,
        rating: data['rating'] as String,
        price: data['price'] as String,
      );
    },
  ),
  GoRoute(
    path: ShoppingCartScreen.route,
    builder: (context, state) => const ShoppingCartScreen(),
  ),
  GoRoute(
    path: CheckOutPage.route,
    builder: (context, state) => const CheckOutPage(),
  ),
];

/// Custom refresh notifier
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, __) {
      notifyListeners();
    });
  }
}