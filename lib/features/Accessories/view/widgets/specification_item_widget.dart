import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class SpecificationItem extends StatelessWidget {
  final String label;
  final String value;

  const SpecificationItem(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_50),
      child: Row(
        children: [
          Expanded(child: Text(label, style: context.typography.bodySemiBold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}