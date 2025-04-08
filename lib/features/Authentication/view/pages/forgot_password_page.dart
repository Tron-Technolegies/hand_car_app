import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ForgotPasswordPage extends HookConsumerWidget {
  static const route = '/forgot_password';
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    
    // Watch the auth state for loading status
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
        return 'Please enter a valid email';
      }
      return null;
    }

    Future<void> handleSubmit() async {
      if (!formKey.value.currentState!.validate()) return;

      try {
        await ref
            .read(authControllerProvider.notifier)
            .requestPasswordReset(emailController.text.trim());


        
        emailController.clear();
        formKey.value.currentState!.reset();
        
        if (context.mounted) {
          SnackbarUtil.showsnackbar(
            message: "Password reset link sent to your email",
            showretry: false,
          );
        }
      } catch (e) {
        SnackbarUtil.showsnackbar(

          message: e.toString(),
          showretry: true,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Form(
          key: formKey.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SvgPicture.asset(Assets.icons.handCarIcon),
              ),
              SizedBox(height: context.space.space_200),
              Text(
                "Forgot Password",
                style: context.typography.h3,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.space.space_200),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
              ),
              SizedBox(height: context.space.space_200),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
                child: ButtonWidget(
                  label: isLoading ? "Sending..." : "Continue",
                  onTap: handleSubmit,
                ),
              ),
              SizedBox(height: context.space.space_200),
              Center(
                child: Text(
                  "We'll send you an email with instructions to reset your password",
                  style: context.typography.bodySemiBold.copyWith(
                    color: const Color(0xff7A7A7A),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}