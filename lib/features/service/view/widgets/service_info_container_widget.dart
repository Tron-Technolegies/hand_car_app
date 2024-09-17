import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/service/view/widgets/service_hero_widget.dart';

class PaintSolutionCard extends StatelessWidget {
  final String image;
  final String title;
  final String title2;
  final String rating;
  final String price;

  const PaintSolutionCard({
    super.key,
    required this.image,
    required this.title,
    required this.rating,
    required this.price,
    required this.title2,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaintServiceDetails(
                image: image,
                title: title,
                title2: title2,
                rating: rating,
                price: price,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              // Image Section
              SizedBox(
                height: context.space.space_100,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: context.space.space_50),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      image, // Replace with your asset image path
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
            ],
          ),
        ),
      ),
    );
  }
}
