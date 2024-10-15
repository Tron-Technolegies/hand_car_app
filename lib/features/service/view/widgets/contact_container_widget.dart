import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

//
class ContactContainer extends StatelessWidget {
  final String title;
  final SvgPicture? image;
  final String icon;
  const ContactContainer(
      {super.key, required this.title, this.image, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          color: context.colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: context.colors.primaryTxt,
          )),
      child: Center(
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(icon, height: 35, width: 35),
          SizedBox(width: context.space.space_100),
          Text(
            title,
            style: context.typography.bodyLargeSemiBold
                .copyWith(color: context.colors.green),
          ),
        ]),
      ),
    );
  }
}
