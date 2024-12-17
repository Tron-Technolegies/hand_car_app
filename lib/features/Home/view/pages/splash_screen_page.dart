import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
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
      // Delay navigation to ensure GoRouter is ready
      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          // Check if the user is logged in
          final authState = ref.read(authControllerProvider);

          final isAuthenticated = authState.maybeWhen(
            data: (auth) => auth != null, // User is logged in
            orElse: () => false,
          );

          // Navigate based on authentication state
          if (isAuthenticated) {
            context.go(NavigationPage.route); // Go to NavigationPage
          } else {
            context.go(OnbordingScreenPage.route); // Go to Onboarding
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Assets.icons.handCarIcon),
            const SizedBox(height: 20),
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