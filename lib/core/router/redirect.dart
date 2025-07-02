import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hand_car/features/Accessories/view/pages/cart_page.dart';
import 'package:hand_car/features/Accessories/view/pages/checkout_page.dart';
import 'package:hand_car/features/Accessories/view/pages/my_orders_page.dart';
import 'package:hand_car/features/Accessories/view/pages/wishlist_page.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/edit_profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_otp_page.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/otp_page.dart';
import 'package:hand_car/features/Authentication/view/pages/profile_page.dart';
import 'package:hand_car/features/Authentication/view/pages/reset_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
import 'package:hand_car/features/Home/view/pages/splash_screen_page.dart';
import 'package:hand_car/features/car_service/view/pages/services_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// lib/core/router/redirect.dart


class RedirectRouter {
  static final _storage = GetStorage();
  static const _onboardingKey = 'onboarding_completed';

  static Future<String?> protectRoutes(
    BuildContext context,
    GoRouterState state,
    ProviderContainer container,
  ) async {
    final tokenStorage = container.read(tokenStorageProvider);
    final authController = container.read(authControllerProvider.notifier);
    final authState = container.read(authControllerProvider);
    final userState = container.read(userDataProviderProvider);
    final isAuthenticated = container.read(isAuthenticatedProvider);

    final onboardingCompleted = _storage.read(_onboardingKey) == true;

    dev.log(
      'Route Protection: ${state.matchedLocation} | '
      'AuthState: ${authState.valueOrNull?.isAuthenticated} | '
      'TokensValid: ${tokenStorage.hasValidTokens} | '
      'UserLoaded: ${userState.valueOrNull != null} | '
      'IsAuthenticated: $isAuthenticated | '
      'Onboarding: $onboardingCompleted',
      name: 'Router',
    );

    // Allow splash screen without redirect
    if (state.matchedLocation == SplashScreen.route) {
      return null;
    }

    // Check authentication status
    final isAuthValid = tokenStorage.hasValidTokens &&
        authState.valueOrNull != null &&
        authState.valueOrNull!.isAuthenticated &&
        authState.valueOrNull!.isTokenValid &&
        userState.valueOrNull != null;

    // Update isAuthenticatedProvider if necessary
    if (isAuthenticated != isAuthValid) {
      container.read(isAuthenticatedProvider.notifier).state = isAuthValid;
      dev.log('Updated isAuthenticatedProvider to $isAuthValid', name: 'Router');
    }

    // Restore auth and user state if needed
    if ((authState.valueOrNull == null || userState.valueOrNull == null) &&
        tokenStorage.hasValidTokens &&
        !authState.isLoading &&
        !userState.isLoading) {
      dev.log('Restoring auth and user state', name: ' scolded');
      try {
        final accessToken = await tokenStorage.getAccessToken();
        if (accessToken != null) {
          await authController.fetchCurrentUser(accessToken);
          await container.read(userDataProviderProvider.notifier).refresh();
          final updatedAuthState = container.read(authControllerProvider);
          final updatedUserState = container.read(userDataProviderProvider);
          if (updatedAuthState.valueOrNull == null ||
              !updatedAuthState.valueOrNull!.isAuthenticated ||
              updatedUserState.valueOrNull == null) {
            dev.log('Failed to restore state, clearing tokens', name: 'Router');
            await tokenStorage.clearTokens();
            container.read(isAuthenticatedProvider.notifier).state = false;
            return onboardingCompleted ? LoginWithPhoneAndPasswordPage.route : OnbordingScreenPage.route;
          }
        } else {
          dev.log('No access token, clearing tokens', name: 'Router');
          await tokenStorage.clearTokens();
          container.read(isAuthenticatedProvider.notifier).state = false;
          return onboardingCompleted ? LoginWithPhoneAndPasswordPage.route : OnbordingScreenPage.route;
        }
      } catch (e, st) {
        dev.log('Error restoring state: $e', name: 'Router', stackTrace: st);
        await tokenStorage.clearTokens();
        container.read(isAuthenticatedProvider.notifier).state = false;
        return onboardingCompleted ? LoginWithPhoneAndPasswordPage.route : OnbordingScreenPage.route;
      }
    }

    // Allow navigation to /navigation if authenticated
    if (isAuthenticated && state.matchedLocation == NavigationPage.route) {
      dev.log('Allowing access to navigation screen', name: 'Router');
      return null;
    }

    // Redirect authenticated users from auth routes
    if (isAuthenticated && _isAuthRoute(state.matchedLocation)) {
      dev.log('User authenticated, redirecting to navigation', name: 'Router');
      return NavigationPage.route;
    }

    // Redirect unauthenticated users from protected routes
    if (!isAuthenticated && _isProtectedRoute(state.matchedLocation)) {
      dev.log('User not authenticated, redirecting to login', name: 'Router');
      return onboardingCompleted ? LoginWithPhoneAndPasswordPage.route : OnbordingScreenPage.route;
    }

    // Allow password reset and OTP routes
    if (_isPasswordResetFlow(state.matchedLocation)) {
      dev.log('Allowing access to password reset flow: ${state.matchedLocation}', name: 'Router');
      return null;
    }

    dev.log('Allowing access to ${state.matchedLocation}', name: 'Router');
    return null;
  }

  static String getPostSplashRoute(bool isAuthenticated, bool onboardingCompleted) {
    if (!onboardingCompleted) {
      dev.log('Redirecting to onboarding', name: 'Router');
      return OnbordingScreenPage.route;
    } else if (isAuthenticated) {
      dev.log('Redirecting to navigation screen', name: 'Router');
      return NavigationPage.route;
    } else {
      dev.log('Redirecting to login', name: 'Router');
      return LoginWithPhoneAndPasswordPage.route;
    }
  }

  static bool _isAuthRoute(String location) {
    return [
      LoginWithPhoneAndPasswordPage.route,
      LoginPage.route,
      SignupPage.route,
      ForgotPasswordPage.route,
      OnbordingScreenPage.route,
    ].contains(location);
  }

  static bool _isProtectedRoute(String location) {
    return [
      NavigationPage.route,
      AccessoriesPage.route,
      ServicesPage.route,
      ProfilePage.route,
      EditProfileScreen.route,
      ShoppingCartScreen.route,
      CheckOutPage.route,
      WishlistScreen.route,
      MyOrdersPage.route,
    ].contains(location);
  }

  static bool _isPasswordResetFlow(String location) {
    return [
      ForgotPasswordPage.route,
      ForgotPasswordOtpPage.route,
      ResetPasswordPage.route,
      OtpPage.route,
    ].contains(location) || location.startsWith('/otp/');
  }

  static Future<void> completeOnboarding() async {
    await _storage.write(_onboardingKey, true);
    dev.log('Onboarding marked complete', name: 'Router');
  }

  static Future<void> resetOnboarding() async {
    await _storage.remove(_onboardingKey);
    dev.log('Onboarding reset', name: 'Router');
  }

  static bool isOnboardingCompleted() {
    final completed = _storage.read(_onboardingKey) == true;
    dev.log('Onboarding completed status: $completed', name: 'Router');
    return completed;
  }
}