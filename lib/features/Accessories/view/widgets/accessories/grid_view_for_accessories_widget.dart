import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/accessories_product_card_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GridViewBuilderAccessoriesWidget extends ConsumerWidget {
  const GridViewBuilderAccessoriesWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsState = ref.watch(productsControllerProvider);

    // Using the AsyncValue to handle the loading, error, and data states
    return productsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => Center(child: Text('Error: $error')),
      data: (products) => GridView.builder(
        shrinkWrap: true,
        physics:
            const ClampingScrollPhysics(), // Better for expanding inside Column
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 340,
          mainAxisSpacing: 0.5,
          mainAxisExtent: 380,
          crossAxisSpacing: 1.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return AccessoriesProductCardWidget(
            name: product.name,
            price: "AED ${product.price}",
            image:
                'https://w7.pngwing.com/pngs/865/117/png-transparent-loudspeaker-enclosure-stereophonic-sound-amplifier-subwoofer-music-speakers-three-black-speakers-electronics-speaker-music-note-thumbnail.png',
            discount: '',
            off: '',
            productId: product.id,
            
          );
        },
      ),
    );
  }
}
