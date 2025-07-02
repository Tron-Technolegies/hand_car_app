// lib/core/router/router.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/router/redirect.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Accessories/view/pages/my_orders_page.dart';
import 'package:hand_car/features/Accessories/view/pages/wishlist_page.dart';
import 'package:hand_car/features/Authentication/view/pages/edit_profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_otp_page.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/otp_page.dart';
import 'package:hand_car/features/Authentication/view/pages/reset_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
import 'package:hand_car/features/Home/view/pages/splash_screen_page.dart';
import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hand_car/features/car_service/view/pages/service_details_page.dart';
import 'package:hand_car/features/car_service/view/pages/services_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: SplashScreen.route,
    redirect: (context, state) async {
      final container = ProviderScope.containerOf(context);
      return await RedirectRouter.protectRoutes(context, state, container);
    },
    routes: [
      GoRoute(
        path: SplashScreen.route,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: OnbordingScreenPage.route,
        builder: (context, state) => const OnbordingScreenPage(),
      ),
      GoRoute(
        path: LoginWithPhoneAndPasswordPage.route,
        builder: (context, state) => const LoginWithPhoneAndPasswordPage(),
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
        path: ForgotPasswordOtpPage.route,
        builder: (context, state) {
          final emailMap = state.extra as Map<String, String>? ?? {};
          final email = emailMap['email'] ?? '';
          return ForgotPasswordOtpPage(email: email);
        },
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
        path: ProfilePage.route,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: EditProfileScreen.route,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: ShoppingCartScreen.route,
        builder: (context, state) => const ShoppingCartScreen(),
      ),
      GoRoute(
        path: CheckOutPage.route,
        builder: (context, state) {

          return CheckOutPage();
        },
      ),
      GoRoute(
        path: WishlistScreen.route,
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(
        path: MyOrdersPage.route,
        builder: (context, state) => MyOrdersPage(),
      ),
    ],
    debugLogDiagnostics: true,
  );
});