import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/bottom_sheet_for_write_review_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/progress_indicator_bar_widget.dart';

//ProductRatingsWidget For Show In Details Page
class ProductRatingsWidget extends StatelessWidget {
  final double rating;
  final int totalReviews;
  final List<int> starCounts;

  const ProductRatingsWidget({
    super.key,
    required this.rating,
    required this.totalReviews,
    required this.starCounts,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Ratings & Reviews',
            style: context.typography.h3,
          ),
          SizedBox(height: context.space.space_100),
          Text(
            'Have a review about this product?',
            style: context.typography.bodyLargeMedium,
          ),
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    context: context,
                    builder: (context) => const BottomSheetForWriteReview());
              },
              child: Text(
                "Write here...",
                style: context.typography.bodyLargeMedium.copyWith(
                  color: const Color(0xff4069D8),
                ),
              )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                rating.toStringAsFixed(1),
                style: context.typography.h3,
              ),
              const SizedBox(width: 8),
              Row(
                children: List.generate(
                  5,
                  (index) => Icon(
                    index < rating.floor() ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: context.space.space_100),
          Text(
            'Based on $totalReviews reviews',
            style: context.typography.subtitle,
          ),
          SizedBox(height: context.space.space_200),
          ...List.generate(
            5,
            (index) => _buildStarBar(5 - index, starCounts[4 - index], context),
          ),
        ],
      ),
    );
  }

  Widget _buildStarBar(int stars, int count, BuildContext context) {
    final percentage = count / totalReviews;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_50),
      child: Row(
        children: [
          SizedBox(
            width: 16,
            child: Text('$stars', style: context.typography.bodySemiBold),
          ),
          Icon(Icons.star, size: context.space.space_200, color: Colors.amber),
          SizedBox(width: context.space.space_100),
          Expanded(
            child: CustomPaint(
              size: Size(double.infinity, context.space.space_100),
              painter: MultiColorProgressPainter(
                percentage: percentage,
                backgroundColor: Colors.grey[300]!,
                progressColor: stars >= 4 ? Colors.green : Colors.orange,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
