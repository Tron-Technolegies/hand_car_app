import 'package:flutter/material.dart';
import 'package:hand_car/core/extension/theme_extension.dart';
import 'package:hand_car/features/car_service/controller/rating/rating_filter/rating_filter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// lib/features/car_service/view/widgets/filter/rating_filter_widget.dart


class RatingFilterWidget extends ConsumerWidget {
  const RatingFilterWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.all(context.space.space_200),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter by Rating',
                style: context.typography.bodyLargeSemiBold,
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildFilterOption(context, ref, null, 'All'),
              ...List.generate(
                5,
                (index) => _buildFilterOption(
                  context,
                  ref,
                  (5 - index).toDouble(),
                  '${5 - index}★ & up',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterOption(
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