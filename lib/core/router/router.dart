import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
import 'package:hand_car/features/Home/view/pages/splash_screen_page.dart';
import 'package:hand_car/features/service/view/pages/service_details_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Helper function to check login state
Future<bool> isUserLoggedIn() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs
      .containsKey('auth_token'); // Adjust based on your login persistence
}

// Custom wrapper for dynamic initialLocation
Future<GoRouter> createRouter() async {
  final bool isLoggedIn = await isUserLoggedIn();

  return GoRouter(
    initialLocation:
        isLoggedIn ? NavigationPage.route : OnbordingScreenPage.route,
    routes: [
      GoRoute(
        path: NavigationPage.route,
        builder: (context, state) => const NavigationPage(),
      ),
      GoRoute(
        path: OnbordingScreenPage.route,
        builder: (context, state) => const OnbordingScreenPage(),
      ),
      GoRoute(
        path: SplashScreen.route,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
          path: SignupPage.route,
          builder: (context, state) => const SignupPage()),
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
          path: LoginWithPhoneAndPasswordPage.route,
          builder: (context, state) => const LoginWithPhoneAndPasswordPage()),
      GoRoute(
        path: AccessoriesDetailsPage.route,
        builder: (context, state) => const AccessoriesDetailsPage(),
      ),
      GoRoute(
        path: AccessoriesPage.route,
        builder: (context, state) => const AccessoriesPage(),
      ),
      GoRoute(
        path: ServiceDetailsPage.route,
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return ServiceDetailsPage(
            image: data['image'],
            title: data['title'],
            title2: data['title2'],
            rating: data['rating'],
            price: data['price'],
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
    ],
  );
}
