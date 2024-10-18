import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class FeaturesCheckIconWidget extends StatelessWidget {
  final String text;
  const FeaturesCheckIconWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_100),
      child: Row(
        children: [
          Icon(Icons.check, color: context.colors.green),
          SizedBox(width: context.space.space_100),
          Expanded(
              child: Text(
            text,
            style: context.typography.body
                .copyWith(color: context.colors.primaryTxt),
          )),
        ],
      ),
    );
  }
}
