import 'package:flutter/material.dart';

import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hand_car/features/car_service/view/widgets/review/bottom_sheet_for_write_review_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';



class ServiceReviewWidget extends ConsumerWidget {
  final String serviceId;
  final String serviceName;
  final String? serviceImage;

  const ServiceReviewWidget({
    super.key,
    required this.serviceId,
    required this.serviceName,
    this.serviceImage,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingAsync = ref.watch(serviceRatingControllerProvider);

    return ratingAsync.when(
      data: (ratingList) {
        // Calculate star counts
        final starCounts = List<int>.filled(5, 0);
        for (var rating in ratingList.ratings) {
          if (rating.rating >= 1 && rating.rating <= 5) {
            starCounts[rating.rating - 1]++;
          }
        }

        final totalReviews = ratingList.ratings.length;
        final averageRating = ratingList.ratings.isEmpty 
          ? 0.0 
          : ratingList.ratings.fold(0, (sum, rating) => sum + rating.rating) / totalReviews;

        return Container(
          padding: const EdgeInsets.all(16),
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Service Ratings & Reviews',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Have a review about this service?',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  height: 1.2,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  minimumSize: Size.zero,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                    ),
                    context: context,
                    builder: (context) => BottomSheetForWriteReviewWidget(
                      serviceId: serviceId,
                      serviceName: serviceName,
                    ),
                  );
                },
                child: const Text(
                  "Write here...",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF4069D8),
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Icon(
                          index < averageRating.floor() 
                            ? Icons.star 
                            : Icons.star_border,
                          color: Colors.amber,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                'Based on $totalReviews reviews',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              ...List.generate(
                5,
                (index) {
                  final starLevel = 5 - index;
                  final count = starCounts[4 - index];
                  final percentage = totalReviews > 0 
                    ? (count / totalReviews) * 100 
                    : 0.0;
                  
                  return _buildStarBar(
                    stars: starLevel,
                    percentage: percentage,
                    context: context,
                  );
                },
              ),
            ],
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: ${error.toString()}'),
      ),
    );
  }

  Widget _buildStarBar({
    required int stars,
    required double percentage,
    required BuildContext context,
  }) {
    final progressColor = stars >= 4 ? Colors.green[500] : Colors.orange[400];
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: Text(
              '$stars',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 1.2,
              ),
            ),
          ),
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 16,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                height: 8,
                color: Colors.grey[200],
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: percentage / 100,
                  child: Container(
                    color: progressColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 40,
            child: Text(
              '${percentage.toInt()}%',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black54,
                height: 1.2,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}