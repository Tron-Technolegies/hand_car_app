// products_filter_dialog.dart
import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/filtred_products/filter_products_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsFilterDialog extends ConsumerWidget {
  const ProductsFilterDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(productsFilterNotifierProvider);
    final filterNotifier = ref.read(productsFilterNotifierProvider.notifier);

    return AlertDialog(
      title: const Text('Filter Products'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Price Range Slider
            const Text('Price Range'),
            RangeSlider(
              values: RangeValues(
                filterState.minPrice,
                filterState.maxPrice == double.infinity 
                    ? 10000 // Set a reasonable maximum
                    : filterState.maxPrice,
              ),
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels(
                filterState.minPrice.toStringAsFixed(2),
                filterState.maxPrice == double.infinity 
                    ? 'Max'
                    : filterState.maxPrice.toStringAsFixed(2),
              ),
              onChanged: (RangeValues values) {
                filterNotifier.updatePriceRange(values.start, values.end);
              },
            ),

            const SizedBox(height: 16),

            // Rating Slider
            const Text('Minimum Rating'),
            Slider(
              value: filterState.minRating,
              min: 0,
              max: 5,
              divisions: 5,
              label: filterState.minRating.toString(),
              onChanged: (value) {
                filterNotifier.updateRating(value);
              },
            ),

            const SizedBox(height: 16),

            // New Arrivals Switch
            SwitchListTile(
              title: const Text('New Arrivals'),
              value: filterState.showNewArrivals,
              onChanged: (bool value) {
                filterNotifier.toggleNewArrivals(value);
              },
            ),

            // Bestsellers Switch
            SwitchListTile(
              title: const Text('Bestsellers Only'),
              value: filterState.showBestsellers,
              onChanged: (bool value) {
                filterNotifier.toggleBestsellers(value);
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            filterNotifier.resetFilters();
          },
          child: const Text('Reset'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Apply'),
        ),
      ],
    );
  }
}