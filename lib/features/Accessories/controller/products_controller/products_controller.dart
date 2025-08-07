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
  int _currentPage = 1;
  int _totalPages = 1;
  bool _hasNext = false;
  List<ProductsModel> _allProducts = [];

  @override
  Future<List<ProductsModel>> build() async {
    _currentPage = 1;
    _allProducts = [];
    final result = await fetchProducts(page: _currentPage);
    _allProducts = result['products'];
    _totalPages = result['pages'];
    _hasNext = result['has_next'];
    return _allProducts;
  }

  Future<Map<String, dynamic>> fetchProducts({int page = 1, int limit = 10}) async {
    try {
      final productsApiService = ref.read(productsApiServiceProvider);
      return await productsApiService.getProducts(page: page, limit: limit);
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<void> loadMoreProducts() async {
    if (!_hasNext) return;
    state = const AsyncValue.loading();
    try {
      _currentPage++;
      final result = await fetchProducts(page: _currentPage);
      _allProducts.addAll(result['products']);
      _totalPages = result['pages'];
      _hasNext = result['has_next'];
      state = AsyncValue.data(_allProducts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> applyFilters(ProductsFilterState filters) async {
    final selectedCategory = ref.read(selectedCategoryNameProvider);

    // Only apply filters in "All Products"
    if (selectedCategory != 'All Products') {
      return;
    }

    state = const AsyncValue.loading();
    try {
      _currentPage = 1;
      _allProducts = [];
      final result = await fetchFilteredProducts(filters, page: _currentPage);
      _allProducts = result['products'];
      _totalPages = result['pages'];
      _hasNext = result['has_next'];
      state = AsyncValue.data(_allProducts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> searchProducts(String query) async {
    state = const AsyncValue.loading();
    try {
      _currentPage = 1;
      _allProducts = [];
      final productsApiService = ref.read(productsApiServiceProvider);
      final result = await productsApiService.getFilteredProducts({
        'search': query,
      }, page: _currentPage);
      _allProducts = result['products'];
      _totalPages = result['pages'];
      _hasNext = result['has_next'];
      state = AsyncValue.data(_allProducts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> loadMoreFilteredProducts(ProductsFilterState filters) async {
    if (!_hasNext) return;
    state = const AsyncValue.loading();
    try {
      _currentPage++;
      final result = await fetchFilteredProducts(filters, page: _currentPage);
      _allProducts.addAll(result['products']);
      _totalPages = result['pages'];
      _hasNext = result['has_next'];
      state = AsyncValue.data(_allProducts);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<Map<String, dynamic>> fetchFilteredProducts(ProductsFilterState filters,
      {int page = 1, int limit = 10}) async {
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
      if (filters.categoryId != null && filters.categoryId!.isNotEmpty) {
        queryParams['category'] = filters.categoryId;
      }
      log('Query params: $queryParams', name: 'ProductsApiServices');
      return await productsApiService.getFilteredProducts(queryParams, page: page, limit: limit);
    } catch (e) {
      throw Exception('Failed to fetch filtered products: $e');
    }
  }

  Future<List<BrandModel>> getBrands() async {
    try {
      final response = ref.read(productsApiServiceProvider);
      return await response.getAllBrands();
    } catch (e) {
      throw Exception('Failed to fetch brands: $e');
    }
  }

  bool get hasNext => _hasNext;
}

// Separate provider for ProductsApiService
@riverpod
ProductsApiServices productsApiService(Ref ref) {
  return ProductsApiServices();
}