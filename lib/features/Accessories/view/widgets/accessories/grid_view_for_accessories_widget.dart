import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';
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
            Text(
              'Something went wrong. Please try again later.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
      data: (products) {
        // Filter products based on the category
        final categoryProducts = products
            .where((product) =>
                product.category.toLowerCase() == categoryName.toLowerCase())
            .toList();

        if (categoryProducts.isEmpty) {
          return Center(
            child: Text(
              'No products available in this category.',
              style: Theme.of(context).textTheme.bodyMedium,
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
              onTap: () => onProductTap(product), // Handle product tap
            );
          },
        );
      },
    );
  }
}