import 'package:hand_car/core/router/user_validation.dart';
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

  // Helper method to check authentication status
  Future<bool> isAuthenticated() async {
    final authState = await future;
    return authState != null;
  }
}