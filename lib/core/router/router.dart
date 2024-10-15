import 'package:go_router/go_router.dart';
import 'package:hand_car/core/widgets/animated_page_view.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
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
  //Navigation Page
  GoRoute(
    path: '/',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const NavigationPage(), );
    },
  ),
  //Onboarding Page
   GoRoute(
    path: '/onboarding',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const OnbordingScreenPage(), );
    },
  ),
  //Splash Page
  GoRoute(
    path: '/splash',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const SplashScreen(), );
    },
  ),
  //Login Page
  GoRoute(path: '/login', builder: (context, state) => const LoginPage(),),
  //OTP Page
  GoRoute(path: '/otp', builder: (context, state) => const OtpPage(),),
  //Name and Email Page
  GoRoute(path: '/name_and_email', builder: (context, state) => const NameAndEmailPage(),),
  //Accessories Details Page
  GoRoute(path: '/accessories_details', builder: (context, state) => const AccessoriesDetailsPage(),),
  //Home Page
  GoRoute(
    path: '/home',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const HomePage(), );
    },
  ),
  //Auto Parts Page
  GoRoute(
    path: '/auto_parts',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const AutoPartsPage() , );
    },
  ),
  //Accessories Page
  GoRoute(
    path: '/accessories',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const AccessoriesPage(), );
    },
  ),
  //Services Page
  GoRoute(
    path: '/services',
    pageBuilder: (context, state) {
      return customTransitionPage(child:  ServicesPage(), );
    },
  ),
  //Service Plans Page
  GoRoute(
      path: '/servicePlans',
      pageBuilder: (context, state) {
        return customTransitionPage(child: const ServicePlanScreen(), );
      },),
      //Service Details Page
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
  //Cart Page
  GoRoute(
    path: '/cart',
    pageBuilder: (context, state) {
      return customTransitionPage(child: const CheckOutPage(), );
    },
  ),
]);
