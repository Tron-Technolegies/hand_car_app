import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';

import 'package:hand_car/features/Accessories/view/widgets/accessories/bullet_points_widgets.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/drop_down_button_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/image_carousel_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/product_section_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/rating_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/review_list_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/specification_item_widget.dart';

//Accessories Details Page
class AccessoriesDetailsPage extends HookWidget {
  const AccessoriesDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final addWishlist = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border), onPressed: () {}),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dash Cam 4K A800S Native True 4K Resolution (Front Only)',
                      style: context.typography.bodyLarge,
                    ),
                    SizedBox(height: context.space.space_100),
                    Text(
                      "Model Number : A800S",
                      style: context.typography.bodyMedium
                          .copyWith(color: const Color(0xff7D7D7D)),
                    ),
                    SizedBox(height: context.space.space_100),
                    Text(
                      'AED 399',
                      style: TextStyle(
                          color: context.colors.primaryTxt,
                          fontSize: context.typography.bodyMedium.fontSize,
                          decoration: TextDecoration
                              .lineThrough // Space between the letters
                          ),
                    ),
                    SizedBox(height: context.space.space_100),
                    Text(
                      'AED 359.00 Inclusive of VAT',
                      style: context.typography.bodyMedium,
                    ),
                    SizedBox(height: context.space.space_100),
                    Text(
                      'Saving: AED 11.00',
                      style: context.typography.bodyMedium
                          .copyWith(color: context.colors.green),
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const DropDownButtonWidget(),
                          SizedBox(
                              width: context.space.space_500 * 5,
                              child: ButtonWidget(
                                  label: "Add to Cart", onTap: () {})),
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
                                  addWishlist.value = !addWishlist.value;
                                },
                                icon: addWishlist.value
                                    ? const Icon(Icons.favorite_border)
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
              ProductSection(title: 'Overview', content: [
                Text(
                  'Highlights',
                  style: context.typography.bodyLarge,
                ),
                SizedBox(height: context.space.space_100),
                const BulletPoints([
                  'SONY IMX615 NATIVE TRUE 4K ULTRA HD'
                      'Powered by Sony\'s native ultra 4K resolution '
                      'High sensitivity image sensor,'
                      '70mai Dash Cam 4K provides outstanding picture quality...',
                  'No upscaling or software simulated 4K, A800 catches and reproduces every pixel to the finest true 4K level so details (license plates, street signs, traffic lights, etc) get captured the way they are with no compromise',
                  " IPS SCREEN & 140° WIDE WIDE ANGEL 70mai Dash Cam 4K A800 comes equipped with a  IPS screen that you view your recordings with real-time speed, timestamp and GPS coordinate info all on the same large screen.",
                  'F1.8 aperture 140° wide FOV (Field of View) with 7 layers of glass lenses effectively enhances image/video brightness and reduces blind spots'
                  // Add more bullet points
                ]),
              ]),
              const ProductSection(title: 'Specifications', content: [
                SpecificationItem('Colour Name', 'A800S Front Cam Only'),
                SpecificationItem('Model Number', 'A800S'),
                // Add more specifications
              ]),
              SizedBox(
                  height: context.space.space_500 * 9,
                  child: const ProductRatingsWidget(
                      rating: 4.6,
                      totalReviews: 1000,
                      starCounts: [
                        20,
                        20,
                        50,
                        140,
                        500,
                      ])),
              SizedBox(
                  height: context.space.space_500 * 8.2,
                  child: const ReviewsList()),
            ],
          ),
        ),
      ),
    );
  }
}
