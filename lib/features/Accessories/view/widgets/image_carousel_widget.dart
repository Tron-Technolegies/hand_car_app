import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class ImageCarousel extends StatelessWidget {
  const ImageCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FanCarouselImageSlider.sliderType2(
        imagesLink: const [
          'https://img.freepik.com/premium-photo/black-leather-car-seat-with-black-leather-seat_862330-31608.jpg?uid=P91385388&ga=GA1.1.934021275.1724508943&semt=ais_hybrid',
          'https://img.freepik.com/premium-photo/black-leather-car-seat-with-red-button-black-seat_364561-21121.jpg?uid=P91385388&ga=GA1.1.934021275.1724508943&semt=ais_hybrid',
          'https://img.freepik.com/premium-photo/black-grey-car-seat-with-word-reclining-back_364561-21122.jpg?uid=P91385388&ga=GA1.1.934021275.1724508943&semt=ais_hybrid',
        ],
        expandImageHeight: 500,
        expandImageWidth: 500,
        expandedCloseChild: const Icon(Icons.close),
        sliderHeight: 300,
        isAssets: false,
        isClickable: true,
        userCanDrag: true,
        autoPlay: false,
        indicatorActiveColor: context.colors.primaryTxt,
        imageFitMode: BoxFit.cover);
  }
}

class ProductSection extends StatelessWidget {
  final String title;
  final List<Widget> content;

  const ProductSection({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(context.space.space_100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: context.typography.h2),
          SizedBox(height: context.space.space_100),
          ...content,
        ],
      ),
    );
  }
}

class SpecificationItem extends StatelessWidget {
  final String label;
  final String value;

  const SpecificationItem(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_50),
      child: Row(
        children: [
          Expanded(
              child:
                  Text(label, style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}


