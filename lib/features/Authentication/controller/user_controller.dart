import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';

part 'user_controller.g.dart';



@riverpod
class UserDataProvider extends _$UserDataProvider {
  @override
  Future<UserModel?> build() async {
    try {
      final authService = ref.read(apiServiceProvider);
      return await authService.getCurrentUser();
    } catch (e) {
      return null;
    }
  }
  Future<void> updateUserData(UserModel newData) async {
    state = const AsyncLoading();
    state = AsyncData(newData);
  }

  // Method to refresh user data
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(apiServiceProvider);
      final user = await authService.getCurrentUser();
      state = AsyncValue.data(user);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Simple provider just for user name
@riverpod
String? userName( ref) {
  return ref.watch(userDataProviderProvider).whenOrNull(
    data: (user) => user?.name,
  );
}