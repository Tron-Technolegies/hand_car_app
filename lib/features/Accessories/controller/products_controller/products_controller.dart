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

  Future<List<ProductsModel>> fetchFilteredProducts(
      ProductsFilterState filters) async {
    try {
      final productsApiService = ref.read(productsApiServiceProvider);

      // Convert filter state to query parameters
      final queryParams = <String, dynamic>{
        if (filters.categoryId != null) 'category_id': filters.categoryId,
        if (filters.minPrice > 0) 'min_price': filters.minPrice,
        if (filters.maxPrice < double.infinity) 'max_price': filters.maxPrice,
        if (filters.brandId != null) 'brand_id': filters.brandId,
        if (filters.minRating > 0) 'min_rating': filters.minRating,
        'new_arrivals': filters.showNewArrivals,
        'bestsellers': filters.showBestsellers,
      };

      return await productsApiService.getFilteredProducts(queryParams);
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

  Future<void> searchProducts(String query) async {
    state = const AsyncValue.loading();
    try {
      if (query.isEmpty) {
        state = AsyncValue.data(await fetchProducts());
        return;
      }

      final productsApiService = ref.read(productsApiServiceProvider);
      final searchResult = await productsApiService.searchProducts(query);

      // Accessories are already parsed as ProductsModel objects
      state = AsyncValue.data(searchResult.accessories);
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
}

// Separate provider for ProductsApiService
@riverpod
ProductsApiServices productsApiService(Ref ref) {
  return ProductsApiServices();
}
