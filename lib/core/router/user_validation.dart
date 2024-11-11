// // import 'package:get_storage/get_storage.dart';
// // import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';

// // class UserValidation {
// //  final _storage=GetStorage();
// //   String? userAuthenticated(){
// //   final token= _storage.read('token');
// //   if(token == null){
// //     return LoginWithPhoneAndPasswordPage.routeName;
// //   }
// //   return null;
// //  }
 
// // }

// import 'package:flutter/material.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:go_router/go_router.dart';
// import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
// import 'package:hand_car/features/Home/view/pages/navigation_page.dart';


// /// A service class that is used to redirect the user to a specific page.
// ///
// /// e.g. If the user is not logged in, then redirect the user to the login page.
// /// or if the user is openeing the app for the first time, then redirect the user to the onboarding page,
// /// etc.
// class RouterRedirectServices {
//   /// This is the storage box that is used to store the redirect related data
//   /// into the local storage.
//   static final _storage = GetStorage();

//   /// A key that is used in the local storage to indicate that the user is
//   /// already completed the onborading screen.
//   ///
//   /// The value can be either `true` or `false`.
//   /// If the value is `true`, then the user has already completed the onboarding screen.
//   /// If the value is `false`, then the user has not completed the onboarding screen.
//   /// If there is no value, then the user has not completed the onboarding screen.
//   static const String _isFirstLaunchStorageKey = 'is_first_launch';

//   /// Check if the user is opening the app for the first time.
//   ///
//   /// If the user already completed the onboarding screen, then redirect the user to
//   /// the app home page.
//   ///
//   /// If the user is not opening the app for the first time, then do not redirect the user to any page.
//   static String? checkFirstLaunch(BuildContext context, GoRouterState state) {
//     final bool isFirstLaunch =
//         _storage.read<bool>(_isFirstLaunchStorageKey) ?? true;

//     if (!isFirstLaunch) {
//       return NavigationPage.route;
//     }

//     return null;
//   }

//   /// Mark the user as completed the onboarding screen.
//   ///
//   /// Once this is called, the user will not be redirected to the onboarding screen again.
//   static void markFirstLaunchCompleted() {
//     _storage.write(_isFirstLaunchStorageKey, false);
//   }

//   /// Check if the user is logged in.
//   ///
//   /// If the user is not logged in, then redirect the user to the login page.
//   /// If the user is already logged in, then do not redirect the user to any page.
//   static String? checkLoggedIn(BuildContext context, GoRouterState state) {
   

//     if (isUserNotLoggedIn) {
//       return LoginWithPhoneAndPasswordPage.route;
//     }

//     return null;
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_token', token);
}