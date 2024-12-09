import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/promoted_brands/promoted_products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';


class AccessoriesAdsHomePageWidget extends ConsumerWidget {
  const AccessoriesAdsHomePageWidget({super.key});

  @override
  /// Builds a carousel slider that shows the promoted products.
  ///
  /// The slider auto-plays and has a viewport fraction of 0.6.
  ///
  /// Each item in the slider is a [Container] with a
  /// [BorderRadius.circular] of 10 and a white background.
  /// Inside the container is a [Column] with the following widgets:
  ///
  /// - An [Image] with a height of 100 and a width of 100.
  /// - A [Row] with a discount percentage and a best-seller label if
  ///   applicable.
  /// - A [Text] with the product name.
  /// - A [Text] with the product description.
  /// - A [RatingBar] with an initial rating of 3.5 and 5 items.
  /// - A [Row] with the discounted price and the original price if
  ///   applicable.
  ///
  /// If the product is not found, a [Center] widget is returned with a
  /// [CircularProgressIndicator].
  ///
  /// If there is an error, a [Center] widget is returned with a
  /// [Text] widget containing the error message.
  Widget build(BuildContext context, ref) {
    // Watch the promoted products state
    final products = ref.watch(promotedProductsControllerProvider);
    
    return products.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (data) => CarouselSlider.builder(
        options: CarouselOptions(
          viewportFraction: 0.6,
          height: 300,
          autoPlay: true,
        ),
        itemCount: data.length,
        itemBuilder: (context, index, realIndex) {
          final product = data[index];
          final originalPrice = double.parse(product.price);
          final discountedPrice = originalPrice * (1 - (product.discountPercentage / 100));
          
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.space.space_50,
                horizontal: context.space.space_100),
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
                  children: [
                    Center(
                      child: product.image != null
                          ? Image.network(
                              height: 100,
                              width: 100,
                              product.image!,
                              errorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.image_not_supported,
                                      size: 100, color: Colors.grey),
                            )
                          : Icon(Icons.image_not_supported,
                              size: 100, color: Colors.grey),
                    ),
                    SizedBox(height: context.space.space_100),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if (product.discountPercentage > 0)
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: context.colors.primary),
                            child: Padding(
                              padding: EdgeInsets.all(context.space.space_100),
                              child: Text(
                                "${product.discountPercentage}%OFF",
                                style: context.typography.body
                                    .copyWith(color: context.colors.white),
                              ),
                            ),
                          ),
                        if (product.isBestseller)
                          Padding(
                            padding:
                                EdgeInsets.only(left: context.space.space_150),
                            child: Text(
                              "Deal of the Day",
                              style: context.typography.bodyMedium
                                  .copyWith(color: context.colors.primary),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: context.space.space_100),
                    Text(
                      product.name,
                      style: context.typography.bodyMedium
                          .copyWith(color: context.colors.primaryTxt),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.space.space_50),
                    Text(
                      product.description,
                      style: context.typography.bodyMedium
                          .copyWith(color: context.colors.primaryTxt),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.space.space_50),
                    RatingBar.builder(
                      itemBuilder: (item, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                      itemCount: 5,
                      initialRating: 3.5,
                      itemSize: 15,
                    ),
                    SizedBox(height: context.space.space_150),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'AED ${discountedPrice.toStringAsFixed(2)}',
                          style: context.typography.bodyLarge
                              .copyWith(color: context.colors.primaryTxt),
                        ),
                        if (product.discountPercentage > 0)
                          Padding(
                            padding:
                                EdgeInsets.only(left: context.space.space_200),
                            child: Text(
                              'AED ${product.price}',
                              style: const TextStyle(
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}