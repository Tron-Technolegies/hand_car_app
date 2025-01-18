import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/controller/auth_controller.dart';
import 'package:hand_car/features/Authentication/model/auth_model.dart';
import 'package:hand_car/features/Home/view/pages/navigation_page.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OtpPage extends HookConsumerWidget {
  static const route = '/otp';
  final String phoneOrEmail;
  
  const OtpPage({
    super.key,
    required this.phoneOrEmail,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpCode = useState<String>('');
    final isResending = useState(false);

    // Watch auth state
    final authState = ref.watch(authControllerProvider);

    // Listen to auth state changes for navigation
    ref.listen<AsyncValue<AuthModel?>>(
      authControllerProvider,
      (_, state) {
        state.whenOrNull(
          data: (auth) {
            if (auth != null) {
              // Navigate to main app on successful authentication
              context.go(NavigationPage.route);
            }
          },
          error: (error, _) {
            SnackbarUtil.showsnackbar(
              message: error.toString(),
              showretry: true,
            );
          },
        );
      },
    );

    Future<void> verifyOtp() async {
      if (otpCode.value.length != 6) {
        SnackbarUtil.showsnackbar(
          message: "Please enter complete OTP code",
          showretry: true,
        );
        return;
      }

      try {
        await ref.read(authControllerProvider.notifier).verifyOtp(
          phoneOrEmail,
          otpCode.value,
        );
      } catch (e) {
        SnackbarUtil.showsnackbar(
          message: "Invalid OTP. Please try again.",
          showretry: true,
        );
      }
    }

    Future<void> resendOtp() async {
      try {
        isResending.value = true;
        await ref.read(authControllerProvider.notifier).sendOtp(phoneOrEmail);
        
        if (context.mounted) {
          SnackbarUtil.showsnackbar(
            message: "OTP resent successfully",
            showretry: false,
          );
        }
      } catch (e) {
        if (context.mounted) {
          SnackbarUtil.showsnackbar(
            message: e.toString(),
            showretry: true,
          );
        }
      } finally {
        isResending.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
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
            Text(
              "Enter OTP",
              style: context.typography.h3,
            ),
            SizedBox(height: context.space.space_100),
            Text(
              "Please enter the verification code sent to\n$phoneOrEmail",
              textAlign: TextAlign.center,
              style: context.typography.bodyMedium.copyWith(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: context.space.space_200),
            OtpTextField(
              numberOfFields: 6,
              borderColor: context.colors.primary,
              focusedBorderColor: context.colors.primary,
              showFieldAsBox: true,
              onCodeChanged: (String code) {
                otpCode.value = code;
              },
              onSubmit: (String code) {
                otpCode.value = code;
                verifyOtp();
              },
            ),
            SizedBox(height: context.space.space_200),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Didn't receive OTP?",
                  style: context.typography.bodyMedium,
                ),
                TextButton(
                  onPressed: isResending.value ? null : resendOtp,
                  child: Text(
                    isResending.value ? "Sending..." : "Resend",
                    style: context.typography.bodyMedium.copyWith(
                      color: context.colors.primary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.space.space_200),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: ElevatedButton(
                child: Text(authState.isLoading ? "Verifying..." : "Verify & Continue"),
                onPressed: authState.isLoading ? null : verifyOtp,
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