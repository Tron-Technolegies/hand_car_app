import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_controller.g.dart';

// Provider for TokenStorage
final tokenStorageProvider = Provider((ref) => TokenStorage());

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthModel?> build() async {
    final tokenStorage = ref.read(tokenStorageProvider);
    
    // Check if we have tokens stored
    if (tokenStorage.hasTokens) {
      final accessToken = tokenStorage.getAccessToken()!;
      final refreshToken = tokenStorage.getRefreshToken()!;
      
      // Create AuthModel from stored tokens
      return AuthModel(
        accessToken: accessToken,
        refreshToken: refreshToken,
        message: 'Restored from storage',
      );
    }
    return null;
  }

  Future<void> login(String username, String password) async {
    state = const AsyncValue.loading();
    try {
      final Map<String, dynamic> loginResponse =
          await ref.read(apiServiceProvider).login(username, password);

      final authModel = AuthModel.fromJson(loginResponse);
      
      // Save tokens to storage
      await ref.read(tokenStorageProvider).saveTokens(
        accessToken: authModel.accessToken,
        refreshToken: authModel.refreshToken,
      );
           
      
      state = AsyncValue.data(authModel);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  
  Future<void> signup(UserModel user) async {
    state = const AsyncValue.loading();
    
    try {
      final message = await ref.read(apiServiceProvider).signUp(user);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }



  Future<void> logout() async {
    state = const AsyncValue.loading();
    try {
      await ref.read(apiServiceProvider).logout();
      // Clear stored tokens
      await ref.read(tokenStorageProvider).clearTokens();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}