// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import '../service/login_service.dart';

import 'package:hand_car/features/Authentication/controller/auth_state.dart';
import 'package:hand_car/features/Authentication/service/login_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'signup_controller.g.dart';


// @riverpod
// class SignupController extends _$SignupController {
//   @override
//   AuthState build() {
//     return const AuthState.initial();
//   }

//   Future<bool> signUp(
//       String name, String email, String phone, String password) async {
//     state = const AuthState.loading();
//     try {
//       final result = await ApiServiceAuthentication().signUp(name, email, phone, password);
//       if (result.containsKey('error')) {
//         state = AuthState.error(result['error']);
//         return false;
//       } else {
//         state = const AuthState.success(message: 'Signup successful!');
//         return true;
//       }
//     } catch (e) {
//       state = AuthState.error(e.toString());
//       return false;
//     }
//   }

//   Future<bool> login(String phone, String password) async {
//     state = const AuthState.loading();
//     try {
//       final result = await ApiServiceAuthentication().login(phone, password);
//       if (result.containsKey('error')) {
//         state = AuthState.error(result['error']);
//         return false;
//       } else {
//         state = const AuthState.success(message: 'Login successful!');
//         return true;
//       }
//     } catch (e) {
//       state = AuthState.error(e.toString());
//       return false;
//     }
//   }
// }





@riverpod
class SignupController extends _$SignupController {
  @override
  AuthenticationState build() {
    return  AuthenticationState(isLoading: false, authenticated: false);
  }

// Signup function to sign up a user
  Future<void> signUp(String name, String email, String phone, String password) async {
    state = AuthenticationState(isLoading: true, authenticated: false);
    try {
      final result = await ApiServiceAuthentication().signUp(name, email, phone, password);
      if (result.containsKey('error')) {
        state = AuthenticationState(isLoading: false, authenticated: false);
      } else {
        state = AuthenticationState(isLoading: false, authenticated: true);
      }
    } catch (e) {
      state = AuthenticationState(isLoading: false, authenticated: false);
    }
  }
  
  // Login function to login a user

    Future<void> login(String phone, String password) async {
      state = state.copyWith(isLoading: true);
      try {
        final result = await ApiServiceAuthentication().login(phone, password);
        if (result.containsKey('error')) {
          state = state.copyWith(isLoading: false, authenticated: false);
        } else {
          state = state.copyWith(authenticated: true, isLoading: false);
        }
      } catch (e) {
        state = state.copyWith(isLoading: false, authenticated: false);
      }
    }
}
