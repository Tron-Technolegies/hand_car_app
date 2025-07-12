import 'dart:developer';

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
  final TextEditingController _brandSearchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializePrices();
    _brandSearchController.addListener(_onSearchChanged);
  }

  void _initializePrices() {
    final filter = ref.read(productsFilterNotifierProvider);
    _minPriceController.text =
        filter.minPrice > 0 ? filter.minPrice.toStringAsFixed(0) : '';
    _maxPriceController.text = filter.maxPrice < double.infinity
        ? filter.maxPrice.toStringAsFixed(0)
        : '';
  }

  void _onSearchChanged() {
    setState(() {}); // Rebuild to update filtered brands
  }

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _brandSearchController.dispose();
    _scrollController.dispose();
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
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.8,
        ),
        child: SingleChildScrollView(
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
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Brands',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),

              // Brand List with loading states
              brandsAsync.when(
                data: (brands) =>
                    _buildBrandList(brands, filterState, notifier),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, _) => Text('Error loading brands: $error'),
              ),

              const SizedBox(height: 16),

              // Price Section
              const Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text(
                  'Price Range (AED)',
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
                    child: Text('to'),
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
                      _brandSearchController.clear();
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    child: const Text(
                      'Clear All',
                      style: TextStyle(color: Colors.black),
                    ),
                  )),
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
      ),
    );
  }

  Widget _buildBrandList(
    List<BrandModel> brands,
    ProductsFilterState filterState,
    ProductsFilterNotifier notifier,
  ) {
    final searchQuery = _brandSearchController.text.toLowerCase();
    final filteredBrands = searchQuery.isEmpty
        ? brands
        : brands
            .where((brand) => brand.name.toLowerCase().contains(searchQuery))
            .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Brand search field
        TextField(
          controller: _brandSearchController,
          decoration: InputDecoration(
            hintText: 'Search brands...',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
        const SizedBox(height: 12),

        // Brand list with scroll
        Container(
          constraints: const BoxConstraints(maxHeight: 200),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: filteredBrands.isEmpty
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('No brands found'),
                  ),
                )
              : Scrollbar(
                  controller: _scrollController,
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: filteredBrands.length,
                    itemBuilder: (context, index) {
                      final brand = filteredBrands[index];
                      return CheckboxListTile(
                        title: Text(brand.name),
                        value:
                            filterState.brand.toString() == brand.id.toString(),
                        onChanged: (value) {
                          log('Toggling brand: ${brand.name} (ID: ${brand.id}), isSelected: $value');
                          notifier.toggleBrand(
                              brand.id.toString(), value ?? false);
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        dense: true,
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}

final brandsProvider =
    FutureProvider.autoDispose<List<BrandModel>>((ref) async {
  final productService = ProductsApiServices();
  return await productService.getAllBrands();
});
