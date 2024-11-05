import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';

class ContainerForHomePage extends StatelessWidget {
  final String text1;
  final String text2;
  final String text3;
  final String image;
  final VoidCallback onTap;
  const ContainerForHomePage(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.space.space_200),
      child: Container(
        decoration: BoxDecoration(color: context.colors.background),
        padding: EdgeInsets.all(context.space.space_200),
        child: Stack(children: [
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1,
                  style: context.typography.bodyLarge
                      .copyWith(color: context.colors.primaryTxt),
                ),
                Text(
                  text2,
                  style: context.typography.bodyLarge
                      .copyWith(color: context.colors.primaryTxt),
                ),
                SizedBox(
                  height: context.space.space_200,
                ),
                ButtonWidget(label: text3, onTap: onTap)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(image),
          ),
        ]),
      ),
    );
  }
}
