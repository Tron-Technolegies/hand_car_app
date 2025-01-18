import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/rating/rating_filter/rating_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RatingFilterWidget extends ConsumerWidget {
  const RatingFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final selectedRating = ref.watch(ratingFilterControllerProvider);

    return Container(
      padding: EdgeInsets.all(context.space.space_200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Filter by Rating',
            style: context.typography.bodyMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            children: [
              _buildRatingChip(context, ref, null, 'All'),
              ...List.generate(5, (index) {
                final rating = 5 - index;
                return _buildRatingChip(
                  context,
                  ref,
                  rating.toDouble(),
                  '$rating★ & up',
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRatingChip(
    BuildContext context,
    WidgetRef ref,
    double? rating,
    String label,
  ) {
    final isSelected = ref.watch(ratingFilterControllerProvider) == rating;

    return FilterChip(
      selected: isSelected,
      label: Text(label),
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : context.colors.primaryTxt,
      ),
      backgroundColor: Colors.grey[200],
      selectedColor: context.colors.primary,
      onSelected: (selected) {
        ref
            .read(ratingFilterControllerProvider.notifier)
            .setRatingFilter(selected ? rating : null);
      },
    );
  }
}
