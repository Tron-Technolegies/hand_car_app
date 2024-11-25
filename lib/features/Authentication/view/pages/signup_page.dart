import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/signup_controller.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignupPage extends HookConsumerWidget {
  static const route = '/signup_page';

  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final isLoading = useState(false);

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
              _buildTextInput(
                context,
                controller: nameController,
                label: "Enter Your Name",
                icon: Icons.person,
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: context.space.space_200),
              _buildTextInput(
                context,
                controller: emailController,
                label: "Enter Your Email",
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: context.space.space_200),
              _buildTextInput(
                context,
                controller: phoneController,
                label: "Enter Your Phone Number",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              SizedBox(height: context.space.space_200),
              _buildTextInput(
                context,
                controller: passwordController,
                label: "Enter Password",
                icon: Icons.lock,
                obscureText: true,
              ),
              SizedBox(height: context.space.space_200),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: ButtonWidget(
                  label: isLoading.value ? "Signing up..." : "Sign Up",
                  onTap: () async {
                    if (!_validateInputs(
                      context,
                      nameController.text,
                      emailController.text,
                      phoneController.text,
                      passwordController.text,
                    )) return;

                    isLoading.value = true;
                    FocusScope.of(context).unfocus();

                    try {
                 ref
                          .read(signupControllerProvider.notifier)
                          .signUp(
                            nameController.text.trim(),
                            emailController.text.trim(),
                            phoneController.text.trim(),
                            passwordController.text.trim(),
                          );

                      if (context.mounted) {
                        context.go(NavigationPage.route);
                      }
                    } catch (error) {
                      SnackbarUtil.showsnackbar(
                        message: "Signup failed: $error",
                        showretry: false,
                      );
                    } finally {
                      isLoading.value = false;
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextInput(
    BuildContext context, {
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: context.space.space_200),
          child: Text(
            label,
            style: context.typography.h3,
          ),
        ),
        SizedBox(height: context.space.space_200),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              labelText: label,
              prefixIcon: Icon(icon),
            ),
          ),
        ),
      ],
    );
  }

  bool _validateInputs(
    BuildContext context,
    String name,
    String email,
    String phone,
    String password,
  ) {
    if (name.isEmpty || email.isEmpty || phone.isEmpty || password.isEmpty) {
      SnackbarUtil.showsnackbar(
        message: "All fields are required",
        showretry: false,
      );
      return false;
    }

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      SnackbarUtil.showsnackbar(
        message: "Please enter a valid email address",
        showretry: false,
      );
      return false;
    }

    if (phone.length < 10) {
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