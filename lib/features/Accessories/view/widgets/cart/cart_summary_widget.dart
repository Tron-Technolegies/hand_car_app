import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_item_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/cart/cart_row_widget.dart';

class CartSummaryWidget extends StatelessWidget {
  final CartModel cart;

  const CartSummaryWidget({
    super.key,
    required this.cart,
  });

  @override
  Widget build(BuildContext context) {
    final discount = cart.totalAmount - cart.discountedTotal;

    return Card(
      color: context.colors.background,
      borderOnForeground: true,
      margin: EdgeInsets.symmetric(
        vertical: context.space.space_100,
        horizontal: context.space.space_200,
      ),
      child: Padding(
        padding: EdgeInsets.all(context.space.space_200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Items in cart',
              style: context.typography.h3,
            ),
            SizedBox(height: context.space.space_200),
            
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.4,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: cart.cartItems.length,
                separatorBuilder: (context, index) => Divider(
                  height: context.space.space_100,
                ),
                itemBuilder: (context, index) {
                  final item = cart.cartItems[index];
                  return CartItemWidget(
                    name: item.productName,
                    price: 'AED ${item.productPrice.toStringAsFixed(2)}',
                    quantity: item.quantity,
                    productId: item.productId ?? 0, // Use null-aware operator
                  );
                },
              ),
            ),
            Divider(height: context.space.space_400),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.space.space_100,
              ),
              child: Column(
                children: [
                  CartItemsRowWidget(
                    label: 'Total',
                    value: 'AED ${cart.totalAmount.toStringAsFixed(2)}',
                    isTotal: false,
                  ),
                  if (discount > 0) ...[
                    SizedBox(height: context.space.space_100),
                    CartItemsRowWidget(
                      label: 'Discount',
                      value: '-AED ${discount.toStringAsFixed(2)}',
                      isTotal: false,
                    ),
                  ],
                  SizedBox(height: context.space.space_200),
                  CartItemsRowWidget(
                    label: 'Grand Total',
                    value: 'AED ${cart.discountedTotal.toStringAsFixed(2)}',
                    isTotal: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
