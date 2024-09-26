import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';

class AccessoriesProductCardWidget extends StatelessWidget {
  const AccessoriesProductCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.favorite_border),
              ),
            ),
            Center(
              child: Image.network(
                  height: 100,
                  width: 100,
                  'https://www.pngplay.com/wp-content/uploads/7/Automobile-Car-Accessories-PNG-Background.png'),
            ),
            SizedBox(height: context.space.space_100),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: context.colors.yellow),
              child: Padding(
                padding: EdgeInsets.all(context.space.space_100),
                child: Text(
                  "30%OFF",
                  style: context.typography.body,
                ),
              ),
            ),
            SizedBox(height: context.space.space_100),
            Flexible(
              child: Text(
                'UNITOPSCI Wireless Apple CarPlay Portable Car Stereo..',
                style: context.typography.bodyMedium
                    .copyWith(color: context.colors.primaryTxt),
                overflow: TextOverflow
                    .ellipsis, // Prevent text overflow by using ellipsis
              ),
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
                  'AED 120',
                  style: context.typography.bodyLarge
                      .copyWith(color: context.colors.primaryTxt),
                ),
                Padding(
                  padding: EdgeInsets.only(left: context.space.space_200),
                  child: const Text(
                    'AED 199',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration
                            .lineThrough // Space between the letters
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.space.space_100),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.space.space_50,
                  vertical: context.space.space_50),
              child: ButtonWidget(label: 'Add To Cart', onTap: () {}),
            )
          ],
        ),
      ),
    );
  }
}
