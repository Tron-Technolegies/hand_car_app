import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

//Bullet Points for Accessories Details Page
class BulletPoints extends StatelessWidget {
  final List<String> points;

  const BulletPoints(this.points, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: points
          .map((point) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: context.space.space_100),
                    child: Icon(
                      Icons.circle,
                      color: context.colors.primaryTxt,
                      size: context.space.space_50,
                    ),
                  ),
                  Expanded(
                      child: Padding(
                    padding: EdgeInsets.only(left: context.space.space_100),
                    child: Text(' $point', style: context.typography.body),
                  )),
                ],
              ))
          .toList(),
    );
  }
}
