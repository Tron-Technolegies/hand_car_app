// reviews_list.dart
import 'package:flutter/material.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/car_service/model/rating/service_rating.dart';

import 'package:hand_car/features/car_service/view/widgets/review/review_items_widget.dart';


class ReviewsList extends ConsumerWidget {
  final String vendorName;  // Changed from serviceId to vendorName

  const ReviewsList({
    required this.vendorName,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingsAsync = ref.watch(serviceRatingControllerProvider);

    return ratingsAsync.when(
      data: (ratingsList) {
        // Filter ratings by vendor name instead of service id
        final serviceRatings = ratingsList.ratings
            .where((rating) => rating.vendorName == vendorName)
            .toList();

        if (serviceRatings.isEmpty) {
          return const Center(
            child: Text('No reviews yet'),
          );
        }

        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: serviceRatings.length,
          itemBuilder: (context, index) {
            final rating = serviceRatings[index];
            return ReviewItemsWidget(
              username: rating.username,
              comment: rating.comment ?? '',
              rating: rating.rating,
            );
          },
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => Center(
        child: Text('Error loading reviews: $error'),
      ),
    );
  }
}