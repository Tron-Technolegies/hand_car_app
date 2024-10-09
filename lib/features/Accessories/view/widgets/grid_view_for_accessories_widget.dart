import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories_product_card_widget.dart';

class GridViewBuilderAccessoriesWidget extends StatelessWidget {
  
  final String name;
  final String price;
  final String image;
  final String discount;
  final String off;
  const GridViewBuilderAccessoriesWidget({
    super.key,

    required this.name,
    required this.price,
    required this.image,
    required this.discount,
    required this.off,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 340,
        mainAxisSpacing: 0.5,
        mainAxisExtent: 380,
        crossAxisSpacing: 1.7,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => AccessoriesProductCardWidget(
        name: name,
        price: "AED $price",
        image:image,
        discount: "AED $discount",
        off: off,
      ),
    );
  }
}
