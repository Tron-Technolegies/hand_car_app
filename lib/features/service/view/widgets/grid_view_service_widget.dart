import 'package:flutter/material.dart';
import 'package:hand_car/features/service/view/widgets/service_info_container_widget.dart';

class GridViewServicesWidget extends StatelessWidget {
  final String title;
  final String title2;
  final String rating;
  final String price;
  final String image;
  const GridViewServicesWidget({
    super.key,
    required this.title,
    required this.title2,
    required this.rating,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 320,
        mainAxisSpacing: 0.1,
        mainAxisExtent: 390,
        crossAxisSpacing: 0.2,
      ),
      itemCount: 5,
      itemBuilder: (context, index) => ServiceCardWidget(
        image: image,
        title: title,
        title2: title2,
        rating: rating,
        price: price,
      ),
    );
  }
}
