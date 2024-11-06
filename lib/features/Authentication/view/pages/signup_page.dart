import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/login_with_otp_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  static const routeName = 'signup_page';
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final name = useTextEditingController();
    final email = useTextEditingController();
    final phone = useTextEditingController();
    final password = useTextEditingController();
    final isLoading = useState(false);

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
              // ... Your existing UI code ...
Center(
                child: SvgPicture.asset(Assets.icons.handCarIcon),
              ),
              Padding(
                padding: EdgeInsets.only(left: context.space.space_200),
                child: Text(
                  "Enter Your Name",
                  style: context.typography.h3,
                ),
              ),
              SizedBox(height: context.space.space_200),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: TextField(
                  controller: name,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(height: context.space.space_200),
              Padding(
                padding: EdgeInsets.only(left: context.space.space_200),
                child: Text(
                  "Enter Your Email",
                  style: context.typography.h3,
                ),
              ),
              SizedBox(height: context.space.space_200),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
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
                  controller: phone,
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
                  controller: password,
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
                padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ButtonWidget(
                    label: loginState.isLoading ? "Signing up..." : "Sign Up",
                    onTap: () async {
                            if (!_validateInputs(
                              context,
                              name.text,
                              email.text,
                              phone.text,
                              password.text,
                            )) {
                              return;
                            }

                            isLoading.value = true;
                            FocusScope.of(context).unfocus();

                            try {
                              final success = await ref
                                  .read(loginWithOtpControllerProvider.notifier)
                                  .signUp(
                                    name.text.trim(),
                                    email.text.trim(),
                                    phone.text.trim(),
                                    password.text.trim(),
                                  );

                              if (success && context.mounted) {
                                context.go('/');
                              }
                            } finally {
                              isLoading.value = false;
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

  bool _validateInputs(
    BuildContext context,
    String name,
    String email,
    String phone,
    String password,
  ) {
    if (name.trim().isEmpty ||
        email.trim().isEmpty ||
        phone.trim().isEmpty ||
        password.trim().isEmpty) {
      SnackbarUtil.showsnackbar(
        message: "All fields are required",
        showretry: false,
      );
      return false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email.trim())) {
      SnackbarUtil.showsnackbar(
        message: "Please enter a valid email address",
        showretry: false,
      );
      return false;
    }

    if (phone.trim().length < 10) {
      SnackbarUtil.showsnackbar(
        message: "Please enter a valid phone number",
        showretry: false,
      );
      return false;
    }

    if (password.length < 6) {
      SnackbarUtil.showsnackbar(
        message: "Password must be at least 6 characters long",
        showretry: false,
      );
      return false;
    }

    return true;
  }
}