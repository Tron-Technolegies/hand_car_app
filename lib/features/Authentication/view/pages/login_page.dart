import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Authentication/view/pages/otp_page.dart';
import 'package:hand_car/gen/assets.gen.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=TextEditingController();
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
              "Login or signup with email or\n                  mobile number",
              style: context.typography.h3,
            ),
            SizedBox(height: context.space.space_200),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child:  TextField(
                controller: controller,
                  decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email or Mobile Number',
                prefixIcon: Icon(Icons.person),
              )),
            ),
            SizedBox(height: context.space.space_200),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ButtonWidget(label: "Login", onTap: () {
                    if(controller.text.isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpPage()));
                    }else{
                      SnackbarUtil.showsnackbar(message: "Enter Email or Mobile Number", showretry: true);
                    }
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
