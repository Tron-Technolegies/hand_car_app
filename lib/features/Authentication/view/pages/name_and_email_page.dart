import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';

class NameAndEmailPage extends HookWidget {
  const NameAndEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
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
                "Enter Your Name",
                style: context.typography.h3,
              ),
            ),
            SizedBox(height: context.space.space_200),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Name',
                    prefixIcon: Icon(Icons.person),
                  )),
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
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter Email',
                    prefixIcon: Icon(Icons.email),
                  )),
            ),
            SizedBox(height: context.space.space_200),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: context.space.space_200),
              child: SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ButtonWidget(
                      label: "Save",
                      onTap: () {
                        log("Save Clicked");
                        if (nameController.text.isNotEmpty &&
                            emailController.text.isNotEmpty) {
                          context.pushReplacement('/');
                        } else {
                          SnackbarUtil.showsnackbar(
                              message: "Enter Name and a valid Email",
                              showretry: false);
                        }
                      })),
            ),
          ],
        ),
      ),
    );
  }
}
