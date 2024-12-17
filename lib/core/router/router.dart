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

/// Global navigator key for managing navigation state
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

/// GoRouter provider to manage application routing and navigation
final routerProvider = Provider<GoRouter>((ref) {
  // Watch the authentication controller for state changes
  final authState = ref.watch(authControllerProvider);

  // Create and configure GoRouter
  return GoRouter(
    // Use the global navigator key
    navigatorKey: _rootNavigatorKey,
    
    // Initial route when the app starts
    initialLocation: SplashScreen.route,
    
    // Define application routes
    routes: _routes,
    
    // Custom refresh notifier to handle authentication state changes
    refreshListenable: RouterRefreshNotifier(ref),
    
    // Redirect logic based on authentication state
    redirect: (context, state) {
      // Determine if user is authenticated
      final isAuthenticated = authState.maybeWhen(
        data: (auth) => auth != null, // Authenticated if auth is not null
        orElse: () => false,
      );

      // Routes that do not require authentication
      const authExemptRoutes = [
        SplashScreen.route,
        OnbordingScreenPage.route,
        LoginPage.route,
        SignupPage.route,
      ];

      final currentPath = state.matchedLocation;

      // Always allow splash screen and onboarding
      if (currentPath == SplashScreen.route || 
          currentPath == OnbordingScreenPage.route) {
        return null;
      }

      // Redirect unauthenticated users to login page
      if (!isAuthenticated && !authExemptRoutes.contains(currentPath)) {
        return LoginPage.route;
      }

      // Redirect authenticated users away from authentication routes
      if (isAuthenticated && authExemptRoutes.contains(currentPath)) {
        return NavigationPage.route;
      }

      // No redirection needed
      return null;
    },

    // Error page builder for handling navigation errors
    errorPageBuilder: (context, state) => MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text('Navigation Error: ${state.error}'),
        ),
      ),
    ),

    // Add logging for debugging
    debugLogDiagnostics: true,
  );
});

/// Application routes configuration
final _routes = [
  // Splash Screen Route
  GoRoute(
    path: SplashScreen.route,
    builder: (context, state) => const SplashScreen(),
  ),

  // Onboarding Screen Route
  GoRoute(
    path: OnbordingScreenPage.route,
    builder: (context, state) => const OnbordingScreenPage(),
  ),

  // Login Page Route
  GoRoute(
    path: LoginPage.route,
    builder: (context, state) => const LoginPage(),
  ),

  // Signup Page Route
  GoRoute(
    path: SignupPage.route,
    builder: (context, state) => const SignupPage(),
  ),

  // Navigation/Home Page Route
  GoRoute(
    path: NavigationPage.route,
    builder: (context, state) => const NavigationPage(),
  ),

  // Accessories Page Route
  GoRoute(
    path: AccessoriesPage.route,
    builder: (context, state) => const AccessoriesPage(),
  ),

  // Accessories Details Page Route (with dynamic parameter)
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

  // Service Details Page Route
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

  // Shopping Cart Route
  GoRoute(
    path: ShoppingCartScreen.route,
    builder: (context, state) => const ShoppingCartScreen(),
  ),

  // Checkout Page Route
  GoRoute(
    path: CheckOutPage.route,
    builder: (context, state) => const CheckOutPage(),
  ),
];

/// Custom refresh notifier to handle authentication state changes
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    // Listen to authentication state changes
    ref.listen(authControllerProvider, (previous, next) {
      // Notify listeners when auth state changes
      notifyListeners();
    });
  }
}