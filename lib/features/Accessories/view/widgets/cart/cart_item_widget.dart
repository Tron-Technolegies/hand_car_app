import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/gen/assets.gen.dart';

class CartItemWidget extends StatelessWidget {
  const CartItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
  });

  final String name;
  final String price;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_100),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.colors.background,
              shape: BoxShape.circle,
            ),
            child: Image.asset(Assets.images.accessories.path),
          ),
          SizedBox(width: context.space.space_200),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: context.typography.bodyMedium),
                Text('Quantity: $quantity',
                    style: context.typography.bodySmall),
              ],
            ),
          ),
          Text(price, style: context.typography.bodySemiBold),
        ],
      ),
    );
  }
}
