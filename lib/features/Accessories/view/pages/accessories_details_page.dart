import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';

import 'package:hand_car/features/Accessories/view/widgets/accessories/drop_down_button_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/image_carousel_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/product_section_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AccessoriesDetailsPage extends HookConsumerWidget {
  static const route = '/accessories-details';
  final ProductsModel product;

  const AccessoriesDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addWishlist = useState(false);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Accessories Details"),
          actions: [
            IconButton(
                icon: const Icon(Icons.favorite_border), onPressed: () {}),
            IconButton(icon: const Icon(Icons.shopping_cart), onPressed: () {}),
            IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
          ],
        ),
        body: LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(context.space.space_200),
                          child: Container(
                            color: context.colors.background,
                            child: const TextField(
                              decoration: InputDecoration(
                                hintText: 'Search accessories',
                                prefixIcon: Icon(Icons.search),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const ImageCarousel(),
                        Padding(
                          padding: EdgeInsets.all(context.space.space_200),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: context.typography.bodyLarge,
                              ),
                              SizedBox(height: context.space.space_100),
                              Text(
                                "Model Number: 'M7899'",
                                style: context.typography.bodyMedium
                                    .copyWith(color: const Color(0xff7D7D7D)),
                              ),
                              SizedBox(height: context.space.space_100),
                              Text(
                                'AED ${'400.00'}',
                                style: TextStyle(
                                    color: context.colors.primaryTxt,
                                    fontSize:
                                        context.typography.bodyMedium.fontSize,
                                    decoration: TextDecoration.lineThrough),
                              ),
                              SizedBox(height: context.space.space_100),
                              Text(
                                'AED ${product.price} Inclusive of VAT',
                                style: context.typography.bodyMedium,
                              ),
                              SizedBox(height: context.space.space_100),
                              // Text(
                              //   'Saving: AED ${(product.originalPrice != null && product.currentPrice != null) ? (product.originalPrice! - product.currentPrice!).toStringAsFixed(2) : '0.00'}',
                              //   style: context.typography.bodyMedium
                              //       .copyWith(color: context.colors.green),
                              // ),
                              SizedBox(height: context.space.space_100),
                              const Text(
                                'Lowest price in 7 days',
                                style: TextStyle(color: Colors.orange),
                              ),
                              SizedBox(height: context.space.space_200),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.space.space_100),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const DropDownButtonWidget(),
                                    SizedBox(
                                        width: context.space.space_500 * 5,
                                        child: ButtonWidget(
                                            label: "Add to Cart",
                                            onTap: () {})),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: context.space.space_100),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: context.colors.primaryTxt),
                                          borderRadius: BorderRadius.circular(
                                              context.space.space_100),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            addWishlist.value =
                                                !addWishlist.value;
                                          },
                                          icon: addWishlist.value
                                              ? const Icon(
                                                  Icons.favorite_border)
                                              : const Icon(Icons.favorite),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        ProductSection(
                          title: 'Overview',
                          content: [
                            Text(
                              'Highlights',
                              style: context.typography.bodyLarge,
                            ),
                            SizedBox(height: context.space.space_100),
                            Text(product.description)
                            //   BulletPoints(product.de ?? [
                            //     'No highlights available',
                            //   ]),
                            // ]),
                            // ProductSection(title: 'Specifications', content: [
                            //   ...product.specifications?.map((spec) =>
                            //     SpecificationItem(spec.key, spec.value)) ??
                            //   [SpecificationItem('No', 'Specifications')],
                            // ]),
                            // SizedBox(
                            //     height: context.space.space_500 * 9,
                            //     child: ProductRatingsWidget(
                            //         rating: product.rating ?? 0.0,
                            //         totalReviews: product.totalReviews ?? 0,
                            //         starCounts: product.starCounts ?? [0,0,0,0,0])),
                            // SizedBox(
                            //     height: context.space.space_500 * 8.2,
                            //     child: const ReviewsList()),
                          ],
                        ),
                      ]),
                )));
  }
}
