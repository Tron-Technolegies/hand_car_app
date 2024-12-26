import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CartItemWidget extends HookConsumerWidget {
  const CartItemWidget({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.productId,
    this.imageUrl,
  });

  final String name;
  final String price;
  final int quantity;
  final int productId;
  final String? imageUrl;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key('cart_item_$productId'),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: context.space.space_200),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) {
        ref.read(cartControllerProvider.notifier).removeFromCart(productId);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.space.space_100),
        child: Row(
          children: [
            // Product Image
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: context.colors.background,
                shape: BoxShape.circle,
                image: imageUrl != null ? DecorationImage(
                  image: NetworkImage(imageUrl!),
                  fit: BoxFit.cover,
                ) : null,
              ),
              child: imageUrl == null ? Image.asset(Assets.images.accessories.path) : null,
            ),
            SizedBox(width: context.space.space_200),
            
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: context.typography.bodyMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity: $quantity',
                        style: context.typography.bodySmall,
                      ),
                      // Quantity Controls
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: quantity > 1 ? () {
                              ref.read(cartControllerProvider.notifier)
                                 .updateQuantity(productId, quantity - 1);
                            } : null,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: 20,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.space.space_100,
                            ),
                            child: Text(
                              quantity.toString(),
                              style: context.typography.bodyMedium,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () {
                              ref.read(cartControllerProvider.notifier)
                                 .updateQuantity(productId, quantity + 1);
                            },
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            iconSize: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            // Price
            Text(
              price,
              style: context.typography.bodySemiBold,
            ),
          ],
        ),
      ),
    );
  }
}