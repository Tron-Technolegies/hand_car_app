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
        actions: [
          // Add refresh button
          IconButton(
            onPressed: () {
              ref.read(wishlistNotifierProvider.notifier).refresh();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: wishlistState.when(
            data: (wishlistItems) {
              if (wishlistItems.isEmpty) {
                return const EmptyWishlist();
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await ref.read(wishlistNotifierProvider.notifier).refresh();
                },
                child: GridView.builder(
                  itemCount: wishlistItems.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
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
                      originalPrice: item.productPrice ?? 0.0,
                      image: item.productImage ?? '',
                      description: item.productDescription ?? '',
                      discountedPrice: 0.0,
                    );
                    return WishlistGridItem(item: item, product: product);
                  },
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: context.colors.warning,
                  ),
                  const SizedBox(height: 16),
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
                    onPressed: () => ref
                        .read(wishlistNotifierProvider.notifier)
                        .fetchWishlist(),
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

class EmptyWishlist extends ConsumerWidget {
  const EmptyWishlist({super.key});

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
            style: context.typography.bodyLarge.copyWith(
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: context.colors.white,
            border: Border.all(color: context.colors.background),
          ),
          child: Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Image container with fixed height
                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF979797).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.network(
                      item.productImage ??
                          'https://media.istockphoto.com/id/1080335414/photo/dash-camera-or-car-video-recorder-in-vehicle-on-the-way.jpg?s=612x612&w=0&k=20&c=dsbQ4zM2K_BJpgqh-khOW9bLj8nDA882LGe7a56poeI=',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.broken_image,
                        color: context.colors.warning,
                      ),
                    ),
                  ),
                ),
                
                SizedBox(height: context.space.space_50),
                
                // Product name with constrained height
                Expanded(
                  flex: 1,
                  child: Text(
                    item.productName ?? 'Unknown Product',
                    style: context.typography.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                
                SizedBox(height: context.space.space_50),
                
                // Price text
                if (item.productPrice != null)
                  Text(
                    'AED ${item.productPrice!.toStringAsFixed(2)}',
                    style: context.typography.bodyLarge.copyWith(
                      color: context.colors.primaryTxt,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                
                SizedBox(height: context.space.space_50),
                
                // Action buttons row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Wishlist button
                    Consumer(
                      builder: (context, ref, child) {
                        final wishlistAsync = ref.watch(wishlistNotifierProvider);
                        final isLoading = wishlistAsync.isLoading;
                        final isInWishlist = wishlistAsync.maybeWhen(
                          data: (wishlist) => wishlist.containsKey(item.id.toString()),
                          orElse: () => true,
                        );

                        return IconButton(
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          onPressed: isLoading
                              ? null
                              : () async {
                                  try {
                                    await ref
                                        .read(wishlistNotifierProvider.notifier)
                                        .removeFromWishlist(item.id.toString());
                                    if (context.mounted) {
                                      SnackbarUtil.showsnackbar(
                                        message: "${item.productName ?? 'Product'} removed from wishlist",
                                        showretry: false,
                                      );
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      SnackbarUtil.showsnackbar(
                                        message: "Failed to remove from wishlist: $e",
                                        showretry: false,
                                      );
                                    }
                                  }
                                },
                          icon: isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                )
                              : Icon(
                                  isInWishlist ? Icons.favorite : Icons.favorite_border,
                                  color: isInWishlist ? context.colors.warning : context.colors.primaryTxt,
                                  size: 20,
                                ),
                        );
                      },
                    ),
                    
                    // Add to cart button
                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        try {
                          await ref
                              .read(cartControllerProvider.notifier)
                              .addToCart(item.id);
                          if (context.mounted) {
                            SnackbarUtil.showsnackbar(
                              message: "${item.productName ?? 'Product'} added to cart",
                              showretry: false,
                            );
                          }
                        } catch (e) {
                          if (context.mounted) {
                            SnackbarUtil.showsnackbar(
                              message: "Failed to add to cart: $e",
                              showretry: false,
                            );
                          }
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
          ),
        ),
      ),
    );
  }
}