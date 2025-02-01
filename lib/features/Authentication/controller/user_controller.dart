import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';

part 'user_controller.g.dart';



@riverpod
class UserDataProvider extends _$UserDataProvider {
 @override
 Future<UserModel?> build() async {
   return _fetchUser();
 }

 Future<void> updateUserData(UserModel newData) async {
   state = const AsyncLoading();
   state = AsyncData(newData);
 }
 
 Future<void> refresh() async {
   state = const AsyncLoading();
   state = AsyncData(await _fetchUser());
 }

 Future<UserModel?> _fetchUser() async {
   try {
     final authService = ref.read(apiServiceProvider);
     if (!authService.isAuthenticated) return null;
     return await authService.getCurrentUser();
   } catch (e, st) {
     state = AsyncError(e, st);
     return null;
   }
 }
}

@riverpod
String? userName( ref) {
 return ref.watch(userDataProviderProvider).whenOrNull(
   data: (user) => user?.name,
 );
}