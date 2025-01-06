import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';

class ImageCarousel extends StatelessWidget {
  final ProductsModel product;

  const ImageCarousel({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    // Create a list of image URLs from your product
    List<String> imageUrls = [];
    
    // Add the main image if it exists
    if (product.image != null && product.image.toString().isNotEmpty) {
      imageUrls.add(product.image.toString());
    }

    // If no images are available, provide a default image
    if (imageUrls.isEmpty) {
      imageUrls.add('https://img.freepik.com/premium-photo/car-parts-repair-concept_127657-10165.jpg');
    }

    return FanCarouselImageSlider.sliderType2(
      imagesLink: imageUrls,
      expandImageHeight: 500,
      expandImageWidth: 500,
      expandedCloseChild: const Icon(Icons.close),
      sliderHeight: 300,
      isAssets: false,
      isClickable: true,
      userCanDrag: true,
      autoPlay: false,
      // Set initial page index to 0 to avoid the assertion error
      initalPageIndex: 0,
      indicatorActiveColor: context.colors.primaryTxt,
      imageFitMode: BoxFit.cover,
      // Add error handling for images
     
    );
  }
}