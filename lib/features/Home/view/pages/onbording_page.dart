import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

/// Onbording Screen Page
class OnbordingScreenPage extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);

  const OnbordingScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      finishButtonText: 'Get Started',
      onFinish: () {
        context.go('/');
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
        'Login',
        style: TextStyle(
          fontSize: 16,
          color: kDarkBlueColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailingFunction: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginWithPhoneAndPasswordPage()),
        );
      },
      controllerColor: context.colors.primary,
      totalPage: 4,
      headerBackgroundColor: Colors.white,
      pageBackgroundColor: Colors.white,
      background: [
        Lottie.asset(Assets.animations.carAnimation, width: 500, height: 520),
        Lottie.asset(Assets.animations.spareAnimation, width: 450, height: 400),
        Lottie.asset(Assets.animations.carWash, width: 450, height: 450),
        Lottie.asset(Assets.animations.completeProtection,
            width: 450, height: 450),
      ],
      speed: 1.8,
      pageBodies: [
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding:
              EdgeInsets.symmetric(horizontal: context.space.space_100 * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Welcome to Hand Car!',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(
                height: context.space.space_100,
              ),
              Text(
                'Your one-stop solution for all car needs. Experience seamless services with just a few taps!',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium
                    .copyWith(color: Colors.grey.shade600),
              ),
              SizedBox(
                height: context.space.space_200,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 480,
              ),
              Text(
                'Professional Car Service',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              Text(
                'and',
                textAlign: TextAlign.center,
                style: context.typography.h3,
              ),
              Text(
                'Genuine Car Spares',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(
                height: context.space.space_200,
              ),
              Text(
                'With Hand Car, you can count on our professional car service and genuine car spares. Experience the best of our car repair and maintenance services.',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium
                    .copyWith(color: Colors.grey.shade600),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding:
              EdgeInsets.symmetric(horizontal: context.space.space_100 * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 500,
              ),
              Text(
                'Professional Wash & Painting',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(
                height: context.space.space_250,
              ),
              Text(
                'Revitalize your car’s look with our professional wash and painting services. Sparkling clean and vibrant as new!',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium
                    .copyWith(color: Colors.grey.shade600),
              ),
              SizedBox(
                height: context.space.space_200,
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding:
              EdgeInsets.symmetric(horizontal: context.space.space_100 * 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 500,
              ),
              Text(
                'Unlock Premium Benefits',
                textAlign: TextAlign.center,
                style: context.typography.h2,
              ),
              SizedBox(
                height: context.space.space_250,
              ),
              Text(
                'Elevate your Hand Car experience with our Premium Subscription. Enjoy exclusive benefits, discounted rates, and priority service every time.',
                textAlign: TextAlign.center,
                style: context.typography.bodyLargeMedium
                    .copyWith(color: Colors.grey.shade600),
              ),
              SizedBox(
                height: context.space.space_200,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
