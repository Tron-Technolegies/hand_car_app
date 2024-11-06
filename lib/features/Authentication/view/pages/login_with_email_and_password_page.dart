import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/login_with_otp_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';

class LoginWithEmailAndPasswordPage extends HookConsumerWidget {
  static const routeName = 'login_with_email_and_password_page';
  const LoginWithEmailAndPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();

    // Watch the login state
    final loginState = ref.watch(loginWithOtpControllerProvider);

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(context.space.space_200),
          child: Column(
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
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ButtonWidget(
                    label: loginState.isLoading ? "Logging in..." : "Login",
                    onTap: () async {
                      if (phoneController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        SnackbarUtil.showsnackbar(
                          message: "Enter a valid phone number and password",
                          showretry: false,
                        );
                        return;
                      }

                      FocusScope.of(context).unfocus();

                      final success = await ref
                          .read(loginWithOtpControllerProvider.notifier)
                         .loginWithPassword(phoneController.text, passwordController.text);

                      if (success && context.mounted) {
                        context.go('/');
                      } else if (context.mounted) {
                        SnackbarUtil.showsnackbar(
                          message: "Login failed. Please try again.",
                          showretry: false,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
