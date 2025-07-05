import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/controller/products_controller/filtred_products/filter_products_controller.dart';
import 'package:hand_car/features/Accessories/model/products/filter_products/filter_products_state.dart';
import 'package:hand_car/features/Accessories/services/products_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hand_car/features/Accessories/model/products/brand/brand_model.dart';

class ProductsFilterDialog extends ConsumerStatefulWidget {
  const ProductsFilterDialog({
    super.key,
  });

  @override
  ConsumerState<ProductsFilterDialog> createState() =>
      _ProductsFilterDialogState();
}

class _ProductsFilterDialogState extends ConsumerState<ProductsFilterDialog> {
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializePrices();
  }

  void _initializePrices() {
    final filter = ref.read(productsFilterNotifierProvider);
    _minPriceController.text =
        filter.minPrice > 0 ? filter.minPrice.toStringAsFixed(0) : '';
    _maxPriceController.text = filter.maxPrice < double.infinity
        ? filter.maxPrice.toStringAsFixed(0)
        : '';
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterState = ref.watch(productsFilterNotifierProvider);
    final notifier = ref.read(productsFilterNotifierProvider.notifier);
    final brandsAsync = ref.watch(brandsProvider);

    return Material(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Brand Section
            // const Padding(
            //   padding: EdgeInsets.only(bottom: 8),
            //   child: Text(
            //     'Brand',
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black87,
            //     ),
            //   ),
            // ),

            // // Brand List with loading states
            // brandsAsync.when(
            //   data: (brands) => _buildBrandList(brands, filterState, notifier),
            //   loading: () => const Center(child: CircularProgressIndicator()),
            //   error: (error, _) => Text('Error: $error'),
            // ),

            const SizedBox(height: 16),

            // Price Section
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Price AED',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _minPriceController,
                    decoration: InputDecoration(
                      hintText: 'Min',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('TO'),
                ),
                Expanded(
                  child: TextField(
                    controller: _maxPriceController,
                    decoration: InputDecoration(
                      hintText: 'Max',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 14),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      notifier.resetFilters();
                      _minPriceController.clear();
                      _maxPriceController.clear();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      'Clear All',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final min =
                          double.tryParse(_minPriceController.text) ?? 0;
                      final max = double.tryParse(_maxPriceController.text) ??
                          double.infinity;
                      notifier.updatePriceRange(min, max);
                      notifier.applyFilters();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF146EB4),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Apply',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildBrandList(
    List<BrandModel> brands,
    ProductsFilterState filterState,
    ProductsFilterNotifier notifier,
  ) {
    return Column(
      children: brands.map((brand) {
        return CheckboxListTile(
          title: Text(brand.name),
          value: filterState.selectedBrandIds.contains(brand.id),
          onChanged: (value) => notifier.toggleBrand(brand.id, value ?? false),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
        );
      }).toList(),
    );
  }
}

final brandsProvider =
    FutureProvider.autoDispose<List<BrandModel>>((ref) async {
  final productService = ProductsApiServices();
  return await productService.getAllBrands();
});
