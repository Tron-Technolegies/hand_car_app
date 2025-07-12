import 'dart:developer';

import 'package:hand_car/features/Accessories/model/products/brand/brand_model.dart';
import 'package:hand_car/features/Accessories/model/products/filter_products/filter_products_state.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/services/products_service.dart';
import 'package:hand_car/features/Accessories/view/pages/accessories_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_controller.g.dart';

@riverpod
class ProductsController extends _$ProductsController {
  @override
  Future<List<ProductsModel>> build() async {
    return fetchProducts();
  }

  Future<List<ProductsModel>> fetchProducts() async {
    try {
      final productsApiService = ref.read(productsApiServiceProvider);
      return await productsApiService.getProducts();
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<void> applyFilters(ProductsFilterState filters) async {
  final selectedCategory = ref.read(selectedCategoryNameProvider);
  
  // Only apply filters in "All Products"
  if (selectedCategory != 'All Products') {
    return; // Exit without applying filters
  }

  state = const AsyncValue.loading();
  try {
    final filteredProducts = await fetchFilteredProducts(filters);
    state = AsyncValue.data(filteredProducts);
  } catch (e) {
    state = AsyncValue.error(e, StackTrace.current);
  }
}

  // Add this searchProducts method
  Future<void> searchProducts(String query) async {
    state = const AsyncValue.loading();
    try {
      final productsApiService = ref.read(productsApiServiceProvider);
      final filteredProducts = await productsApiService.getFilteredProducts({
        'search': query,
      });
      state = AsyncValue.data(filteredProducts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<List<ProductsModel>> fetchFilteredProducts(ProductsFilterState filters) async {
  try {
    final productsApiService = ref.read(productsApiServiceProvider);
    final queryParams = <String, dynamic>{};
    if (filters.brand.isNotEmpty) {
      final brands = await ref.read(productsControllerProvider.notifier).getBrands();
      final selectedBrand = brands.firstWhere(
        (brand) => brand.id == filters.brand,
        orElse: () => BrandModel(id: '', name: ''),
      );
      if (selectedBrand.name.isNotEmpty) {
        queryParams['brand'] = selectedBrand.name;
      } else {
        log('No brand found for ID: ${filters.brand}', name: 'ProductsController');
      }
    }
    log('Query params: $queryParams', name: 'ProductsApiServices');
    return await productsApiService.getFilteredProducts(queryParams);
  } catch (e) {
    throw Exception('Failed to fetch filtered products: $e');
  }
}
 // In ProductsController
Future<List<BrandModel>> getBrands() async {
  try {
    final response = ref.read(productsApiServiceProvider);
    return await response.getAllBrands();
  } catch(e) {
    throw Exception('Failed to fetch brands: $e');
  }
}
}

// Separate provider for ProductsApiService
@riverpod
ProductsApiServices productsApiService(Ref ref) {
  return ProductsApiServices();
}