import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';

//Service Info Container Widget for Service Page
class ServiceCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String title2;
  final String rating;
  final String price;

  const ServiceCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.price,
    required this.title2,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Image Section
                SizedBox(
                  height: context.space.space_100,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: context.space.space_50),
                  child: Center(
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(context.space.space_200),
                      child: Image.asset(
                        image,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                // Padding for content
                Padding(
                  padding: EdgeInsets.all(context.space.space_200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and Rating Row
                      Text(
                        title,
                        style: context.typography.bodyLarge,
                      ),
                      Text(
                        title2,
                        style: context.typography.bodyLarge,
                      ),

                      SizedBox(height: context.space.space_100),

                      // Pricing Info
                      Row(
                        children: [
                          Text('AED $price/hr',
                              style: context.typography.bodyMedium),
                          const Icon(Icons.star, color: Colors.amber),
                          Text(
                            rating,
                            style: context.typography.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ButtonWidget(
                    label: 'View Details',
                    onTap: () {
                      context.push(
                        '/serviceDetailsPage',
                        extra: {
                          'image': image,
                          'title': title,
                          'title2': title2,
                          'rating': rating,
                          'price': price,
                        },
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
