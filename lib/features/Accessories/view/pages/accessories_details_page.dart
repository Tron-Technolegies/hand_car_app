
// features/Accessories/view/pages/accessories_details_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/controller/review/review_controller.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/bullet_points_widgets.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/drop_down_button_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/image_carousel_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/product_section_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/rating_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/bottom_sheet_for_write_review_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/review_list_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer';

class AccessoriesDetailsPage extends HookConsumerWidget {
  static const route = '/accessories-details';
  final ProductsModel product;

  const AccessoriesDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final debouncer = useRef<Timer?>(null);
    final reviewsAsync = ref.watch(reviewControllerProvider);
    final wishlistAsync = ref.watch(wishlistNotifierProvider);
    final isWishlistLoading = useState(false);

    useEffect(() {
      log('AccessoriesDetailsPage: Scheduling fetch reviews for product ID: ${product.id}');
      debouncer.value?.cancel();
      debouncer.value = Timer(const Duration(milliseconds: 100), () {
        Future.microtask(() {
          ref.read(reviewControllerProvider.notifier).fetchReviews(product.id);
        });
      });
      return () => debouncer.value?.cancel();
    }, [product.id]);

    return Scaffold(
      appBar: AppBar(
        title: Text('${product.name}'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          log('AccessoriesDetailsPage: Refreshing reviews for product ID: ${product.id}');
          await ref.read(reviewControllerProvider.notifier).refreshReviews();
        },
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageCarousel(product: product),
                Padding(
                  padding: EdgeInsets.all(context.space.space_200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name, style: context.typography.bodyLarge),
                      SizedBox(height: context.space.space_100),
                      Text(
                        "Model Number: 'M7899'",
                        style: context.typography.bodyMedium.copyWith(color: const Color(0xff7D7D7D)),
                      ),
                      SizedBox(height: context.space.space_100),
                      Text(
                        'AED 400.00',
                        style: TextStyle(
                          color: context.colors.primaryTxt,
                          fontSize: context.typography.bodyMedium.fontSize,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(height: context.space.space_100),
                      Text(
                        'AED ${product.price} Inclusive of VAT',
                        style: context.typography.bodyMedium,
                      ),
                      SizedBox(height: context.space.space_100),
                      const Text(
                        'Lowest price in 7 days',
                        style: TextStyle(color: Colors.orange),
                      ),
                      SizedBox(height: context.space.space_200),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
                              child: SizedBox(
                                width: constraints.maxWidth * 0.6,
                                child: ButtonWidget(
                                  label: "Add to Cart",
                                  onTap: () {
                                    ref.read(cartControllerProvider.notifier).addToCart(product.id);
                                    SnackbarUtil.showsnackbar(message: '${product.name} added to cart');
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: context.colors.primaryTxt),
                                  borderRadius: BorderRadius.circular(context.space.space_100),
                                ),
                                child: wishlistAsync.when(
                                  data: (wishlist) {
                                    final isInWishlist = wishlist.containsKey(product.id.toString());
                                    return IconButton(
                                      onPressed: isWishlistLoading.value
                                          ? null
                                          : () async {
                                              isWishlistLoading.value = true;
                                              try {
                                                await ref.read(wishlistNotifierProvider.notifier).toggleWishlist(product.id);
                                                SnackbarUtil.showsnackbar(
                                                  message: isInWishlist
                                                      ? '${product.name} removed from wishlist'
                                                      : '${product.name} added to wishlist',
                                                );
                                              } catch (e) {
                                                SnackbarUtil.showsnackbar(
                                                  message: e.toString().contains('login')
                                                      ? 'Please login to continue'
                                                      : 'Failed to update wishlist',
                                                 
                                                );
                                              } finally {
                                                isWishlistLoading.value = false;
                                              }
                                            },
                                      icon: isWishlistLoading.value
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
                                  loading: () => IconButton(
                                    onPressed: null,
                                    icon: const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(strokeWidth: 2),
                                    ),
                                  ),
                                  error: (e, _) => IconButton(
                                    onPressed: null,
                                    icon: Icon(
                                      Icons.favorite_border,
                                      color: context.colors.warning,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ProductSection(
                  title: 'Overview',
                  content: [
                    Text('Highlights', style: context.typography.bodyLarge),
                    SizedBox(height: context.space.space_100),
                    Text(product.description),
                    BulletPoints(
                      product.description
                          .split('. ')
                          .map((e) => e.trim())
                          .where((e) => e.isNotEmpty)
                          .toList(),
                    ),
                  ],
                ),
                ProductSection(
                  title: 'Specifications',
                  content: [
                    Text('No specifications available', style: context.typography.bodyMedium),
                  ],
                ),
                ProductSection(
                  title: 'Write a Review',
                  content: [
                    Text(
                      'Share your experience with ${product.name}',
                      style: context.typography.bodyMedium,
                    ),
                    SizedBox(height: context.space.space_200),
                    SizedBox(
                      width: double.infinity,
                      child: ButtonWidget(
                        label: 'Add Your Review',
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            context: context,
                            builder: (context) => BottomSheetForWriteAccessoryReviewWidget(
                              productId: product.id.toString(),
                              productName: product.name,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                ProductRatingsWidget(
                  productId: product.id.toString(),
                  productName: product.name,
                ),
                reviewsAsync.when(
                  loading: () {
                    log('AccessoriesDetailsPage: Reviews loading state');
                    return SizedBox(
                      height: context.space.space_500 * 2,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  error: (e, _) {
                    log('AccessoriesDetailsPage: Reviews error state: $e');
                    return SizedBox(
                      height: context.space.space_500 * 2,
                      child: Center(child: Text('Error: ${e.toString().replaceFirst('Exception: ', '')}')),
                    );
                  },
                  data: (reviewList) {
                    log('AccessoriesDetailsPage: Reviews data state: ${reviewList.reviews.length} reviews - ${reviewList.reviews.map((r) => r.toJson()).toList()}');
                    return ReviewListWidget(reviews: reviewList.reviews);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
