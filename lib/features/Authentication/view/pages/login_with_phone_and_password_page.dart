import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/signup_page.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class LoginWithPhoneAndPasswordPage extends HookConsumerWidget {
  static const route = '/LoginWithPhoneAndPasswordPage';

  const LoginWithPhoneAndPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final focusNode1 = useFocusNode();
    final focusNode2 = useFocusNode();

    // Watch the login state
    final loginState = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.space.space_200),
          child: Center(
            child: Column(
              spacing: context.space.space_100,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: SvgPicture.asset(Assets.icons.handCarIcon),
                ),
                SizedBox(height: context.space.space_200),
                Padding(
                  padding: EdgeInsets.only(left: context.space.space_200),
                  child: Text(
                    "Enter Your Phone Number",
                    style: context.typography.h3,
                  ),
                ),
                SizedBox(height: context.space.space_200),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_200),
                  child: TextField(
                    controller: phoneController,
                    focusNode: focusNode1,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Number',
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ),
                SizedBox(height: context.space.space_200),
                Padding(
                  padding: EdgeInsets.only(left: context.space.space_200),
                  child: Text(
                    "Enter Password",
                    style: context.typography.h3,
                  ),
                ),
                SizedBox(height: context.space.space_200),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_200),
                  child: TextField(
                    focusNode: focusNode2,
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                ),
                SizedBox(height: context.space.space_200),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      OutlineButtonWidget(
                        label: 'Cancel',
                        onTap: () {},
                      ),
                      ButtonWidget(
                          label:
                              loginState.isLoading ? "Logging in..." : "Login",
                          onTap: () async {
                            if (phoneController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              SnackbarUtil.showsnackbar(
                                message:
                                    "Enter a valid phone number and password",
                                showretry: false,
                              );
                              return;
                            }

                            // Trigger the login function
                            await ref
                                .read(authControllerProvider.notifier)
                                .login(
                                  phoneController.text,
                                  passwordController.text,
                                );

// Check for specific error states
                            final authState = ref.read(authControllerProvider);
                            authState.whenOrNull(
                              error: (error, stackTrace) {
                                SnackbarUtil.showsnackbar(
                                  message: error.toString(),
                                  showretry: false,
                                );
                                log('Login error: $error');
                              },
                            );
                          }),
                    ],
                  ),
                ),
                SizedBox(height: context.space.space_200),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: context.space.space_200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot Password?",
                            style: context.typography.bodyMedium
                                .copyWith(color: context.colors.primaryTxt),
                          )),
                      TextButton(
                          onPressed: () {
                            context.push(SignupPage.route);
                          },
                          child: Text(
                            "Sign Up",
                            style: context.typography.bodyMedium
                                .copyWith(color: context.colors.primaryTxt),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
