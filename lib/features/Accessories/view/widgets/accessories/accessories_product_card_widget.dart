import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/outline_button_widget.dart';
import 'package:hand_car/features/Accessories/controller/cart/cart_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

//AccessoriesProductCardWidget For Show In GridView
class AccessoriesProductCardWidget extends ConsumerWidget {
  final int productId;
  final String name;
  final String price;
  final String image;
  final String discount;
  final String? off;
  
  const AccessoriesProductCardWidget( 
      {super.key,
      required this.productId,
      required this.name,
      required this.price,
      required this.image,
      required this.discount,
      this.off, });

  @override
  Widget build(BuildContext context,ref) {
    return GestureDetector(
      onTap: () {
        context.push('/accessories_details');
      },
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
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
              Center(
                child: Image.network(height: 100, width: 100, image),
              ),
              SizedBox(height: context.space.space_100),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: context.colors.yellow),
                child: Padding(
                  padding: EdgeInsets.all(context.space.space_100),
                  child: Text(
                    '$off% OFF',
                    style: context.typography.body,
                  ),
                ),
              ),
              SizedBox(height: context.space.space_100),
              Flexible(
                child: Text(
                  name,
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
                    price,
                    style: context.typography.bodyLarge
                        .copyWith(color: context.colors.primaryTxt),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: context.space.space_200),
                    child: Text(
                      discount,
                      style: const TextStyle(
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
                child: OutlineButtonWidget(label: 'Add To Cart', onTap: () {
                  ref.read(cartControllerProvider.notifier).addToCart(productId);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
