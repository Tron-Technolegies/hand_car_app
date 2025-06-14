import 'package:hand_car/features/Accessories/model/products/filter_products/filter_products_state.dart';
import 'package:hand_car/features/Accessories/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/services/products_service.dart';
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

  Future<List<ProductsModel>> fetchFilteredProducts(
      ProductsFilterState filters) async {
    try {
      final productsApiService = ref.read(productsApiServiceProvider);
      final queryParams = <String, dynamic>{
        if (filters.categoryId != null) 'category_id': filters.categoryId,
        if (filters.brandId != null) 'brand_id': filters.brandId,
        if (filters.minPrice > 0) 'min_price': filters.minPrice,
        if (filters.maxPrice < double.infinity) 'max_price': filters.maxPrice,
        if (filters.minRating > 0) 'min_rating': filters.minRating,
        'bestsellers': filters.showBestsellers.toString(),
        'new_arrivals': filters.showNewArrivals.toString(),
      };
      return await productsApiService.getFilteredProducts(queryParams);
    } catch (e) {
      throw Exception('Failed to fetch filtered products: $e');
    }
  }
}

// Separate provider for ProductsApiService
@riverpod
ProductsApiServices productsApiService(Ref ref) {
  return ProductsApiServices();
}