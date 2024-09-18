import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
            SizedBox(height: context.space.space_200),
            OtpTextField(
              numberOfFields: 6,
              borderColor: context.colors.primary,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) {
                // showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //           title: Text("Verification Code"),
                //           content: Text('Code entered is $verificationCode'),
                //         ));
              },
            ),
       
            SizedBox(height: context.space.space_200),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ButtonWidget(label: "Login", onTap: () {
                   
                  })),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(onPressed: () {}, child: const Text("Sign Up")),
                TextButton(onPressed: () {}, child: const Text("Forgot Password")),
              ],
            )
          ],
        ),
      ),
    );
  }
}