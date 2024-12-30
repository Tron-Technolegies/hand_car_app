// import 'package:flutter/material.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/core/utils/snackbar.dart';
// import 'package:hand_car/core/widgets/button_widget.dart';
// import 'package:hand_car/core/widgets/custome_chip.dart';
// import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';

// class WishlistItem extends HookConsumerWidget {
//   final WishlistResponse item;

//   const WishlistItem({
//     super.key,
//     required this.item,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Card(
//       color: context.colors.white,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: context.space.space_300),
//         decoration: BoxDecoration(
//           border: Border(
//             bottom: BorderSide(
//               color: Colors.grey.shade200,
//               width: 2,
//             ),
//           ),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Product Image
//             Container(
//               width: 80,
//               height: 80,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 image: DecorationImage(
//                   image: NetworkImage(item.productImage ??
//                       'https://e7.pngegg.com/pngimages/809/777/png-clipart-car-revathy-auto-parts-ford-motor-company-spare-part-advance-auto-parts-car-car-vehicle-thumbnail.png'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 12),

//             // Product Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Product Name
//                   Text(
//                     item.productName,
//                     style: context.typography.bodySemiBold,
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   SizedBox(height: context.space.space_100),

//                   // Model Number & Remove Button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Model: ${item.id}",
//                         style: context.typography.body,
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           // Implement remove from wishlist
//                           // ref.read(wishlistNotifierProvider.notifier).removeFromWishlist(item.id);
//                           SnackbarUtil.showsnackbar(
//                             message: "Item removed from wishlist",
//                             showretry: false,
//                           );
//                         },
//                         icon: Icon(
//                           Icons.delete,
//                           color: context.colors.primaryTxt,
//                         ),
//                         padding: EdgeInsets.zero,
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: context.space.space_150),

//                   // Price & Move to Cart Button
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       // Price
//                       Text(
//                         'AED ${item.productPrice}',
//                         style: context.typography.bodyMedium.copyWith(
//                           color: context.colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                       ),

//                       //Move to Cart Icon Button
//                       // ButtonWidget(
//                       //     icon: Icon(Icons.shopping_bag_outlined),
//                       //     label: "Move to Cart",
//                       //     onTap: () {
//                       //       ref
//                       //           .read(cartControllerProvider.notifier)
//                       //           .addToCart(item.id);
//                       //     })
//                       ButtonWidget(
//                           icon: const Icon(Icons.add_shopping_cart_outlined),
//                           label: 'Move to Cart',
//                           onTap: () {
//                             ref
//                                 .read(cartControllerProvider.notifier)
//                                 .addToCart(item.id);
//                           })
//                       // TextButton.icon(
//                       //     iconAlignment: IconAlignment.start,
//                       //     onPressed: () {
//                       //       ref
//                       //           .read(cartControllerProvider.notifier)
//                       //           .addToCart(item.id);
//                       //     },
//                       //     icon: const Icon(Icons.add_shopping_cart_outlined),
//                       //     label: Text(
//                       //       "Move to Cart",
//                       //       style: context.typography.bodySemiBold.copyWith(
//                       //         color: context.colors.backgroundSubtle,
//                       //       ),
//                       //     ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
