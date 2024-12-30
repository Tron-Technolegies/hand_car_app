import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/utils/snackbar.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  static const route = '/wishlist';
  const WishlistScreen({super.key});

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch wishlist data when screen initializes
    Future.microtask(() {
      ref.read(wishlistNotifierProvider.notifier).fetchWishlist();
    });
  }

  @override
  Widget build(BuildContext context) {
    final wishlistState = ref.watch(wishlistNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(wishlistNotifierProvider.notifier).fetchWishlist();
            },
          ),
        ],
      ),
      body: wishlistState.when(
        data: (wishlistItems) {
          if (wishlistItems.isEmpty) {
            return const _EmptyWishlist();
          }
          return _WishlistContent(items: wishlistItems);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text('Error: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // ref.read(wishlistNotifierProvider.notifier).();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
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
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              // Navigate to products screen
              Navigator.of(context).pushNamed('/products');
            },
            child: const Text('Continue Shopping'),
          ),
        ],
      ),
    );
  }
}

class _WishlistContent extends ConsumerWidget {
  final Map<String, WishlistResponse> items;

  const _WishlistContent({
    required this.items,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Available Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final item = items.values.elementAt(index);
              return _WishlistItem(item: item);
            },
            childCount: items.length,
          ),
        ),
      ],
    );
  }
}

class _WishlistItem extends ConsumerWidget {
  final WishlistResponse item;

  const _WishlistItem({
    required this.item,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
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
              item.productImage ??
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSMp75PkGCYT5R6vVl0EKoQyLGQ30wPljYsew&s',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),

          // Product Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.productName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Model Number: ${item.id}', // You might want to add a modelNumber field to your model
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'AED ${item.productPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ),

          // Right Side Actions
          Column(
            children: [
              // Quantity Selector
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '01',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                    const Icon(
                      Icons.arrow_drop_down,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),

              // Move to Cart Button
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.space.space_200,
                    vertical: context.space.space_100),
                child: ButtonWidget(
                    label: "Move to Cart",
                    onTap: () {
                      ref
                          .read(cartControllerProvider.notifier)
                          .addToCart(item.id);
                      SnackbarUtil.showsnackbar(message: "Item Moved to cart");
                    }),
              ),

              // Delete Button
              IconButton(
                onPressed: () {
                  // Delete logic here
                  SnackbarUtil.showsnackbar(
                      message: "Item Removed from Wishlist");
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildMoreOptionsSheet(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: const Icon(Icons.remove_circle_outline),
          title: const Text('Remove from Wishlist'),
          onTap: () {
            Navigator.pop(context);
            // Remove logic here
          },
        ),
        ListTile(
          leading: const Icon(Icons.save_alt),
          title: const Text('Save for Later'),
          onTap: () {
            Navigator.pop(context);
            // Save for later logic here
          },
        ),
        ListTile(
          leading: const Icon(Icons.list),
          title: const Text('Add to another list'),
          onTap: () {
            Navigator.pop(context);
            // Add to another list logic here
          },
        ),
      ],
    ),
  );
}
