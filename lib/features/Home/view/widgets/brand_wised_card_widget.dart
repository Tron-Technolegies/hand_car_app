import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class BrandWisedCardWidget extends ConsumerWidget {
  const BrandWisedCardWidget({super.key});
  
 

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final promotedProductsAsync = ref.watch(productsControllerProvider);

    return promotedProductsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
      data: (products) => CarouselSlider.builder(
        options: CarouselOptions(
          height: 350,
          viewportFraction: 0.8,
          autoPlay: true,
          enableInfiniteScroll: true,
        ),
        itemCount: products.length,
        itemBuilder: (context, index, realIndex) {
          final product = products[index];
          return Padding(
            padding: EdgeInsets.all(context.space.space_100),
            child: Container(
              padding: EdgeInsets.all(context.space.space_200),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: context.colors.background),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: context.space.space_200),
                  Image.asset(
                    'assets/images/${product.name.toLowerCase()}.png',
                    height: 150,
                  ),
                  SizedBox(height: context.space.space_200),
                  Text(
                    'Explore Products from ${product.name} Audio',
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: context.space.space_200),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: context.colors.yellow,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.space.space_100),
                      child: const Text("Best Brand Selected by Customers"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}