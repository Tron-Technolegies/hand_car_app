import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductCard extends HookConsumerWidget {
  final String productName;
  final String? modelNumber;
  final String? image;
  final double price;
  final bool isAvailable;
  final int currentQuantity;
  final int productId;
  final VoidCallback? onDelete;
  final Future<void> Function(int)? onQuantityChanged;

  const ProductCard({
    super.key,
    required this.productName,
    this.modelNumber,
    this.image,
    required this.price,
    this.isAvailable = true,
    required this.currentQuantity,
    required this.productId,
    this.onDelete,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use state to manage quantity locally
    final quantity = useState(currentQuantity);
    final isUpdating = useState(false);
    
    // Generate list of quantities from 1 to 10
    final quantities = List<int>.generate(10, (i) => i + 1);

    return Slidable(
      key: Key(productId.toString()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            _handleDelete(context);
          },
        ),
        children: [
          SlidableAction(
            onPressed: (_) => _handleDelete(context),
            backgroundColor: context.colors.warning,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.space.space_200,
          vertical: context.space.space_150,
        ),
        decoration: BoxDecoration(
          color: context.colors.white,
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
                image ?? '',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey.shade200,
                    child: Icon(Icons.image_not_supported, color: Colors.grey),
                  );
                },
              ),
            ),
            SizedBox(width: context.space.space_200),

            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name and Model
                  Text(
                    productName,
                    style: context.typography.bodySemiBold,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (modelNumber != null) ...[
                    SizedBox(height: context.space.space_100),
                    Text(
                      "Model Number: $modelNumber",
                      style: context.typography.body.copyWith(
                        color: const Color(0xff7D7D7D),
                      ),
                    ),
                  ],
                  SizedBox(height: context.space.space_150),

                  // Price and Quantity Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Price
                      Text(
                        'AED ${price.toStringAsFixed(2)}',
                        style: context.typography.bodyMedium.copyWith(
                          color: context.colors.green,
                        ),
                      ),

                      // Quantity Dropdown
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colors.primaryTxt.withOpacity(0.3),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_100,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: quantity.value,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: quantities.map((int value) {
                              return DropdownMenuItem<int>(
                                value: value,
                                child: Text(
                                  value.toString(),
                                  style: context.typography.bodyMedium,
                                ),
                              );
                            }).toList(),
                            onChanged: (int? newValue) async {
                              // Check if quantity change is allowed
                              if (newValue != null && 
                                  !isUpdating.value && 
                                  onQuantityChanged != null) {
                                try {
                                  // Set updating state
                                  isUpdating.value = true;

                                  // Attempt to update quantity
                                  await onQuantityChanged!(newValue);

                                  // Update local state on successful update
                                  quantity.value = newValue;

                                  SnackbarUtil.showsnackbar(
                                    message: "Quantity updated successfully",
                                    showretry: false,
                                  );
                                } catch (e) {
                                  // Revert to previous quantity if update fails
                                  SnackbarUtil.showsnackbar(
                                    message: "Failed to update quantity: ${e.toString()}",
                                    showretry: false,
                                  );
                                } finally {
                                  // Reset updating state
                                  isUpdating.value = false;
                                }
                              }
                            },
                          ),
                        ),
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

  void _handleDelete(BuildContext context) {
    if (onDelete != null) {
      onDelete!();
      SnackbarUtil.showsnackbar(
        message: "Item Deleted",
        showretry: false,
      );
    }
  }
}