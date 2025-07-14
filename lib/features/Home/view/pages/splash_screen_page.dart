// lib/features/Home/view/pages/splash_screen_page.dart
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/router/redirect.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/controller/user_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const route = '/splash_screen';
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _hasNavigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeAndNavigate();
    });
  }

  Future<void> _initializeAndNavigate() async {
    try {
      dev.log('Starting authentication initialization', name: 'SplashScreen');
      
      // Wait for authentication initialization to complete
      final authController = ref.read(authControllerProvider.notifier);
      await authController.initializeAuth();
      
      // Give a small delay to ensure all state is properly set
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (mounted && !_hasNavigated) {
        _navigateToNextScreen();
      }
    } catch (e) {
      dev.log('Error during initialization: $e', name: 'SplashScreen');
      if (mounted && !_hasNavigated) {
        _navigateToNextScreen();
      }
    }
  }

  void _navigateToNextScreen() {
    if (_hasNavigated) return;
    
    _hasNavigated = true;
    
    final tokenStorage = ref.read(tokenStorageProvider);
    final authState = ref.read(authControllerProvider);
    final userState = ref.read(userDataProviderProvider);
    final isAuthenticated = ref.read(isAuthenticatedProvider);
    
    dev.log(
      'Navigation decision - '
      'AuthState: ${authState.valueOrNull?.isAuthenticated} | '
      'HasValidTokens: ${tokenStorage.hasValidTokens} | '
      'UserLoaded: ${userState.valueOrNull != null} | '
      'IsAuthenticated: $isAuthenticated',
      name: 'SplashScreen',
    );
    
    // More robust authentication check
    final isUserAuthenticated = tokenStorage.hasValidTokens &&
        authState.valueOrNull != null &&
        authState.valueOrNull!.isAuthenticated &&
        authState.valueOrNull!.isTokenValid &&
        userState.valueOrNull != null;
    
    // Update the isAuthenticated provider if needed
    if (isAuthenticated != isUserAuthenticated) {
      ref.read(isAuthenticatedProvider.notifier).state = isUserAuthenticated;
      dev.log('Updated isAuthenticated from $isAuthenticated to $isUserAuthenticated', name: 'SplashScreen');
    }
    
    final route = RedirectRouter.getPostSplashRoute(
      isUserAuthenticated,
      RedirectRouter.isOnboardingCompleted(),
    );
    
    dev.log('Navigating to: $route', name: 'SplashScreen');
    context.go(route);
  }

  @override
  Widget build(BuildContext context) {
    // Remove the listener since we're handling navigation manually
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.handCarIcon),
            SizedBox(height: context.space.space_250),
            // Text(
            //   "HandCar",
            //   style: context.typography.h1.copyWith(
            //     color: context.colors.primary,
            //   ),
            // ),
            // const SizedBox(height: 20),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}