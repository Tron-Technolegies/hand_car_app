import 'dart:async';
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
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/custom_toast.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer({required this.duration});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

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
    final selectedCountryCode = useState('971');
    final debouncer = useRef(Debouncer(duration: const Duration(milliseconds: 300)));

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
          log('Starting login process');
          CustomToast.showSuccess("Logging in...");

          final cleanPhoneNumber =
              phoneController.text.replaceAll(RegExp(r'[^\d]'), '');
          final fullPhoneNumber =
              '${selectedCountryCode.value}$cleanPhoneNumber';

          await ref.read(authControllerProvider.notifier).login(
                fullPhoneNumber,
                passwordController.text,
              );

          log('Login success block reached');
          CustomToast.showSuccess("Login Successful");
          await Future.delayed(const Duration(milliseconds: 2500));
          if (context.mounted) {
            log('Navigating to navigation page');
            debouncer.value.run(() => context.go(NavigationPage.route));
          }
        } catch (e) {
          log('Login error: $e');
          String errorMessage = 'Login failed';
          final errorString = e.toString().toLowerCase();
          if (errorString.contains('invalid') ||
              errorString.contains('not found')) {
            errorMessage = 'Invalid phone number or password';
          }
          CustomToast.showError(errorMessage);
        }
      } else {
        log('Form validation failed');
        CustomToast.showError("Please fill all fields correctly");
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Center(
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
                  Center(
                    child: SvgPicture.asset(
                      Assets.icons.handCarIcon,
                      height: 80,
                    ),
                  ),
                  SizedBox(height: context.space.space_300),
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
                    validator: (value) =>
                        validatePhoneNumber(value, selectedCountryCode.value),
                  ),
                  SizedBox(height: context.space.space_250),
                  Text(
                    "Password",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  SizedBox(height: context.space.space_150),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
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
                        child: ButtonWidget(
                          label:
                              loginState.isLoading ? "Logging in..." : "Login",
                          onTap: loginState.isLoading ? null : handleLogin,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
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
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.space.space_200),
                        child: Text(
                          'OR',
                          style: context.typography.bodyMedium
                              .copyWith(color: Colors.grey),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  SizedBox(height: context.space.space_250),
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
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () => context.push(SignupPage.route),
                        child: Text(
                          "Sign Up",
                          style: context.typography.bodyMedium
                              .copyWith(color: context.colors.warning),
                        ),
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