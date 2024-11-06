import 'dart:developer';

import 'package:hand_car/features/Authentication/service/login_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';


part 'login_with_otp_controller.g.dart';

@riverpod
class LoginWithOtpController extends _$LoginWithOtpController {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<bool> signUp(String name, String email, String phone, String password) async {
    try {
      state = const AsyncLoading();
      
      final response = await ApiServicesAuthentication.signUp(
        name,
        email,
        phone,
        password,
      );
      
      if (response) {
        state = const AsyncData(true);
        return true;
      } else {
        state = const AsyncData(false);
        return false;
      }
    } catch (e) {
      log("Controller error: $e");
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }

  Future<bool> loginWithPassword(String phone, String password) async {
    try {
      state = const AsyncLoading();
      
      final response = await ApiServicesAuthentication.loginWithPassword(
        phone,
        password,
      );
      
      if (response) {
        state = const AsyncData(true);
        return true;
      } else {
        state = const AsyncData(false);
        return false;
      }
    } catch (e) {
      log("Controller error: $e");
      state = AsyncError(e, StackTrace.current);
      return false;
    }
  }
}
