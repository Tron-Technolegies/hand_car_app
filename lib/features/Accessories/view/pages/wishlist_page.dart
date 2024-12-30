// import 'package:flutter/material.dart';
// import 'package:hand_car/core/extension/theme_extension.dart';
// import 'package:hand_car/features/Accessories/view/widgets/wishlist/wishlist_items_card_widget.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
// import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';

// class WishlistScreen extends ConsumerStatefulWidget {
//   static const route = '/wishlist';
//   const WishlistScreen({super.key});

//   @override
//   ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
// }

// class _WishlistScreenState extends ConsumerState<WishlistScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Fetch wishlist data when screen initializes
//     Future.microtask(() {
//       ref.read(wishlistNotifierProvider.notifier).fetchWishlist();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final wishlistState = ref.watch(wishlistNotifierProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Wishlist'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               ref.read(wishlistNotifierProvider.notifier).fetchWishlist();
//             },
//           ),
//         ],
//       ),
//       body: wishlistState.when(
//         data: (wishlistItems) {
//           if (wishlistItems.isEmpty) {
//             return const _EmptyWishlist();
//           }
//           return _WishlistContent(items: wishlistItems);
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (error, stack) => Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.error_outline, size: 48, color: Colors.red),
//                SizedBox(height:context.space.space_200),
//               Text('Error: ${error.toString()}'),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // ref.read(wishlistNotifierProvider.notifier).();

//                   ref
//                       .read(wishlistNotifierProvider.notifier)
//                       .fetchWishlist();
//                 },
//                 child: const Text('Retry'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _EmptyWishlist extends StatelessWidget {
//   const _EmptyWishlist();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.favorite_border,
//             size: 64,
//             color: Colors.grey[400],
//           ),
//           const SizedBox(height: 16),
//           Text(
//             'Your wishlist is empty',
//             style: Theme.of(context).textTheme.headlineSmall,
//           ),
//           const SizedBox(height: 8),
//           Text(
//             'Save items you want to buy later',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                   color: Colors.grey[600],
//                 ),
//           ),
//            SizedBox(height: context.space.space_200),
//           ElevatedButton(
//             onPressed: () {
//               // Navigate to products screen
//               Navigator.of(context).pushNamed('/products');
//             },
//             child: const Text('Continue Shopping'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _WishlistContent extends ConsumerWidget {
//   final Map<String, WishlistResponse> items;

//   const _WishlistContent({
//     required this.items,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return CustomScrollView(
//       slivers: [
//         const SliverToBoxAdapter(
//           child: Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               'Available Items',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               final item = items.values.elementAt(index);
//               return WishlistItem(item: item);
//             },
//             childCount: items.length,
//           ),
//         ),
//       ],
//     );
//   }
// }

// Widget _buildMoreOptionsSheet(BuildContext context) {
//   return Container(
//     padding: const EdgeInsets.symmetric(vertical: 16),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         ListTile(
//           leading: const Icon(Icons.remove_circle_outline),
//           title: const Text('Remove from Wishlist'),
//           onTap: () {
//             Navigator.pop(context);
//             // Remove logic here
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.save_alt),
//           title: const Text('Save for Later'),
//           onTap: () {
//             Navigator.pop(context);
//             // Save for later logic here
//           },
//         ),
//         ListTile(
//           leading: const Icon(Icons.list),
//           title: const Text('Add to another list'),
//           onTap: () {
//             Navigator.pop(context);
//             // Add to another list logic here
//           },
//         ),
//       ],
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
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
                  return WishlistGridItem(item: item);
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: Text('Error: ${error.toString()}'),
            ),
          ),
        ),
      ),
    );
  }
}

class WishlistGridItem extends HookConsumerWidget {
  final WishlistResponse item;
  final double width;
  final double aspectRatio;

  const WishlistGridItem({
    super.key,
    required this.item,
    this.width = 140,
    this.aspectRatio = 0.7,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: () {
          // Navigate to product detail
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Hero(
                  tag: item.id.toString(),
                  child: Image.network(
                    item.productImage ??
                        'https://media.istockphoto.com/id/1080335414/photo/dash-camera-or-car-video-recorder-in-vehicle-on-the-way.jpg?s=612x612&w=0&k=20&c=dsbQ4zM2K_BJpgqh-khOW9bLj8nDA882LGe7a56poeI=',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              item.productName,
              style: context.typography.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "AED ${item.productPrice}",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: context.colors.green,
                  ),
                ),
                IconButton(
                  constraints: const BoxConstraints(),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    ref
                        .read(cartControllerProvider.notifier)
                        .addToCart(item.id);
                    SnackbarUtil.showsnackbar(
                      message: "Added to cart",
                      showretry: false,
                    );
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
    );
  }
}

class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist();

  @override
  Widget build(BuildContext context) {
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
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Save items you want to buy later',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          SizedBox(height: context.space.space_200),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/products');
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}
