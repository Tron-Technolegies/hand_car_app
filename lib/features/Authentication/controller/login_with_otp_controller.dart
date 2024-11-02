import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../service/login_service.dart';
import 'model/login_mobile_model.dart';

part 'login_with_otp_controller.g.dart';

@riverpod
class LoginWithOtpController extends _$LoginWithOtpController {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<bool> sendOtp(String phone) async {
    state = const AsyncLoading();

    try {
      final request = PhoneLoginRequest(phone: phone);
      final response = await ApiServicesAuthentication.sendOtp(request.phone);

      state = AsyncData(response);
      return response;
    } catch (e) {
      return false;
    }
  }
  Future<bool> loginWithEmailAndPassword(String phone, String password) async {
    state = const AsyncLoading();

  try {
    final response = await ApiServicesAuthentication.loginWithEmailAndPassword(
        phone, password);

    state = AsyncData(response);
    return response;
  } catch (e) {
    return false;
  
}

}
}
