import 'dart:developer';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';

part 'user_controller.g.dart';

@riverpod
class UserDataProvider extends _$UserDataProvider {
  @override
  Future<UserModel?> build() async {
    return await _fetchUser();
  }

  Future<void> updateUserData(UserModel newData) async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(newData);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _fetchUser());
  }

  Future<UserModel?> _fetchUser() async {
    try {
      final authService = ref.read(apiServiceProvider);
      if (!authService.isAuthenticated) {
        state = const AsyncValue.data(null);
        return null;
      }
      return await authService.getCurrentUser();
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }
}

@riverpod
String? userName( ref) {
  return ref.watch(userDataProviderProvider).value?.name;
}

@riverpod
UserModel? user( ref) {
  return ref.watch(userDataProviderProvider).value;
}