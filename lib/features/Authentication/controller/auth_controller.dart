// lib/features/Authentication/controller/auth_controller.dart
import 'dart:developer' as dev;
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

final isAuthenticatedProvider = StateProvider<bool>((ref) {
  final authState = ref.watch(authControllerProvider);
  final userState = ref.watch(userDataProviderProvider);
  return authState.maybeWhen(
    data: (authModel) =>
        authModel != null &&
        authModel.accessToken.isNotEmpty &&
        authModel.isAuthenticated &&
        authModel.isTokenValid &&
        userState.valueOrNull != null,
    orElse: () => false,
  );
});

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthModel?> build() async {
    // Initialize with null state to avoid uninitialized access
    return null;
  }

  Future<void> initializeAuth() async {
    state = const AsyncValue.loading();
    try {
      final storage = ref.read(tokenStorageProvider);
      if (storage.hasValidTokens) {
        final accessToken = await storage.getAccessToken();
        if (accessToken != null) {
          await fetchCurrentUser(accessToken);
          return;
        }
      }
      state = const AsyncValue.data(null);
      ref.read(isAuthenticatedProvider.notifier).state = false;
    } catch (e, st) {
      dev.log('Error initializing auth: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      ref.read(isAuthenticatedProvider.notifier).state = false;
    }
  }

  Future<void> fetchCurrentUser(String accessToken) async {
    state = const AsyncValue.loading();
    try {
      final user = await ref.read(apiServiceProvider).getCurrentUser();
      final authModel = AuthModel(
        accessToken: accessToken,
        refreshToken: await ref.read(tokenStorageProvider).getRefreshToken() ?? '',
        message: 'User fetched successfully',
      );
      state = AsyncValue.data(authModel);
      ref.read(isAuthenticatedProvider.notifier).state = true;
      await ref.read(userDataProviderProvider.notifier).refresh();
    } catch (e, st) {
      dev.log('Error fetching user: $e', name: 'AuthController');
      await ref.read(tokenStorageProvider).clearTokens();
      state = AsyncValue.error(e, st);
      ref.read(isAuthenticatedProvider.notifier).state = false;
    }
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(apiServiceProvider);
      final authModel = await authService.login(username, password);
      dev.log('Login successful, saving tokens', name: 'AuthController');
      await ref.read(tokenStorageProvider).saveTokens(
            accessToken: authModel.accessToken,
            refreshToken: authModel.refreshToken,
          );
      state = AsyncValue.data(authModel);
      ref.read(isAuthenticatedProvider.notifier).state = true;
      await ref.read(userDataProviderProvider.notifier).refresh();
    } catch (e, st) {
      dev.log('Login error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      ref.read(isAuthenticatedProvider.notifier).state = false;
      rethrow;
    }
  }

  Future<void> verifyOtp(String phone, String otp) async {
    state = const AsyncValue.loading();
    try {
      final authModel = await ref.read(apiServiceProvider).verifyOtp(phone, otp);
      dev.log('OTP verification successful, saving tokens', name: 'AuthController');
      await ref.read(tokenStorageProvider).saveTokens(
            accessToken: authModel.accessToken,
            refreshToken: authModel.refreshToken,
          );
      state = AsyncValue.data(authModel);
      ref.read(isAuthenticatedProvider.notifier).state = true;
      await ref.read(userDataProviderProvider.notifier).refresh();
    } catch (e, st) {
      dev.log('OTP verification error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<bool> signup(UserModel user) async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(apiServiceProvider);
      await authService.signUp(user);
      state = AsyncValue.data(state.valueOrNull);
      return true;
    } catch (e, st) {
      dev.log('Signup error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      final authService = ref.read(apiServiceProvider);
      await authService.logout();
      dev.log('Logout successful, clearing tokens', name: 'AuthController');
    } catch (e) {
      dev.log('Logout API error: $e', name: 'AuthController');
    } finally {
      try {
        await ref.read(tokenStorageProvider).clearTokens();
        state = const AsyncValue.data(null);
        ref.read(isAuthenticatedProvider.notifier).state = false;
        await ref.read(userDataProviderProvider.notifier).refresh();
      } catch (e, st) {
        dev.log('Error clearing local data: $e', name: 'AuthController');
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> updateProfile(UserModel profile) async {
    state = const AsyncValue.loading();
    try {
      final currentState = state.valueOrNull;
      if (currentState == null) {
        throw Exception('Not authenticated');
      }
      final updatedUser = await ref.read(apiServiceProvider).updateUserProfile(profile);
      await ref.read(userDataProviderProvider.notifier).updateUserData(updatedUser);
      state = AsyncValue.data(currentState);
    } catch (e, st) {
      dev.log('Profile update error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> requestPasswordReset(String email) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(apiServiceProvider).requestPasswordReset(email);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      dev.log('Request password reset error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> verifyResetPasswordOtp(String email, String otp) async {
    state = const AsyncValue.loading();
    try {
      final result = await ref.read(apiServiceProvider).verifyOtpForResetPassword(email, otp);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, st) {
      dev.log('Password reset verification error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> resetPassword(String email, String newPassword, String confirmPassword) async {
    state = const AsyncValue.loading();
    try {
      await ref.read(apiServiceProvider).resetPassword(email, newPassword, confirmPassword);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      dev.log('Password reset error: $e', name: 'AuthController');
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    try {
      final authState = await future;
      final storage = ref.read(tokenStorageProvider);
      return authState != null && await storage.hasValidTokens;
    } catch (e) {
      dev.log('Authentication check error: $e', name: 'AuthController');
      return false;
    }
  }
}