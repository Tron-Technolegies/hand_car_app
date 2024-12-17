import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
  // Watch the auth controller for changes
  final authController = ref.watch(authControllerProvider);

  // Define authentication status
  final isAuthenticated = authController.when(
    data: (authModel) => authModel?.isAuthenticated ?? false,
    loading: () => false,
    error: (_, __) => false,
  );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: isAuthenticated
        ? NavigationPage.route
        : OnbordingScreenPage.route,
    routes: _routes,
    refreshListenable: RouterRefreshNotifier(ref),
    redirect: (context, state) {
      // Routes that don't require authentication
      const authExemptRoutes = [
        OnbordingScreenPage.route,
        LoginPage.route,
        SignupPage.route,
        SplashScreen.route,
      ];

      final currentPath = state.matchedLocation;

      // Redirect to login if not authenticated and on a protected route
      if (!isAuthenticated && !authExemptRoutes.contains(currentPath)) {
        return LoginPage.route;
      }

      // Redirect to home if authenticated and accessing an auth-exempt route
      if (isAuthenticated && authExemptRoutes.contains(currentPath)) {
        return NavigationPage.route;
      }

      return null; // No redirection
    },
  );
});

/// GoRouter routes
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
      if (product == null) {
        throw Exception('Product data must be of type ProductsModel');
      }
      return AccessoriesDetailsPage(product: product);
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

/// Custom refresh notifier to refresh router on auth state change
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(ProviderRef ref) {
    ref.listen(authControllerProvider, (_, __) {
      notifyListeners();
    });
  }
}