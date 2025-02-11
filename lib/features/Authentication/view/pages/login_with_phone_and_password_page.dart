

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/router/router.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/core/widgets/auth_field_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/forgot_password_page.dart';
import 'package:hand_car/features/Authentication/view/pages/login_page.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';
import 'package:hand_car/features/Authentication/view/widgets/phone_auth_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class LoginWithPhoneAndPasswordPage extends HookConsumerWidget {
  static const route = '/LoginWithPhoneAndPasswordPage';

  const LoginWithPhoneAndPasswordPage({super.key});

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

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    final isPasswordVisible = useState(false);
    final selectedCountryCode = useState('971'); // Default to UAE

    final loginState = ref.watch(authControllerProvider);

    void switchToOtpLogin() async {
      final storage = ref.read(storageProvider);
      await storage.write('preferredLoginMethod', LoginPage.route);
      ref.read(loginPreferenceProvider.notifier).state = LoginPage.route;
      if (context.mounted) {
        context.go(LoginPage.route);
      }
    }

    Future<void> handleLogin() async {
      if (formKey.value.currentState?.validate() ?? false) {
        try {
          final cleanPhoneNumber =
              phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
          final fullPhoneNumber =
              '${selectedCountryCode.value}$cleanPhoneNumber';

          await ref.read(authControllerProvider.notifier).login(
                fullPhoneNumber,
                passwordController.text,
              );

          final authState = ref.read(authControllerProvider);
          authState.whenOrNull(
            error: (error, stackTrace) {
              if (error.toString().contains('Invalid login credentials')) {
                SnackbarUtil.showsnackbar(
                  message: "Account doesn't exist. Please sign up first.",
                  showretry: true,
                );
              } else if (error.toString().contains('Invalid password')) {
                SnackbarUtil.showsnackbar(
                  message: "Invalid password. Please try again.",
                  showretry: false,
                );
              } else {
                SnackbarUtil.showsnackbar(
                  message: "Login failed. Please try again.",
                  showretry: false,
                );
              }
              log('Login error: $error');
              log('Stack trace: $stackTrace');
            },
            data: (_) {
              SnackbarUtil.showsnackbar(
                message: "Login Successful",
                showretry: false,
              );
            },
          );
        } catch (e) {
          log('Unexpected error during login: $e');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        // Center the entire content
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 400),
            padding: EdgeInsets.symmetric(
              horizontal: context.space.space_200,
              vertical: context.space.space_300,
            ),
            child: Form(
              key: formKey.value,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo section
                  Center(
                    child: SvgPicture.asset(
                      Assets.icons.handCarIcon,
                      height: 80, // Fixed height for consistency
                    ),
                  ),
                  SizedBox(height: context.space.space_300),

                  // Welcome text
                  Center(
                    child: Text(
                      "Welcome to Hand Car",
                      style: context.typography.h2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: context.space.space_200),
                  Center(
                    child: Text(
                      "Let’s Sign you in",
                      style: context.typography.h3,
                    ),
                  ),
                  SizedBox(height: context.space.space_300),

                  // Phone number section
                  Text(
                    "Phone Number",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_150),
                  PhoneAuthField(
                    controller: phoneController,
                    onCountryChanged: (countryCode) {
                      selectedCountryCode.value = countryCode;
                    },
                    validator: (value) => validatePhoneNumber(
                      value,
                      selectedCountryCode.value,
                    ),
                  ),
                  SizedBox(height: context.space.space_250),

                  // Password section
                  Text(
                    "Password",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_150),
                  // Password field
                  AuthField(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.space.space_200,
                      vertical: context.space.space_150,
                    ),
                    controller: passwordController,
                    hintText: "Enter Your Password",
                    keyboardType: TextInputType.visiblePassword,
                    isPassword: !isPasswordVisible.value,
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        isPasswordVisible.value = !isPasswordVisible.value;
                      },
                    ),
                    validator: validatePassword,
                  ),
                  SizedBox(height: context.space.space_300),

                  // Action buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Changed from spaceAround
                    children: [
                      Expanded(
                        // Added Expanded
                        child: OutlineButtonWidget(
                          label: 'Cancel',
                          onTap: () {
                            formKey.value.currentState?.reset();
                            phoneController.clear();
                            passwordController.clear();
                          },
                        ),
                      ),
                      SizedBox(width: context.space.space_200),
                      Expanded(
                        // Added Expanded
                        child: ButtonWidget(
                          label:
                              loginState.isLoading ? "Logging in..." : "Login",
                          onTap: () {
                            if (!loginState.isLoading) {
                              handleLogin();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),

                  // Additional options
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end, // Changed from spaceAround
                    children: [
                      TextButton(
                        onPressed: () => context.push(ForgotPasswordPage.route),
                        child: Text(
                          "Forgot Password?",
                          style: context.typography.bodyMedium.copyWith(
                            color: context.colors.primaryTxt,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),

                  // Divider section
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_200,
                        ),
                        child: Text(
                          'OR',
                          style: context.typography.bodyMedium.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),

                  // OTP login button
                  SizedBox(
                    width: double.infinity,
                    child: OutlineButtonWidget(
                      label: 'Login with OTP',
                      onTap: switchToOtpLogin,
                    ),
                  ),
                  SizedBox(height: context.space.space_250),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.push(SignupPage.route),
                        child: Text("Sign Up",
                            style: context.typography.bodyMedium
                                .copyWith(color: context.colors.warning)),
                      ),
                    ],
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
