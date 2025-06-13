
// features/Accessories/view/widgets/review/product_ratings_widget.dart
import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/Accessories/controller/review/review_controller.dart';
import 'package:hand_car/features/Accessories/view/widgets/review/bottom_sheet_for_write_review_widget.dart';
import 'package:hand_car/features/Accessories/view/widgets/accessories/progress_indicator_bar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer';

class ProductRatingsWidget extends ConsumerWidget {
  final String productId;
  final String productName;

  const ProductRatingsWidget({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsAsync = ref.watch(reviewControllerProvider);

    return Container(
      padding: EdgeInsets.all(context.space.space_200),
      child: reviewsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) {
          log('ProductRatingsWidget: Error loading reviews: $e');
          return Center(child: Text('Error: ${e.toString().replaceFirst('Exception: ', '')}'));
        },
        data: (reviewList) {
          final totalReviews = ref.read(reviewControllerProvider.notifier).totalReviews;
          final averageRating = ref.read(reviewControllerProvider.notifier).averageRating;
          final ratingDistribution = ref.read(reviewControllerProvider.notifier).ratingDistribution;

          return Column(
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
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    context: context,
                    builder: (context) => BottomSheetForWriteAccessoryReviewWidget(
                      productId: productId,
                      productName: productName,
                    ),
                  );
                },
                child: Text(
                  'Write here...',
                  style: context.typography.bodyLargeMedium.copyWith(
                    color: const Color(0xff4069D8),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: context.typography.h3,
                  ),
                  SizedBox(width: context.space.space_100),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < averageRating.floor() ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                        size: context.space.space_300,
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
              if (totalReviews > 0) ...[
                SizedBox(height: context.space.space_200),
                ...List.generate(
                  5,
                  (index) => _buildStarBar(
                5 - index,
                    ratingDistribution[5 - index] ?? 0,
                    totalReviews,
                  context,
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildStarBar(int stars, int count, int totalReviews, BuildContext context) {
    final percentage = totalReviews > 0 ? count / totalReviews : 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: context.space.space_50),
      child: Row(
        children: [
          SizedBox(
            width: context.space.space_200,
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
          SizedBox(width: context.space.space_100),
          SizedBox(
            width: context.space.space_400,
            child: Text(
              '${(percentage * 100).toInt()}%',
              style: TextStyle(fontSize: context.typography.bodySmall.fontSize),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
