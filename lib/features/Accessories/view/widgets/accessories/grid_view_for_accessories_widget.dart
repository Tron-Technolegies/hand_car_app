import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_product_card_widget.dart';

class GridViewBuilderAccessoriesWidget extends StatelessWidget {
  final String categoryName;
  final List<ProductsModel> products; // Add products parameter
  final void Function(ProductsModel product) onProductTap;
final ScrollController? scrollController;
  const GridViewBuilderAccessoriesWidget({
    required this.categoryName,
    required this.products, // Receive pre-filtered products
    required this.onProductTap,
    this.scrollController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    log('Total products: ${products.length}');
    log('Current category: $categoryName');

    if (products.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No products available in $categoryName category.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
          ],
        ),
      );
    }

    return GridView.builder(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 340,
        mainAxisSpacing: 0.5,
        mainAxisExtent: 400,
        crossAxisSpacing: 1.7,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return AccessoriesProductCardWidget(
          product: product,
          onTap: () => onProductTap(product),
        );
      },
    );
  }
}
