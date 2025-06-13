
// features/Accessories/view/pages/wishlist_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/bottom_nav_controller.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_details_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';

class WishlistScreen extends ConsumerWidget {
  static const route = '/wishlist';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistState = ref.watch(wishlistNotifierProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: wishlistState.when(
            data: (wishlistItems) {
              if (wishlistItems.isEmpty) {
                return const _EmptyWishlist();
              }
              return GridView.builder(
                itemCount: wishlistItems.length,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) {
                  final item = wishlistItems.values.elementAt(index);
                  final product = ProductsModel(
                    category: '',
                    brand: '',
                    id: item.id,
                    name: item.productName ?? 'Unknown Product',
                    price: item.productPrice?.toStringAsFixed(2) ?? '0.0',
                    image: item.productImage ?? '',
                    description: item.productDescription ?? '',
                  );
                  return WishlistGridItem(item: item, product: product);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load wishlist',
                    style: context.typography.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString().replaceFirst('Exception: ', ''),
                    style: context.typography.bodyMedium.copyWith(
                      color: context.colors.warning,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(wishlistNotifierProvider.notifier).fetchWishlist(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WishlistGridItem extends HookConsumerWidget {
  final WishlistResponse item;
  final ProductsModel product;
  final double width;
  final double aspectRatio;

  const WishlistGridItem({
    super.key,
    required this.item,
    required this.product,
    this.width = 140,
    this.aspectRatio = 0.7,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          context.push(
            '${AccessoriesDetailsPage.route}/${product.id}',
            extra: product,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: item.id.toString(),
                  child: Image.network(
                    item.productImage ??
                        'https://media.istockphoto.com/id/1080335414/photo/dash-camera-or-car-video-recorder-in-vehicle-on-the-way.jpg?s=612x612&w=0&k=20&c=dsbQ4zM2K_BJpgqh-khOW9bLj8nDA882LGe7a56poeI=',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.broken_image,
                      color: context.colors.warning,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.productName ?? 'Unknown Product',
              style: context.typography.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "AED ${item.productPrice?.toStringAsFixed(2) ?? 'N/A'}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.colors.green,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        try {
                          await ref
                              .read(wishlistNotifierProvider.notifier)
                              .removeFromWishlist(item.id.toString());
                          SnackbarUtil.showsnackbar(
                            message: "${item.productName ?? 'Product'} removed from wishlist",
                            showretry: false,
                          );
                        } catch (e) {
                          SnackbarUtil.showsnackbar(
                            message: "Failed to remove from wishlist: $e",
                            showretry: false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: context.colors.primaryTxt,
                        size: 20,
                      ),
                    ),
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        try {
                          await ref
                              .read(cartControllerProvider.notifier)
                              .addToCart(item.id);
                          SnackbarUtil.showsnackbar(
                            message: "${item.productName ?? 'Product'} added to cart",
                            showretry: false,
                          );
                        } catch (e) {
                          SnackbarUtil.showsnackbar(
                            message: "Failed to add to cart: $e",
                            showretry: false,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: context.colors.primaryTxt,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyWishlist extends ConsumerWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Your wishlist is empty',
            style: context.typography.bodySmallMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Save items you want to buy later',
            style: context.typography.bodyLarge?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: context.space.space_200),
          ElevatedButton(
            onPressed: () {
              ref.read(navigationProvider.notifier).jumpToPage(1);
              Navigator.of(context).pop();
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}
