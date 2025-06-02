import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:async';

class Debouncer {
  final Duration duration;
  Timer? _timer;

  Debouncer(this.duration);

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(duration, action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class ProductCard extends HookConsumerWidget {
  final String productName;
  final String? modelNumber;
  final String? image;
  final double price;
  final bool isAvailable;
  final int currentQuantity;
  final int cartItemId; // Changed from productId
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
    required this.cartItemId,
    this.onDelete,
    this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final maxQuantity = 10;
    final quantity = useState<int>(currentQuantity < 1 ? 1 : currentQuantity);
    final isUpdating = useState(false);
    final isMounted = useRef(true);
    final debouncer = useRef(Debouncer(const Duration(milliseconds: 500)));

    useEffect(() {
      return () {
        isMounted.value = false;
        debouncer.value.dispose();
      };
    }, []);

    final quantities = List<int>.generate(
      math.max(maxQuantity, quantity.value),
      (i) => i + 1,
    ).take(math.max(maxQuantity, quantity.value)).toList();

    void safeSetState(bool value) {
      if (isMounted.value) {
        isUpdating.value = value;
      }
    }

    return Slidable(
      key: Key(cartItemId.toString()),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        dismissible: DismissiblePane(
          onDismissed: () => _handleDelete(context),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(context.space.space_100),
              child: image != null && image!.isNotEmpty
                  ? Image.network(
                      image!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        log('Image error for URL: $image');
                        log('Error details: $error');
                        return _buildPlaceholder();
                      },
                    )
                  : _buildPlaceholder(),
            ),
            SizedBox(width: context.space.space_200),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'AED ${price.toStringAsFixed(2)}',
                        style: context.typography.bodyMedium.copyWith(
                          color: context.colors.green,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: context.colors.primaryTxt
                                .withValues(alpha: 0.3),
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_100,
                        ),
                        child: isUpdating.value
                            ? SizedBox(
                                width: context.space.space_300,
                                height: context.space.space_300,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    context.colors.primary,
                                  ),
                                ),
                              )
                            : DropdownButtonHideUnderline(
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
                                    if (newValue != null &&
                                        !isUpdating.value &&
                                        onQuantityChanged != null) {
                                      log('Changing quantity to: $newValue for cart item: $cartItemId');
                                      debouncer.value.run(() async {
                                        try {
                                          safeSetState(true);
                                          await onQuantityChanged!(newValue);
                                          if (isMounted.value) {
                                            quantity.value = newValue;
                                            SnackbarUtil.showsnackbar(
                                              message: "Quantity updated to $newValue",
                                              showretry: false,
                                            );
                                          }
                                        } catch (e, stackTrace) {
                                          if (isMounted.value) {
                                            log('Quantity update error: $e');
                                            log('Stack trace: $stackTrace');
                                            SnackbarUtil.showsnackbar(
                                              message: "Failed to update quantity: $e",
                                        
                                         
                                            );
                                          }
                                        } finally {
                                          safeSetState(false);
                                        }
                                      });
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

Widget _buildPlaceholder() {
  return Container(
    width: 80,
    height: 80,
    decoration: BoxDecoration(
      color: Colors.grey.shade200,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Icon(
      Icons.image_not_supported,
      color: Colors.grey.shade400,
      size: 30,
    ),
  );
}