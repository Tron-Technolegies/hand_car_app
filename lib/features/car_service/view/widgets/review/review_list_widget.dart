// lib/features/car_service/view/widgets/review/reviews_list.dart

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';
import 'package:hand_car/features/car_service/view/widgets/review/review_items_widget.dart';
import 'dart:developer';

class ReviewsList extends HookConsumerWidget {
  final String vendorName;
  final int serviceId;

  const ReviewsList({
    required this.vendorName,
    required this.serviceId,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('ReviewsList building with vendor: $vendorName, serviceId: $serviceId');

    // Fetch ratings when widget builds
    useEffect(() {
      Future.microtask(() {
        log('Fetching ratings for service ID: $serviceId');
        ref.read(serviceRatingControllerProvider.notifier).fetchRatings(serviceId);
      });
      return null;
    }, [serviceId]);

    final ratingsAsync = ref.watch(serviceRatingControllerProvider);

    return ratingsAsync.when(
      data: (ratingList) {
        log('Received ratings data: ${ratingList.ratings}');

        final serviceRatings = ratingList.ratings
            .where((rating) => rating.vendorName == vendorName)
            .toList();

        log('Filtered ratings for $vendorName: $serviceRatings');
        log(serviceRatings.length.toString());

        if (serviceRatings.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.rate_review_outlined,
                    size: 48,
                    color: context.colors.primaryTxt,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No reviews yet for $vendorName',
                    textAlign: TextAlign.center,
                    style: context.typography.bodyLarge,
                  ),
                ],
              ),
            ),
          );
        }

        // Using ListView without height constraints
        return ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: serviceRatings.length,
          itemBuilder: (context, index) {
            final rating = serviceRatings[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ReviewItemsWidget(
                username: rating.username,
                comment: rating.comment ?? '',
                rating: rating.rating,
              ),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) {
        log('Error loading reviews: $error\n$stack');
        return Center(
          child: Text('Error loading reviews: $error'),
        );
      },
    );
  }
}