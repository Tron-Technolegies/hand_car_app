import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/quantity_button_for_cart_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCard extends HookConsumerWidget {
  final String productName;
  final String? modelNumber;
  final String? image;
  final String price;
  final bool isAvailable;
  final int quantity;
  final int productId;
  final VoidCallback? onDelete; // Added onDelete callback
  final Function(int)? onQuantityChanged; // Added onQuantityChanged callback

  const ProductCard({
    super.key,
    required this.productName,
    this.modelNumber,
    this.image,
    required this.price,
    this.isAvailable = true,
    required this.quantity,
    required this.productId,
    this.onDelete,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State for handling loading during quantity updates
    final isUpdating = useState(false);

    return Card(
      color: context.colors.white,
      child: Container(
        padding: EdgeInsets.all(context.space.space_200),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
              width: 2,
            ),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    productName,
                    style: context.typography.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.space.space_100),

                  // Model Number & Delete Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Model: $modelNumber",
                        style: context.typography.body,
                      ),
                      IconButton(
                        onPressed: ()async{
                        onDelete?.call();
                        SnackbarUtil.showsnackbar(
                            message: "Item Deleted", showretry: true);
                        },
                        icon: Icon(
                          Icons.delete,
                          color: context.colors.primaryTxt,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_150),

                  // Quantity Controls & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Quantity Controls
                      Row(
                        children: [
                          QuantityButton(
                            icon: Icons.remove,
                            onPressed: isUpdating.value || quantity <= 1
                                ? null
                                : () => onQuantityChanged?.call(quantity - 1),
                          ),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: isUpdating.value
                                ? SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: context.colors.primary,
                                    ),
                                  )
                                : Text(
                                    quantity.toString(),
                                    style: context.typography.bodyMedium,
                                  ),
                          ),
                          QuantityButton(
                            icon: Icons.add,
                            onPressed: isUpdating.value
                                ? null
                                : () => onQuantityChanged?.call(quantity + 1),
                          ),
                        ],
                      ),

                      // Price
                      Text(
                        'AED $price',
                        style: context.typography.bodyMedium.copyWith(
                          color: context.colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
