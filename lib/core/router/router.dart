import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Accessories/view/pages/wishlist_page.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/otp_page.dart';
import 'package:hand_car/features/Authentication/view/pages/reset_password_page.dart';
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

// Provider to track preferred login method
final loginPreferenceProvider = StateProvider<String>((ref) {
  final storage = ref.watch(storageProvider);
  return storage.read('preferredLoginMethod') ?? LoginWithPhoneAndPasswordPage.route;
});

// Router configuration
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authControllerProvider);
  final onboardingCompleted = ref.watch(onboardingCompletedProvider);
  final preferredLoginRoute = ref.watch(loginPreferenceProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: SplashScreen.route,
    routes: _routes,
    redirect: (context, state) {
      final isAuthenticated = authState.maybeWhen(
        data: (auth) => auth != null,
        orElse: () => false,
      );

      // Define route matchers
      final isOnboardingRoute = state.matchedLocation == OnbordingScreenPage.route;
      final isLoginRoute = state.matchedLocation == LoginWithPhoneAndPasswordPage.route;
      final isSignupRoute = state.matchedLocation == SignupPage.route;
      final isSplashRoute = state.matchedLocation == SplashScreen.route;
      final isForgotPasswordRoute = state.matchedLocation == ForgotPasswordPage.route;
      final isResetPasswordRoute = state.matchedLocation.startsWith('/reset-password/');
      final isOtpLoginRoute = state.matchedLocation == LoginPage.route;
      final isOtpVerificationRoute = state.matchedLocation == OtpPage.route;

      // Group all auth-related routes
      final isAuthRoute = isLoginRoute || 
                         isSignupRoute || 
                         isForgotPasswordRoute || 
                         isResetPasswordRoute || 
                         isOtpLoginRoute || 
                         isOtpVerificationRoute;

      // Allow splash screen to show
      if (isSplashRoute) return null;

      // Handle onboarding state
      if (!onboardingCompleted) {
        // Allow reset password and verify routes even before onboarding
        if (isResetPasswordRoute) return null;
        // Force onboarding for all other routes
        return isOnboardingRoute ? null : OnbordingScreenPage.route;
      }

      // Handle unauthenticated state
      if (!isAuthenticated) {
        // Allow access to all auth-related pages
        if (isAuthRoute) return null;
        // Redirect to preferred login method for all other routes
        return preferredLoginRoute;
      }

      // Handle authenticated state
      if (isAuthenticated) {
        // Redirect from auth pages to home
        if (isAuthRoute || isOnboardingRoute) {
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
  GoRoute(
    path: LoginWithPhoneAndPasswordPage.route,
    builder: (context, state) => const LoginWithPhoneAndPasswordPage(),
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
  path: '/otp/:phoneOrEmail',
  builder: (context, state) => OtpPage(
    phoneOrEmail: state.pathParameters['phoneOrEmail']!,
  ),
),
  GoRoute(
    path: SignupPage.route,
    builder: (context, state) => const SignupPage(),
  ),
  GoRoute(
    path: ForgotPasswordPage.route,
    builder: (context, state) => const ForgotPasswordPage(),
  ),
  GoRoute(
    path: ResetPasswordPage.route,
    builder: (context, state) => ResetPasswordPage(
      uid: state.pathParameters['uid']!,
      token: state.pathParameters['token']!,
    ),
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
    path: ServicesPage.route, 
    builder: (context, state) => ServicesPage(),
  ),
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
    builder: (context, state) => const WishlistScreen(),
  ),
];

/// Custom refresh notifier for router state
class RouterRefreshNotifier extends ChangeNotifier {
  RouterRefreshNotifier(Ref ref) {
    ref.listen(authControllerProvider, (_, __) {
      notifyListeners();
    });
  }
}