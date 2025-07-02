// lib/features/Home/view/pages/splash_screen_page.dart
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/router/redirect.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const route = '/splash_screen';
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authController = ref.read(authControllerProvider.notifier);
      authController.initializeAuth();
      // Fallback navigation after 5 seconds
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && !ref.read(authControllerProvider).isLoading) {
          final route = RedirectRouter.getPostSplashRoute(
            ref.read(isAuthenticatedProvider),
            RedirectRouter.isOnboardingCompleted(),
          );
          dev.log('Timeout: Navigating to $route', name: 'SplashScreen');
          context.go(route);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authControllerProvider, (previous, next) {
      if (!next.isLoading && mounted) {
        final route = RedirectRouter.getPostSplashRoute(
          ref.read(isAuthenticatedProvider),
          RedirectRouter.isOnboardingCompleted(),
        );
        dev.log('Auth state changed: Navigating to $route', name: 'SplashScreen');
        context.go(route);
      }
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.handCarIcon),
            SizedBox(height: context.space.space_250),
            Text(
              "HandCar",
              style: context.typography.h1.copyWith(
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}