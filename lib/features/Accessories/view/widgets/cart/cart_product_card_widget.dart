import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/quantity_button_for_cart_widget.dart';

class ProductCard extends HookWidget {
  final String productName;
  final String modelNumber;
  final String image;
  final double price;
  final bool isAvailable;
  final VoidCallback? onDelete;
  final Function(int)? onQuantityChanged;

  const ProductCard({
    super.key,
    required this.productName,
    required this.modelNumber,
    required this.image,
    required this.price,
    this.isAvailable = true,
    this.onDelete,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = useState(1);

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
                  image: AssetImage(image),
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
                  const SizedBox(height: 12),

                  // Quantity Counter Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Minus Button
                      Row(
                        children: [
                          QuantityButton(
                            icon: Icons.remove,
                            onPressed: () {
                              if (quantity.value > 1) {
                                quantity.value--;
                                onQuantityChanged?.call(quantity.value);
                              }
                            },
                          ),
                          Container(
                            width: 40,
                            alignment: Alignment.center,
                            child: Text(
                              quantity.value.toString(),
                              style: context.typography.bodyMedium,
                            ),
                          ),

                          // Plus Button
                          QuantityButton(
                            icon: Icons.add,
                            onPressed: () {
                              quantity.value++;
                              onQuantityChanged?.call(quantity.value);
                            },
                          ),
                        ],
                      ),

                      // Quantity Display
                      Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        'AED ${price.toStringAsFixed(2)}',
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
