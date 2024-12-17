import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthModel?> build() {
    final apiService = ref.read(apiServiceProvider);
    if (apiService.isAuthenticated) {
      return null; // Already authenticated
    }
    return null;
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final authModel = await ref.read(apiServiceProvider).login(
            username,
            password,
          );
      state = AsyncValue.data(authModel);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    try {
      final authModel = await ref.read(apiServiceProvider).signUp(
            name: name,
            email: email,
            phone: phone,
            password: password,
          );
      state = AsyncValue.data(authModel);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(apiServiceProvider).logout();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}