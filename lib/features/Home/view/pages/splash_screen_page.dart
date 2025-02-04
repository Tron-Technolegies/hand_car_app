import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/service/authentication_service.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/features/Home/view/pages/onbording_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/router/router.dart';

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

    Future.microtask(() async {
      final authService = ref.read(apiServiceProvider);
      final isAuthenticated = authService.isAuthenticated;
      final onboardingCompleted = ref.read(onboardingCompletedProvider);

      Timer(const Duration(seconds: 2), () {
        if (mounted) {
          if (isAuthenticated) {
            context.go(NavigationPage.route);
          } else if (!onboardingCompleted) {
            context.go(OnbordingScreenPage.route);
          } else {
            // Go to preferred login route if onboarding is completed
            final preferredLoginRoute = ref.read(loginPreferenceProvider);
            context.go(preferredLoginRoute);
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
