import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/custom_toast.dart';
import 'package:hand_car/core/widgets/auth_field_widget.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/model/user_model.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/widgets/phone_auth_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  static const route = '/signup_page';
  const SignupPage({super.key});

  String? validatePhoneNumber(String? value, String countryCode) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length < 8 || digitsOnly.length > 15) {
      return 'Invalid phone number length';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final authState = ref.watch(authControllerProvider);
    final selectedCountryCode = useState('971');

    Future<void> handleSignup() async {
      if (formKey.value.currentState?.validate() ?? false) {
        try {
          log('Starting signup process');
          CustomToast.show("Creating account...");

          final cleanPhoneNumber = phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
          final fullPhoneNumber = '${selectedCountryCode.value}$cleanPhoneNumber';

          final success = await ref.read(authControllerProvider.notifier).signup(
                UserModel(
                  name: nameController.text.trim(),
                  email: emailController.text.trim(),
                  phone: fullPhoneNumber,
                  password: passwordController.text,
                ),
              );

          if (success) {
            log('Signup success block reached');
          }
        } catch (e) {
          log('Signup error: $e');
          String errorMessage = 'Signup failed';
          if (e.toString().contains('email already exists')) {
            errorMessage = 'Email already exists';
          } else if (e.toString().contains('phone already exists')) {
            errorMessage = 'Phone number already exists';
          } else if (e.toString().contains('duplicate')) {
            errorMessage = 'Account already exists';
          }
          CustomToast.showError(errorMessage);
          return;
        }

        // Handle success outside try-catch
        CustomToast.showSuccess("Signup successful! Please login.");
        await Future.delayed(const Duration(milliseconds: 2100));
        if (context.mounted) {
          log('Navigating to login page');
          context.go(LoginWithPhoneAndPasswordPage.route);
        }
      } else {
        log('Form validation failed');
        CustomToast.showError("Please fill all fields correctly");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.space.space_200),
          child: Form(
            key: formKey.value,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SvgPicture.asset(Assets.icons.handCarIcon, height: 70),
                  ),
                  SizedBox(height: context.space.space_200),
                  Center(
                      child: Text("Register Yourself", style: context.typography.h2)),
                  SizedBox(height: context.space.space_500 * 2),
                  Text(
                    "Name",
                    style: context.typography.bodyLarge.copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_200),
                  AuthField(
                    padding: EdgeInsets.all(context.space.space_200),
                    controller: nameController,
                    hintText: "Enter Your Name",
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.space.space_200),
                  Text(
                    "Email",
                    style: context.typography.bodyLarge.copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_200),
                  AuthField(
                    padding: EdgeInsets.all(context.space.space_200),
                    controller: emailController,
                    hintText: "Enter Your Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                  ),
                  SizedBox(height: context.space.space_200),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone Number",
                        style: context.typography.bodyLarge.copyWith(color: context.colors.primaryTxt),
                      ),
                      SizedBox(height: context.space.space_200),
                      PhoneAuthField(
                        controller: phoneController,
                        onCountryChanged: (countryCode) {
                          selectedCountryCode.value = countryCode;
                        },
                        validator: (value) => validatePhoneNumber(value, selectedCountryCode.value),
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_200),
                  Text(
                    "Password",
                    style: context.typography.bodyLarge.copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_200),
                  AuthField(
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: context.space.space_200),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      label: authState.isLoading ? "Creating Account..." : "Create Account",
                      onTap: authState.isLoading ? null : handleSignup,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}