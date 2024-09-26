import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class GenuinePartsContainer extends StatelessWidget {
  final String title;
  final String digit;
  final LinearGradient gradient;
  final String image;
  const GenuinePartsContainer(
      {super.key,
      required this.title,
      required this.digit,
      required this.gradient,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.all(context.space.space_200),
        decoration: BoxDecoration(
          gradient: gradient, // Blue background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    digit,
                    style: context.typography.h2
                        .copyWith(color: context.colors.white),
                  ),
                  Image.asset(image, height: 50, width: 50),
                ],
              ),
              Text(
                title,
                style:
                    context.typography.h2.copyWith(color: context.colors.white),
              ),
            ]),
      ),
    );
  }
}
