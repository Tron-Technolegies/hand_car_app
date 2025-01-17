import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Accessories/view/pages/wishlist_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/pages/services_page.dart';
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
import 'package:hand_car/features/car_service/view/pages/service_details_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Provider for GetStorage instance
final storageProvider = Provider<GetStorage>((ref) => GetStorage());

// Provider to track if onboarding is completed
final onboardingCompletedProvider = StateProvider<bool>((ref) {
  final storage = ref.watch(storageProvider);
  return storage.read('onboardingCompleted') ?? false;
});

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final onboardingCompleted = ref.watch(onboardingCompletedProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: SplashScreen.route,
    routes: _routes,
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        data: (auth) => auth != null,
        orElse: () => false,
      );

      final isOnboardingRoute = state.matchedLocation == OnbordingScreenPage.route;
      final isLoginRoute = state.matchedLocation == LoginWithPhoneAndPasswordPage.route;
      final isSignupRoute = state.matchedLocation == SignupPage.route;
      final isSplashRoute = state.matchedLocation == SplashScreen.route;

      // Allow splash screen to show
      if (isSplashRoute) return null;

      // If user is not authenticated and onboarding is not completed
      if (!onboardingCompleted && !isAuthenticated) {
        return OnbordingScreenPage.route;
      }

      // If onboarding is completed but user is not authenticated
      if (onboardingCompleted && !isAuthenticated) {
        // Allow access to login and signup pages
        if (isLoginRoute || isSignupRoute) return null;
        // Redirect to login for all other routes
        return LoginWithPhoneAndPasswordPage.route;
      }

      // If user is authenticated
      if (isAuthenticated) {
        // Redirect from auth pages to home
        if (isLoginRoute || isSignupRoute || isOnboardingRoute) {
          return NavigationPage.route;
        }
        return null;
      }

      return null;
    },
    refreshListenable: RouterRefreshNotifier(ref),
    debugLogDiagnostics: true,
  );
});

/// Routes configuration
final _routes = [
  GoRoute(
    path: SplashScreen.route,
    builder: (context, state) => const SplashScreen(),
  ),
  GoRoute(path: LoginWithPhoneAndPasswordPage.route, builder: (context, state) => const LoginWithPhoneAndPasswordPage()),
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
  GoRoute(path: ServicesPage.route, builder: (context, state) =>  ServicesPage()),
 GoRoute(
  path: ServiceDetailsPage.route,
  builder: (context, state) {
    final data = state.extra as Map<String, dynamic>;
    final service = data['service'] as ServiceModel;
    return ServiceDetailsPage(service: service);
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
  GoRoute(
      path: WishlistScreen.route,
      builder: (context, state) => const WishlistScreen()),
];

/// Custom refresh notifier
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, __) {
      notifyListeners();
    });
  }
}
