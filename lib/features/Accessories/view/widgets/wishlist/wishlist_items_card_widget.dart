                   import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WishlistItem extends ConsumerWidget {
  final WishlistResponse item;

  const WishlistItem({super.key, 
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.productImage ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMp75PkGCYT5R6vVl0EKoQyLGQ30wPljYsew&s',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Model Number: ${item.id}', // You might want to add a modelNumber field to your model
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'AED ${item.productPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          // Right Side Actions
          Column(
            children: [
              // Quantity Selector
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '01',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Move to Cart Button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.space.space_200,
                    vertical: context.space.space_100),
                child: ButtonWidget(
                    label: "Move to Cart",
                    onTap: () {
                      ref
                          .read(cartControllerProvider.notifier)
                          .addToCart(item.id);
                      SnackbarUtil.showsnackbar(message: "Item Moved to cart");
                    }),
              ),

              // Delete Button
              IconButton(
                onPressed: () {
                  // Delete logic here
                  SnackbarUtil.showsnackbar(
                      message: "Item Removed from Wishlist");
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
