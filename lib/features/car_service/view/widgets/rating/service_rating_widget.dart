import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/car_service/controller/rating/service_rating_controller.dart';

class ServiceRatingCard extends HookConsumerWidget {
  final int serviceId;
  final String vendorName;
  
  const ServiceRatingCard({
    super.key,
    required this.serviceId,
    required this.vendorName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the rating controller state
    final ratingState = ref.watch(serviceRatingControllerProvider);
    
    // Initialize ratings when widget builds
    useEffect(() {
      Future.microtask(() {
        ref.read(serviceRatingControllerProvider.notifier).fetchRatings(serviceId);
      });
      return null;
    }, [serviceId]);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              vendorName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ratingState.when(
              data: (ratingList) => _buildRatingContent(context, ref),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error loading ratings: $error'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingContent(BuildContext context, WidgetRef ref) {
    final controller = ref.read(serviceRatingControllerProvider.notifier);
    final averageRating = controller.averageRating;
    final totalRatings = controller.totalRatings;
    final distribution = controller.ratingDistribution;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              averageRating.toStringAsFixed(1),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(width: 8),
            _buildStarRating(averageRating),
            const SizedBox(width: 8),
            Text('($totalRatings reviews)'),
          ],
        ),
        const SizedBox(height: 16),
        _buildRatingBars(distribution),
      ],
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
          size: 24,
        );
      }),
    );
  }

  Widget _buildRatingBars(Map<int, int> distribution) {
    final maxCount = distribution.values.reduce((a, b) => a > b ? a : b);
    
    return Column(
      children: List.generate(5, (index) {
        final starCount = 5 - index;
        final count = distribution[starCount] ?? 0;
        final percentage = maxCount > 0 ? count / maxCount : 0.0;
        
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(
            children: [
              Text('$starCount'),
              const SizedBox(width: 8),
              Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: percentage,
                    backgroundColor: Colors.grey[200],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text('$count'),
            ],
          ),
        );
      }),
    );
  }
}