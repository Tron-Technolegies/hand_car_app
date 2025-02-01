import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';

part 'auth_controller.g.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

@riverpod
class AuthController extends _$AuthController {
 @override
 FutureOr<AuthModel?> build() async {
   try {
     final storage = ref.read(tokenStorageProvider);
     if (storage.hasTokens) {
       final accessToken = storage.getAccessToken();
       final refreshToken = storage.getRefreshToken();
       if (accessToken != null && refreshToken != null) {
         return AuthModel(
           accessToken: accessToken,
           refreshToken: refreshToken,
           message: 'Restored from storage',
         );
       }
     }
     return null;
   } catch (_) {
     return null;
   }
 }

 Future<void> login(String username, String password) async {
   state = const AsyncValue.loading();
   try {
     final authService = ref.read(apiServiceProvider);
     final authModel = await authService.login(username, password);
     await ref.read(tokenStorageProvider).saveTokens(
           accessToken: authModel.accessToken,
           refreshToken: authModel.refreshToken,
         );
     state = AsyncValue.data(authModel);
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<void> verifyOtp(String phone, String otp) async {
   state = const AsyncValue.loading();
   try {
     final authModel = await ref.read(apiServiceProvider).verifyOtp(phone, otp);
     await ref.read(tokenStorageProvider).saveTokens(
           accessToken: authModel.accessToken,
           refreshToken: authModel.refreshToken,
         );
     state = AsyncValue.data(authModel);
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<void> signup(UserModel user) async {
   state = const AsyncValue.loading();
   try {
     await ref.read(apiServiceProvider).signUp(user);
     state = const AsyncValue.data(null);
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<void> logout() async {
  try {
    final authService = ref.read(apiServiceProvider);
    state = const AsyncValue.loading();
    
    await authService.logout();
    await ref.read(tokenStorageProvider).clearTokens();
    
    state = const AsyncValue.data(null);
    
  } catch (error, stack) {
    // Always clear tokens on logout, even if API call fails
    await ref.read(tokenStorageProvider).clearTokens();
    state = AsyncValue.error(error, stack);
  }
}

 Future<void> updateProfile(UserModel profile) async {
   state = const AsyncValue.loading();
   try {
     final currentState = state.value;
     if (currentState == null) throw Exception('Not authenticated');
     
     final updatedUser = await ref.read(apiServiceProvider).updateUserProfile(profile);
     ref.read(userDataProviderProvider.notifier).update((_) => updatedUser);
     state = AsyncValue.data(currentState);
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<void> sendOtp(String phone) async {
   state = const AsyncValue.loading();
   try {
     await ref.read(apiServiceProvider).sendOtp(phone);
     state = state;
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<void> requestPasswordReset(String email) async {
   state = const AsyncValue.loading();
   try {
     await ref.read(apiServiceProvider).requestPasswordReset(email);
     state = state;
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<void> resetPassword(String uid, String token, String password) async {
   state = const AsyncValue.loading();
   try {
     await ref.read(apiServiceProvider).resetPassword(uid, token, password);
     state = const AsyncValue.data(null);
   } catch (e, st) {
     state = AsyncValue.error(e, st);
     rethrow;
   }
 }

 Future<bool> isAuthenticated() async {
   final authState = await future;
   return authState != null;
 }
}