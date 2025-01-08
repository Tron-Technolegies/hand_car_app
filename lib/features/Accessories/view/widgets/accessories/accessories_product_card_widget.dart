import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// class AccessoriesProductCardWidget extends StatelessWidget {
//   final ProductsModel product;
//   final VoidCallback onTap;

//   const AccessoriesProductCardWidget({
//     super.key,
//     required this.product,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10),
//           color: context.colors.white,
//           border: Border.all(color: context.colors.background),
//         ),
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Align(
//                 alignment: Alignment.topRight,
//                 child: IconButton(
//                   onPressed: () {
//                     // Optional: Toggle favorite functionality
//                   },
//                   icon: const Icon(Icons.favorite_border),
//                 ),
//               ),
//               if (product.isBestseller == true)
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: context.colors.yellow),
//                   child: Padding(
//                     padding: EdgeInsets.all(context.space.space_100),
//                     child: Text(
//                       'Bestseller',
//                       style: context.typography.body,
//                     ),
//                   ),
//                 ),
//               Center(
//                 child: Image.network(
//                   product.image ??
//                       'https://img.freepik.com/premium-photo/car-parts-repair-concept_127657-10165.jpg?uid=P91385388&ga=GA1.1.934021275.1724508943&semt=ais_hybrid',
//                   height: 100,
//                   width: 100,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.image_not_supported),
//                 ),
//               ),
//               SizedBox(height: context.space.space_100),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                   color: context.colors.yellow,
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(context.space.space_100),
//                   child: Text(
//                     '${product.discountPercentage.toStringAsFixed(0)}% OFF',
//                     style: context.typography.bodySemiBold,
//                   ),
//                 ),
//               ),
//               SizedBox(height: context.space.space_100),
//               Text(
//                 product.name,
//                 style: context.typography.bodyLargeMedium
//                     .copyWith(color: context.colors.primaryTxt),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//               SizedBox(height: context.space.space_50),
//               // RatingBar.builder(
//               //   itemBuilder: (context, index) => const Icon(
//               //     Icons.star,
//               //     color: Colors.amber,
//               //   ),
//               //   onRatingUpdate: (rating) {
//               //     // Optional: Implement rating logic
//               //   },
//               //   itemCount: 5,
//               //   initialRating: product.rating ?? 3.5,
//               //   itemSize: 15,
//               // ),
//               SizedBox(height: context.space.space_150),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "AED ${product.price}",
//                     style: context.typography.bodyLarge
//                         .copyWith(color: context.colors.primaryTxt),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: context.space.space_200),
//                     child: Text(
//                       "AED ${product.price}",
//                       style: const TextStyle(
//                         color: Colors.grey,
//                         decoration: TextDecoration.lineThrough,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: context.space.space_100),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: context.space.space_50,
//                   vertical: context.space.space_50,
//                 ),
//                 child: OutlineButtonWidget(
//                   label: 'Add To Cart',
//                   onTap: () {
//                     // Optional: Implement Add to Cart functionality
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
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
            children: [
              Row(
                children: [
                  if (product.isBestseller == true)
                    Container(
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
                    ),
                  IconButton(
                    onPressed: () {
                      // Optional: Toggle favorite functionality
                      ref
                          .read(wishlistNotifierProvider.notifier)
                          .addToWishlist(int.parse(product.id.toString()));
                    },
                    icon: const Icon(Icons.favorite_border),
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: context.colors.yellow,
                ),
                child: Padding(
                  padding: EdgeInsets.all(context.space.space_100),
                  child: Text(
                    '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                    style: context.typography.bodySemiBold,
                  ),
                ),
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
              SizedBox(height: context.space.space_150),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "AED ${product.price}",
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: context.space.space_200),
                    child: Text(
                      "AED ${product.price.toString()}",
                      style: const TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ),
                ],
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
                      // Call addToCart from the CartController
                      await ref
                          .read(cartControllerProvider.notifier)
                          .addToCart(product.id);

                      // Show success feedback
                      if (context.mounted) {
                        SnackbarUtil.showsnackbar(
                            message: "${product.name} added to cart",
                            showretry: false);
                      }
                    } catch (e) {
                      // Show error feedback
                      if (context.mounted) {
                        SnackbarUtil.showsnackbar(
                            message: "Failed to add to cart", showretry: false);
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
