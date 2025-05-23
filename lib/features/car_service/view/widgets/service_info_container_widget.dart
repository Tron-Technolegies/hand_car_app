import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/core/widgets/button_widget.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';

import 'package:hand_car/features/car_service/model/service_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ServiceCardWidget extends ConsumerWidget {
  final ServiceModel service;

  const ServiceCardWidget({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context, ref) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(15)),
              child: service.images.isNotEmpty
                  ? Image.network(
                      service.images[0],
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.grey[300],
                        child: const Icon(Icons.error),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: double.infinity,
                          height: 150,
                          color: Colors.grey[200],
                          child:
                              const Center(child: CircularProgressIndicator()),
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title Section
                  Text(
                    service.vendorName,
                    style: context.typography.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    service.serviceCategory ?? '',
                    style: context.typography.bodyMedium.copyWith(
                      color: Colors.grey[600],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),

                  // Price and Rating Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Text(
                      //   'AED ${service.rate}/hr',
                      //   style: context.typography.bodyLarge.copyWith(
                      //     fontWeight: FontWeight.bold,
                      //     color: context.colors.primary,
                      //   ),
                      // ),
                      Consumer(
                        builder: (context, ref, child) {
                          final ratingAsync =
                              ref.watch(serviceRatingControllerProvider);

                          return ratingAsync.when(
                            data: (ratingList) {
                              final totalReviews = ratingList.ratings.length;
                              final averageRating = ratingList.ratings.isEmpty
                                  ? 0.0
                                  : ratingList.ratings.fold(
                                          0,
                                          (sum, rating) =>
                                              sum + rating.rating) /
                                      totalReviews;

                              return Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.amber),
                                  const SizedBox(width: 4),
                                  Text(
                                    averageRating.toStringAsFixed(1),
                                    style: context.typography.bodyLarge,
                                  ),
                                ],
                              );
                            },
                            loading: () => const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                            error: (_, __) => Row(
                              children: [
                                const Icon(Icons.star, color: Colors.grey),
                                const SizedBox(width: 4),
                                Text(
                                  '0.0',
                                  style: context.typography.bodyLarge,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ButtonWidget(
                      label: 'View Details',
                      onTap: () => _navigateToDetails(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetails(BuildContext context) {
    context.push(
      '/serviceDetailsPage',
      extra: {'service': service},
    );
  }
}
