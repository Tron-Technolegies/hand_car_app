

// import 'package:hand_car/core/router/user_validation.dart';
// import 'package:hand_car/features/Authentication/controller/auth_state.dart';
// import 'package:hand_car/features/Authentication/service/authentication_service.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'signup_controller.g.dart';


// // @riverpod
// // class SignupController extends _$SignupController {
// //   @override
// //   AuthState build() {
// //     return const AuthState.initial();
// //   }

// //   Future<bool> signUp(
// //       String name, String email, String phone, String password) async {
// //     state = const AuthState.loading();
// //     try {
// //       final result = await ApiServiceAuthentication().signUp(name, email, phone, password);
// //       if (result.containsKey('error')) {
// //         state = AuthState.error(result['error']);
// //         return false;
// //       } else {
// //         state = const AuthState.success(message: 'Signup successful!');
// //         return true;
// //       }
// //     } catch (e) {
// //       state = AuthState.error(e.toString());
// //       return false;
// //     }
// //   }

// //   Future<bool> login(String phone, String password) async {
// //     state = const AuthState.loading();
// //     try {
// //       final result = await ApiServiceAuthentication().login(phone, password);
// //       if (result.containsKey('error')) {
// //         state = AuthState.error(result['error']);
// //         return false;
// //       } else {
// //         state = const AuthState.success(message: 'Login successful!');
// //         return true;
// //       }
// //     } catch (e) {
// //       state = AuthState.error(e.toString());
// //       return false;
// //     }
// //   }
// // }





// @riverpod
// class SignupController extends _$SignupController {
//   @override
//   AuthenticationState build() {
//     return AuthenticationState(
//       isLoading: false, 
//       authenticated: false,
//       errorMessage: null
//     );
//   }

//     /// Login method
//     Future<Map<String, dynamic>> login(String phone, String password) async {
//     state = state.copyWith(isLoading: true, errorMessage: null);

//     try {
//       final response = await ApiServiceAuthentication.login(phone, password);

//       if (response['success']) {
//         state = state.copyWith(authenticated: true, isLoading: false);
//         return response;
//       } else {
//         state = state.copyWith(
//           authenticated: false,
//           isLoading: false,
//           errorMessage: response['error'] ?? 'Unknown error',
//         );
//         return response;
//       }
//     } catch (e) {
//       state = state.copyWith(
//         authenticated: false,
//         isLoading: false,
//         errorMessage: e.toString(),
//       );
//       return {'success': false, 'error': e.toString()};
//     }
//   }


//   /// Signup method
//   Future<void> signUp(String name, String email, String phone, String password) async {
//     state = state.copyWith(
//       isLoading: true,
//       errorMessage: null,
//     );

//     try {
//       final result = await ApiServiceAuthentication.signUp(name, email, phone, password);

//       if (result['success'] == true) {
//         state = state.copyWith(
//           isLoading: false,
//           authenticated: true,
//           errorMessage: null,
//         );
//       } else {
//         state = state.copyWith(
//           isLoading: false,
//           authenticated: false,
//           errorMessage: result['error'] ?? 'Signup failed',
//         );
//       }
//     } catch (e) {
//       state = state.copyWith(
//         isLoading: false,
//         authenticated: false,
//         errorMessage: e.toString(),
//       );
//     }
//   }

//   /// Logout method
//   Future<void> logout() async {
//     try {
//       await AuthManager.logout();
//       state = state.copyWith(
//         authenticated: false,
//         isLoading: false,
//         errorMessage: null,
//       );
//     } catch (e) {
//       state = state.copyWith(
//         authenticated: false,
//         isLoading: false,
//         errorMessage: e.toString(),
//       );
//     }
//   }
// }