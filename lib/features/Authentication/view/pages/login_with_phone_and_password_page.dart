import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/signup_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';

class LoginWithPhoneAndPasswordPage extends HookConsumerWidget {
  static const route = '/LoginWithPhoneAndPasswordPage';

  const LoginWithPhoneAndPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authState = ref.watch(signupControllerProvider);
    final focusNode1 = useFocusNode();
    final focusNode2 = useFocusNode();

    // Watch the authentication state


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
                child: ButtonWidget(
                  label: authState.isLoading ? "Logging in..." : "Login",
                  onTap: () async {
                    if (phoneController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      SnackbarUtil.showsnackbar(
                        message: "Enter a valid phone number and password",
                        showretry: false,
                      );
                      return;
                    }

                    // Attempt to log in
             ref
                        .read(signupControllerProvider.notifier)
                        .login(phoneController.text, passwordController.text);
                    authState.authenticated
                        ? phoneController.clear()
                        : passwordController.clear();
                        if(authState.authenticated){
                          context.go(NavigationPage.route);
                        }
                    focusNode1.unfocus();
                    focusNode2.unfocus();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
