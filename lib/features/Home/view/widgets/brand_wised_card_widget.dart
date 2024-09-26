import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class BrandWisedCardWidget extends StatelessWidget {
  const BrandWisedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 320,
        viewportFraction: 0.8,
        autoPlay: true,
        enableInfiniteScroll: true,
      ),
      itemCount: 4,
      itemBuilder: (context, index, realIndex) => Padding(
        padding: EdgeInsets.all(context.space.space_100),
        child: Container(
          padding: EdgeInsets.all(
              context.space.space_200), // Add padding around the content
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:
                Border.all(color: context.colors.background), // Rounded corners
            // Background color similar to the one in the image
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: context.space.space_200),
              // Space between text and image
              Image.asset(
                'assets/images/pioneer.png', // Make sure the image asset is added to your project
                height: 150, // Set the image size
              ),
              SizedBox(height: context.space.space_200),
              Text(
                'Explore Products from Pioneer Audio',
                style: context.typography.bodyLarge
                    .copyWith(color: context.colors.primaryTxt),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.space.space_200),
              // Space between image and button
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: context.colors.yellow,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.space.space_100),
                    child: const Text("Best Brand Selected by Customers"),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
