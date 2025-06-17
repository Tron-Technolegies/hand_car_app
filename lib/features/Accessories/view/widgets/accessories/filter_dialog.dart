import 'package:flutter/material.dart';
import 'package:hand_car/features/Accessories/model/products/filter_products/filter_products_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductsFilterDialog extends StatefulWidget {
  final void Function(ProductsFilterState) onApplyFilters;
  
  const ProductsFilterDialog({
    super.key,
    required this.onApplyFilters,
  });

  @override
  State<ProductsFilterDialog> createState() => _ProductsFilterDialogState();
}

class _ProductsFilterDialogState extends State<ProductsFilterDialog> {
  final Map<String, bool> _brandSelections = {
    'Brand1': true,
    'JBL': false,
    'brand2': false,
  };

  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();

  @override
  void dispose() {
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    final filters = ProductsFilterState(
      brandId: _brandSelections.entries
          .where((e) => e.value)
          .map((e) => e.key)
          .join(','),
      minPrice: double.tryParse(_minPriceController.text) ?? 0,
      maxPrice: double.tryParse(_maxPriceController.text) ?? double.infinity,
    );
    
    widget.onApplyFilters(filters);
    Navigator.pop(context);
  }

  void _clearAll() {
    setState(() {
      for (var key in _brandSelections.keys) {
        _brandSelections[key] = false;
      }
      _minPriceController.clear();
      _maxPriceController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
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
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Brand',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            
            ..._brandSelections.entries.map((entry) {
              return CheckboxListTile(
                title: Text(entry.key),
                value: entry.value,
                onChanged: (value) {
                  setState(() {
                    _brandSelections[entry.key] = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                dense: true,
              );
            }).toList(),
            
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
                    onPressed: _clearAll,
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
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF146EB4), // Amazon blue
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
}