import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hand_car/core/extension/theme_extension.dart';

class AccessoriesAdsHomePageWidget extends StatelessWidget {
  const AccessoriesAdsHomePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 0.6,
        height: 300,
        autoPlay: true,
      ),
      itemCount: 3,
      itemBuilder: (context, index, realIndex) => Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.space.space_50,
            horizontal: context.space.space_100),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: context.colors.white,
            border: Border.all(color: context.colors.background),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.space.space_100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.network(
                      height: 100,
                      width: 100,
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQ5AqSJ5ZxmcirrZAvm4Y8xbu_h0cM9mlrXA&s'),
                ),
                SizedBox(height: context.space.space_100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: context.colors.primary),
                      child: Padding(
                        padding: EdgeInsets.all(context.space.space_100),
                        child: Text(
                          "30%OFF",
                          style: context.typography.body
                              .copyWith(color: context.colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: context.space.space_150),
                      child: Text(
                        "Deal of the Day",
                        style: context.typography.bodyMedium
                            .copyWith(color: context.colors.primary),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.space.space_100),
                Text(
                  'UNITOPSCI Wireless Apple',
                  style: context.typography.bodyMedium
                      .copyWith(color: context.colors.primaryTxt),
                ),
                SizedBox(height: context.space.space_50),
                Text(
                  'CarPlay Portable Car Stereo..',
                  style: context.typography.bodyMedium
                      .copyWith(color: context.colors.primaryTxt),
                ),
                SizedBox(height: context.space.space_50),
                RatingBar.builder(
                  itemBuilder: (item, index) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                  itemCount: 5,
                  initialRating: 3.5,
                  itemSize: 15,
                ),
                SizedBox(height: context.space.space_150),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'AED 100',
                      style: context.typography.bodyLarge
                          .copyWith(color: context.colors.primaryTxt),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: context.space.space_200),
                      child: const Text(
                        'AED 209',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration
                                .lineThrough // Space between the letters
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
