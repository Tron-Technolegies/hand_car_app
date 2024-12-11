import 'package:go_router/go_router.dart';
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
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: LoginPage.route,
        builder: (context, state) => const LoginPage(),
      ),
        GoRoute(
          path: '${AccessoriesDetailsPage.route}/:id',
          builder: (context, state) {
            // Here you fetch the product by ID or pass the product directly
            final product = state.extra as ProductsModel?;
            if (product == null) {
              throw Exception('Product data must be of type ProductsModel');
            }
            return AccessoriesDetailsPage(product: product);
          },
        ),
      GoRoute(
        path: AccessoriesPage.route,
        builder: (context, state) => const AccessoriesPage(),
      ),
      GoRoute(
        path: ServiceDetailsPage.route,
        builder: (context, state) {
          final data = state.extra;
          if (data is! Map<String, dynamic> ||
              !data.containsKey('image') ||
              !data.containsKey('title') ||
              !data.containsKey('title2') ||
              !data.containsKey('rating') ||
              !data.containsKey('price')) {
            throw Exception('Invalid arguments passed to ServiceDetailsPage');
          }
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
    ],
  );
}
