import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
    return Dismissible(
      key: Key(item.id.toString()),
      // ... rest of the Dismissible widget code ...
      child: Card(
        // ... card styling ...
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.productImage ?? 'https://via.placeholder.com/100',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.productName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${item.productPrice.toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (item.productDescription != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.productDescription!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            // ... rest of the widget ...
          ],
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