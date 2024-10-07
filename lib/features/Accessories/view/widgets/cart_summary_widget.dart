import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart_item_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart_row_widget.dart';

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
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) => const CartItemWidget(
                    name: 'Bosch F002H60041 Front Brake Pad for Passenger...',
                    price: 'AED 120',
                    quantity: 1),
              ),
            ),
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

