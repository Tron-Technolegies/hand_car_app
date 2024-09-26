import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/SpareParts/view/widgets/genuine_parts_container.dart';
import 'package:hand_car/gen/assets.gen.dart';

class GenuinePartsSliderWidget extends StatelessWidget {
  const GenuinePartsSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        items: [
          GenuinePartsContainer(
              digit: "1M+",
              title: "Genuine Spare Parts",
              image: Assets.icons.g1.path,
              gradient: LinearGradient(
                colors: [
                  context.colors.primary,
                  context.colors.btnShadow,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
          GenuinePartsContainer(
              digit: "100+",
              title: "Top Brands",
              image: Assets.icons.g2.path,
              gradient: const LinearGradient(
                colors: [
                  Color(0xff5ea249),
                  Color(0xff3b8c2a),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
              )),
          GenuinePartsContainer(
              digit: "1000+",
              title: " Spare Parts Shipped",
              image: Assets.icons.g3.path,
              gradient: const LinearGradient(
                colors: [Color(0xff0069E4), Color(0xff0053A1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )),
        ],
        options: CarouselOptions(
          height: context.space.space_100 * 19,
          viewportFraction: 0.9,
          autoPlay: true,
          enableInfiniteScroll: true,
        ));
  }
}
