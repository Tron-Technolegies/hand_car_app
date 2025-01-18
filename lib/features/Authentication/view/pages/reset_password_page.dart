import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ResetPasswordPage extends HookConsumerWidget {
  static const route = '/reset-password/:uid/:token';
  final String uid;
  final String token;

  const ResetPasswordPage({
    super.key,
    required this.uid,
    required this.token,
  });

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
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final formKey = useState(GlobalKey<FormState>());
    
    // Watch the auth state for loading status
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    Future<void> handleSubmit() async {
      if (!formKey.value.currentState!.validate()) return;
      
      if (passwordController.text != confirmPasswordController.text) {
        SnackbarUtil.showsnackbar(
          message: "Passwords don't match",
          showretry: true,
        );
        return;
      }

      try {
        await ref
            .read(authControllerProvider.notifier)
            .resetPassword(uid, token, passwordController.text);
        
        if (context.mounted) {
          SnackbarUtil.showsnackbar(
            message: "Password reset successful",
            showretry: false,
          );
          context.go(LoginWithPhoneAndPasswordPage.route);
        }
      } catch (e) {
        SnackbarUtil.showsnackbar(
          message: e.toString(),
          showretry: true,
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Form(
          key: formKey.value,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Enter New Password',
                style: context.typography.h3,
              ),
              SizedBox(height: context.space.space_200),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'New Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: context.space.space_200),
              TextFormField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Password',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
                obscureText: true,
                validator: validatePassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              SizedBox(height: context.space.space_300),
              ButtonWidget(
                label: isLoading ? "Resetting..." : "Reset Password",
                onTap: () {
                  if (!isLoading) {
                    handleSubmit();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}