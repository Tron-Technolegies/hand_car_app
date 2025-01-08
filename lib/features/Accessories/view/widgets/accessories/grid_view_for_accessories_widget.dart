import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_product_card_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';

class GridViewBuilderAccessoriesWidget extends ConsumerWidget {
  final String categoryName;
  final void Function(ProductsModel product) onProductTap;

  const GridViewBuilderAccessoriesWidget({
    required this.categoryName,
    required this.onProductTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsControllerProvider);

    return productsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(Assets.animations.error),
            const SizedBox(height: 16),
            Text('Error: $error'),
          ],
        ),
      ),
      data: (products) {
        print('Total products: ${products.length}');
        print('Current category: $categoryName');
        print('Available categories: ${products.map((p) => p.category).toSet()}');
        
        // Filter products based on the category
        final categoryProducts = products
            .where((product) {
              print('Comparing: ${product.category.toLowerCase()} with ${categoryName.toLowerCase()}');
              return product.category.toLowerCase().trim() == categoryName.toLowerCase().trim();
            })
            .toList();

        print('Filtered products count: ${categoryProducts.length}');

        if (categoryProducts.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'No products available in $categoryName category.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  'Available categories: ${products.map((p) => p.category).toSet().join(", ")}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        }

        return GridView.builder(
          physics: const ClampingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 340,
            mainAxisSpacing: 0.5,
            mainAxisExtent: 380,
            crossAxisSpacing: 1.7,
          ),
          itemCount: categoryProducts.length,
          itemBuilder: (context, index) {
            final product = categoryProducts[index];
            return AccessoriesProductCardWidget(
              product: product,
              onTap: () => onProductTap(product),
            );
          },
        );
      },
    );
  }
}