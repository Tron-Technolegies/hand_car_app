import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart_item_widget.dart';

class CartSummaryWidget extends StatelessWidget {
  const CartSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.background,
      borderOnForeground: true,
      margin: EdgeInsets.all(context.space.space_200),
      child: Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items in cart',
              style: context.typography.h3,
            ),
            SizedBox(height: context.space.space_200),
            const CartItemWidget(
                name: 'Bosch F002H60041 Front Brake Pad for Passenger...',
                price: 'AED 120',
                quantity: 1),
            const CartItemWidget(
                name: 'Bosch F002H60041 Front Brake Pad for Passenger...',
                price: 'AED 120',
                quantity: 1),
            const CartItemWidget(
                name: 'Bosch F002H60041 Front Brake Pad for Passenger...',
                price: 'AED 120',
                quantity: 1),
            Divider(height: context.space.space_400),
            const CartItemsRowWidget(
                label: 'Total', value: 'AED 360.00', isTotal: false),
            const CartItemsRowWidget(
                label: 'Discount', value: 'AED 20.00', isTotal: false),
            SizedBox(height: context.space.space_200),
            const CartItemsRowWidget(
                label: 'Grand Total', value: 'AED 360.00', isTotal: true),
          ],
        ),
      ),
    );
  }
}

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


