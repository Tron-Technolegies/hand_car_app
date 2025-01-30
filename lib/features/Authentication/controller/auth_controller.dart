import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

// Provider for TokenStorage
final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthModel?> build() async {
    try {
      final tokenStorage = ref.read(tokenStorageProvider);
      final hasTokens = tokenStorage.hasTokens;

      if (hasTokens) {
        final accessToken = tokenStorage.getAccessToken();
        final refreshToken = tokenStorage.getRefreshToken();

        if (accessToken != null && refreshToken != null) {
          return AuthModel(
            accessToken: accessToken,
            refreshToken: refreshToken,
            message: 'Restored from storage',
          );
        }
      }
      return null;
    } catch (e) {
      // Log error and return null if token restoration fails
      return null;
    }
  }

  Future<void> login(String username, String password) async {
    try {
      state = const AsyncValue.loading();

      // Get auth service instance
      final authService = ref.read(apiServiceProvider);

      // Attempt login
      final authModel = await authService.login(username, password);

      // Save tokens if login successful
      await ref.read(tokenStorageProvider).saveTokens(
            accessToken: authModel.accessToken,
            refreshToken: authModel.refreshToken,
          );

      // Update state with successful login
      state = AsyncValue.data(authModel);
    } catch (error, stackTrace) {
      // Update state with error
      state = AsyncValue.error(error, stackTrace);
      rethrow; // Rethrow to allow error handling in UI
    }
  }

  Future<void> signup(UserModel user) async {
    try {
      state = const AsyncValue.loading();

      // Get auth service instance
      final authService = ref.read(apiServiceProvider);

      // Attempt signup
      await authService.signUp(user);

      // Set state to success with no data
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      // Update state with error
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      state = const AsyncValue.loading();

      // Get auth service instance
      final authService = ref.read(apiServiceProvider);
      final tokenStorage = ref.read(tokenStorageProvider);

      // Attempt logout
      await authService.logout();

      // Clear tokens
      await tokenStorage.clearTokens();

      // Update state to logged out
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      // Handle logout errors
      state = AsyncValue.error(error, stackTrace);

      // Still clear tokens even if logout fails
      try {
        await ref.read(tokenStorageProvider).clearTokens();
      } catch (e) {
        // Log token clearing error but don't change state
      }

      rethrow;
    }
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      state = const AsyncValue.loading();

      final authService = ref.read(apiServiceProvider);
      await authService.requestPasswordReset(email);

      // Keep the current state after successful request
      state = state;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> resetPassword(
      String uid, String token, String newPassword) async {
    try {
      state = const AsyncValue.loading();

      final authService = ref.read(apiServiceProvider);
      await authService.resetPassword(uid, token, newPassword);

      // Reset state to null as user needs to login with new password
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> sendOtp(String phoneNumber) async {
    try {
      state = const AsyncValue.loading();

      final authService = ref.read(apiServiceProvider);
      await authService.sendOtp(phoneNumber);

      // Keep current state after successful OTP send
      state = state;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> verifyOtp(String phoneNumber, String otp) async {
    try {
      state = const AsyncValue.loading();

      final authService = ref.read(apiServiceProvider);
      final authModel = await authService.verifyOtp(phoneNumber, otp);

      // Save tokens
      await ref.read(tokenStorageProvider).saveTokens(
            accessToken: authModel.accessToken,
            refreshToken: authModel.refreshToken,
          );

      // Update state with successful login
      state = AsyncValue.data(authModel);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> updateProfile(UserModel updatedProfile) async {
    try {
      state = const AsyncValue.loading();

      // Get the current auth model first
      final currentState = state.value;
      if (currentState == null) {
        throw Exception('Not authenticated');
      }

      // Update profile and get updated user data
      final updatedUser =
          await ref.read(apiServiceProvider).updateUserProfile(updatedProfile);

      // Refresh user data in provider
      ref
          .read(userDataProviderProvider.notifier)
          .update((state) => updatedUser);

      // Keep the existing auth state
      state = AsyncValue.data(currentState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  // Helper method to check authentication status
  Future<bool> isAuthenticated() async {
    final authState = await future;
    return authState != null;
  }
}
