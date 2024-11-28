import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

/// [AccessoriesCircleAvatharWidget]

class AccessoriesCircleAvatharWidget extends StatelessWidget {
  final String text1;

  final String? image;
  final VoidCallback onTap;

  const AccessoriesCircleAvatharWidget({
    super.key,
    required this.text1,
    this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: CircleAvatar(
            radius: 50,
            backgroundColor: context.colors.primary,
            child: CircleAvatar(
              radius: 48.5,
              backgroundImage: NetworkImage(image ?? ''),
            ),
          ),
        ),
        SizedBox(height: context.space.space_100),
        Text(
          text1,
          style: context.typography.bodyMedium
              .copyWith(color: context.colors.primaryTxt),
        ),
        // Text(
        //   text2,
        //   style: context.typography.bodyMedium
        //       .copyWith(color: context.colors.primaryTxt),
        // )
      ],
    );
  }
}
