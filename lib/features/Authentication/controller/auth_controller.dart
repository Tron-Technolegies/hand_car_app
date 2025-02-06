import 'dart:developer';
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
      if (storage.hasValidTokens) {
        final accessToken = storage.getAccessToken();
        final refreshToken = storage.getRefreshToken();
        
        if (accessToken != null && refreshToken != null) {
          log('Restoring auth state from storage');
          return AuthModel(
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: 'Restored from storage',
          );
        }
      }
      return null;
    } catch (e) {
      log('Error building auth state: $e');
      return null;
    }
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(apiServiceProvider);
      final authModel = await authService.login(username, password);
      
      log('Login successful, saving tokens');
      await ref.read(tokenStorageProvider).saveTokens(
        accessToken: authModel.accessToken,
        refreshToken: authModel.refreshToken,
      );
      
      state = AsyncValue.data(authModel);
      
      // Refresh user data after successful login
      await ref.read(userDataProviderProvider.notifier).refresh();
    } catch (e, st) {
      log('Login error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AsyncValue.loading();
    try {
      final authModel = await ref.read(apiServiceProvider).verifyOtp(phone, otp);
      
      log('OTP verification successful, saving tokens');
      await ref.read(tokenStorageProvider).saveTokens(
        accessToken: authModel.accessToken,
        refreshToken: authModel.refreshToken,
      );
      
      state = AsyncValue.data(authModel);
      
      // Refresh user data after successful verification
      await ref.read(userDataProviderProvider.notifier).refresh();
    } catch (e, st) {
      log('OTP verification error: $e');
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
      log('Signup error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(apiServiceProvider);
      await authService.logout();
      log('Logout successful, clearing tokens');
    } catch (e) {
      log('Logout API error: $e');
    } finally {
      try {
        await ref.read(tokenStorageProvider).clearTokens();
        state = const AsyncValue.data(null);
      } catch (e, st) {
        log('Error clearing local data: $e');
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> updateProfile(UserModel profile) async {
    state = const AsyncValue.loading();
    try {
      final currentState = state.value;
      if (currentState == null) {
        throw Exception('Not authenticated');
      }
      
      final updatedUser = await ref.read(apiServiceProvider).updateUserProfile(profile);
      await ref.read(userDataProviderProvider.notifier).update((_) => updatedUser);
      state = AsyncValue.data(currentState);
    } catch (e, st) {
      log('Profile update error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> sendOtp(String phone) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(apiServiceProvider).sendOtp(phone);
      state = state; // Maintain current state
    } catch (e, st) {
      log('Send OTP error: $e');
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
      log('Password reset request error: $e');
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
      log('Password reset error: $e');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      final authState = await future;
      final storage = ref.read(tokenStorageProvider);
      return authState != null && storage.hasValidTokens;
    } catch (e) {
      log('Authentication check error: $e');
      return false;
    }
  }
}