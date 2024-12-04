import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_product_card_widget.dart';
import 'package:hand_car/gen/assets.gen.dart';
import 'package:lottie/lottie.dart';

class GridViewBuilderAccessoriesWidget extends ConsumerWidget {
  final String categoryName;

  const GridViewBuilderAccessoriesWidget({
    required this.categoryName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsControllerProvider);

    return productsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Lottie.asset(Assets.animations.error)),
      data: (products) {
        // Filter products by category name
        final categoryProducts = products
            .where((product) => product.category.toLowerCase() == categoryName.toLowerCase())
            .toList();

        return GridView.builder(
          shrinkWrap: true,
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
              name: product.name,
              price: "AED ${product.price}",
              image: product.image ?? 'https://w7.pngwing.com/pngs/865/117/png-transparent-loudspeaker-enclosure-stereophonic-sound-amplifier-subwoofer-music-speakers-three-black-speakers-electronics-speaker-music-note-thumbnail.png',
              discount: '',
              off: '',
              productId: product.id,
            );
          },
        );
      },
    );
  }
}