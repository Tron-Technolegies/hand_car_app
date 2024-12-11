import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hand_car/features/Accessories/controller/wishlist/wishlist_controller.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_response_model.dart';


class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistState = ref.watch(wishlistNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
             
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
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class _EmptyWishlist extends StatelessWidget {
  const _EmptyWishlist({Key? key}) : super(key: key);

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
    super.key,
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
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: Key(item.productId),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        ref.read(wishlistNotifierProvider.notifier)
            .removeFromWishlist(item.productId);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Item removed from wishlist'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                ref.read(wishlistNotifierProvider.notifier)
                    .addToWishlist(int.parse(item.productId));
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      'https://via.placeholder.com/100',
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
                          'Product Name',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$99.99',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'In Stock',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart logic
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      child: const Text('Add to Cart'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {
                 
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => _buildMoreOptionsSheet(context),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
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
}