import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccessoriesProductCardWidget extends ConsumerWidget {
  final ProductsModel product;
  final VoidCallback onTap;

  const AccessoriesProductCardWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the wishlist state more efficiently
    final wishlistState = ref.watch(wishlistNotifierProvider);
    final price = double.tryParse(product.price) ?? 0.0; 

    final originalPrice = price / (1 - product.discountPercentage / 100);


    final isInWishlist = wishlistState.maybeWhen(
      data: (wishlist) => wishlist.containsKey(product.id.toString()),
      orElse: () => false,
    );


    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: context.colors.white,
          border: Border.all(color: context.colors.background),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  product.isBestseller
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: context.colors.yellow,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(context.space.space_100),
                            child: Text(
                              'Bestseller',
                              style: context.typography.body,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  // Fixed wishlist button with proper state management
                  Consumer(
                    builder: (context, ref, child) {
                      final wishlistAsync = ref.watch(wishlistNotifierProvider);
                      final isLoading = wishlistAsync.isLoading;
                      final isInWishlist = wishlistAsync.maybeWhen(
                        data: (wishlist) => wishlist.containsKey(product.id.toString()),
                        orElse: () => false,
                      );

                      return IconButton(
                        onPressed: isLoading
                            ? null
                            : () async {
                                try {
                                  await ref
                                      .read(wishlistNotifierProvider.notifier)
                                      .toggleWishlist(product.id, productName: product.name);

                                  // Show success message
                                  if (context.mounted) {
                                    SnackbarUtil.showsnackbar(
                                      message: isInWishlist
                                          ? '${product.name} removed from wishlist'
                                          : '${product.name} added to wishlist',
                                      showretry: false,
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    SnackbarUtil.showsnackbar(
                                      message: e.toString().contains('login')
                                          ? 'Please login to continue'
                                          : 'Failed to update wishlist',
                                      showretry: false,
                                    );
                                  }
                                }
                              },
                        icon: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Icon(
                                isInWishlist ? Icons.favorite : Icons.favorite_border,
                                color: isInWishlist ? context.colors.warning : null,
                              ),
                      );
                    },
                  ),
                ],
              ),
              Center(
                child: Image.network(
                  product.image ??
                      'https://img.freepik.com/premium-photo/car-parts-repair-concept_127657-10165.jpg?uid=P91385388&ga=GA1.1.934021275.1724508943&semt=ais_hybrid',
                  height: 100,
                  width: 100,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported),
                ),
              ),
              SizedBox(height: context.space.space_100),
              Text(
                '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                style: context.typography.bodySemiBold
                    .copyWith(color: context.colors.green),
              ),
              SizedBox(height: context.space.space_100),
              Text(
                product.name,
                style: context.typography.bodyLargeMedium
                    .copyWith(color: context.colors.primaryTxt),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              SizedBox(height: context.space.space_50),
              // Current/Discounted Price
              Text(
                "AED ${price.toStringAsFixed(2)}",
                style: context.typography.bodyLarge.copyWith(color: context.colors.primaryTxt),
              ),
              // Original Price (crossed out)
              Text(
                "AED ${originalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              SizedBox(height: context.space.space_100),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.space.space_50,
                  vertical: context.space.space_50,
                ),
                child: OutlineButtonWidget(
                  label: 'Add To Cart',
                  onTap: () async {
                    try {
                      await ref
                          .read(cartControllerProvider.notifier)
                          .addToCart(product.id);
                      if (context.mounted) {
                        SnackbarUtil.showsnackbar(
                          message: "${product.name} added to cart",
                          showretry: false,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        SnackbarUtil.showsnackbar(
                          message: "Failed to add to cart",
                          showretry: false,
                        );
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}