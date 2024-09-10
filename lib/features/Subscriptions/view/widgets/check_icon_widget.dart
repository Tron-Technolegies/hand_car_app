import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class FeaturesCheckIconWidget extends StatelessWidget {
  final String text;
  const FeaturesCheckIconWidget({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          const SizedBox(width: 10),
          Expanded(child: Text(text,style: context.typography.body.copyWith(color: context.colors.primaryTxt),)),
        ],
      ),
    );
  }
}