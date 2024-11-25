import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/quantity_button_for_cart_widget.dart';

class ProductCard extends HookWidget {
  final String productName;
  final String? modelNumber;
  final String? image;
  final String price;
  final bool isAvailable;
  final int quantity;
  final VoidCallback? onDelete;
  final VoidCallback? onAdd;
  final Function(int)? onQuantityChanged;

  const ProductCard({
    super.key,
    required this.productName,
    this.modelNumber,
    this.image,
    required this.price,
    this.isAvailable = true,
    required this.quantity,
    this.onDelete,
    this.onQuantityChanged,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF5F5F5),
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

                  // Model Number
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Model Number:$modelNumber",
                        style: context.typography.body,
                      ),
                      IconButton(
                        onPressed: onDelete,
                        icon: Icon(
                          Icons.delete,
                          color: context.colors.primaryTxt,
                        ),
                        color: context.colors.primaryTxt,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  SizedBox(height: context.space.space_150),

                  // Quantity Counter Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Minus Button
                      Row(
                        children: [
                          QuantityButton(
                            icon: Icons.remove,
                            onPressed: onAdd,
                          ),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              quantity.toString(),
                              style: context.typography.bodyMedium,
                            ),
                          ),

                          // Plus Button
                          QuantityButton(
                            icon: Icons.add,
                            onPressed: () {},
                          ),
                        ],
                      ),

                      // Quantity Display
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        'AED $price',
                        style: context.typography.bodyMedium
                            .copyWith(color: context.colors.green),
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
