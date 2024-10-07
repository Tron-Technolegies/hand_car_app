import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class CartItemsRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final bool isTotal;
  const CartItemsRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.typography.bodyMedium),
          Text(
            value,
            style: isTotal
                ? context.typography.bodyLarge
                    .copyWith(color: context.colors.green)
                : context.typography.bodyMedium,
          ),
        ],
      ),
    );
  }
}
