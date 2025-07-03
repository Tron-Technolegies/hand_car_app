// lib/features/Home/view/pages/onbording_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/router/redirect.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class OnbordingScreenPage extends ConsumerWidget {
  static const route = '/onbording_screen_page';
  final Color kDarkBlueColor = const Color(0xFF053149);

  const OnbordingScreenPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final animationHeight = screenHeight * 0.4;
    final topMarginPercentage = 0.5;
    final titleFontSize = screenHeight * 0.035;
    final bodyFontSize = screenHeight * 0.02;
    return OnBoardingSlider(
      finishButtonText: 'Get Started with Phone',
      onFinish: () async {
        await RedirectRouter.completeOnboarding();
        if (context.mounted) {
          context.go(LoginWithPhoneAndPasswordPage.route);
        }
      },
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: context.colors.primary,
      ),
      skipTextButton: Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: context.colors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Text(
        'Phone Login',
        style: TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () async {
        await RedirectRouter.completeOnboarding();
        if (context.mounted) {
          context.go(LoginWithPhoneAndPasswordPage.route);
        }
      },
      controllerColor: context.colors.primary,
      totalPage: 4,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.space.space_400,
            ),
            child: Lottie.asset(
              Assets.animations.carAnimation,
              width: screenWidth * 0.8,
              height: animationHeight,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: context.space.space_400,
                vertical: context.space.space_500),
            child: Lottie.asset(
              Assets.animations.spareAnimation,
              width: screenWidth * 0.8,
              height: animationHeight,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.space.space_400,
            ),
            child: Lottie.asset(
              Assets.animations.carWash,
              width: screenWidth * 0.8,
              height: animationHeight,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.space.space_400,
            ),
            child: Lottie.asset(
              Assets.animations.completeProtection,
              width: screenWidth * 0.8,
              height: animationHeight,
            ),
          ),
        ),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: context.space.space_100 * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * topMarginPercentage),
              Text(
                'Welcome to Hand Car!',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(height: context.space.space_100),
              Text(
                'Your one-stop solution for all car needs. Experience seamless services with just a few taps!',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * topMarginPercentage),
              Text(
                'Professional Car Service',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              Text(
                'And',
                textAlign: TextAlign.center,
                style: context.typography.h3,
              ),
              Text(
                'Genuine Car Spares',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(height: context.space.space_200),
              Text(
                'With Hand Car, you can count on our professional car service and genuine car spares.',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: context.space.space_100 * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * topMarginPercentage),
              Text(
                'Professional Wash & Painting',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(height: context.space.space_250),
              Text(
                'Revitalize your car\'s look with our professional wash and painting services.',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: context.space.space_100 * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: screenHeight * topMarginPercentage),
              Text(
                'Unlock Premium Benefits',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(height: context.space.space_250),
              Text(
                'Elevate your Hand Car experience with our Premium Subscription.',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
