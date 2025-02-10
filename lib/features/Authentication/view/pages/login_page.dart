import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/router/router.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/view/pages/login_with_phone_and_password_page.dart';
import 'package:hand_car/features/Authentication/view/widgets/phone_auth_widget.dart';

import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  static const route = '/login_page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final isLoading = useState(false);
    final isMounted = context.mounted;

    // Watch auth state for loading status
    final authState = ref.watch(authControllerProvider);

    final selectedCountryCode = useState('971'); // Default to UAE

    /// Switches to phone/password login
    Future<void> switchToPhoneLogin() async {
      if (!isMounted) return;

      final storage = ref.read(storageProvider);
      await storage.write(
          'preferredLoginMethod', LoginWithPhoneAndPasswordPage.route);
      ref.read(loginPreferenceProvider.notifier).state =
          LoginWithPhoneAndPasswordPage.route;

      if (isMounted && context.mounted) {
        context.go(LoginWithPhoneAndPasswordPage.route);
      }
    }

    /// Validates the input (email or phone)
    String? validateInput(String? value) {
      if (value == null || value.trim().isEmpty) {
        return 'Please enter email or phone number';
      }
      return null;
    }

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

    /// Handles sending OTP
    Future<void> handleSendOtp() async {
      if (!isMounted) return;

      /// Validate input
      final input = controller.text.trim();
      if (validateInput(input) != null) {
        SnackbarUtil.showsnackbar(
          message: "Enter email or mobile number",
          showretry: true,
        );
        return;
      }

      try {
        isLoading.value = true;
        await ref.read(authControllerProvider.notifier).sendOtp(input);

        if (isMounted && context.mounted) {
          // Navigate to OTP verification page
          context.push('/otp/$input');
        }
      } catch (e) {
        if (isMounted) {
          SnackbarUtil.showsnackbar(
            message: e.toString(),
            showretry: true,
          );
        }
      } finally {
        if (isMounted) {
          isLoading.value = false;
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton.icon(
            onPressed: switchToPhoneLogin,
            icon: const Icon(Icons.phone),
            label: const Text('Use Phone Login'),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SvgPicture.asset(Assets.icons.handCarIcon),
            ),
            SizedBox(height: context.space.space_200),
            Center(
              //
              child: Text(
                "Enter Your Registred Mobile Number",
                style: context.typography.h3,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: context.space.space_200),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: PhoneAuthField(
                controller: controller,
                onCountryChanged: (code) {
                  selectedCountryCode.value = code;
                },
                validator: (value) => validatePhoneNumber(
                  value,
                  selectedCountryCode.value,
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
                  label: isLoading.value || authState.isLoading
                      ? "Sending OTP..."
                      : "Generate OTP",
                  onTap: () {
                    if (!(isLoading.value || authState.isLoading)) {
                      handleSendOtp();
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: context.space.space_200),
            Center(
              child: Text(
                textAlign: TextAlign.center,
                "By signing in you are agreeing to handcar's \nTerms of use and Privacy policy",
                style: context.typography.bodySemiBold.copyWith(
                  color: const Color(0xff7A7A7A),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
