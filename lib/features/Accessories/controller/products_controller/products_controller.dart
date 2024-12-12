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

  Future<void> searchProducts(String query) async {
    try {
      // If query is empty, fetch all products
      if (query.isEmpty) {
        state = const AsyncValue.loading();
        state = AsyncValue.data(await fetchProducts());
        return;
      }

      // Set loading state
      state = const AsyncValue.loading();

      // Perform search
      final productsApiService = ref.read(productsApiServiceProvider);
      final searchResult = await productsApiService.searchProducts(query);

      // Update state with search results
      state = AsyncValue.data(searchResult.accessories);
    } catch (e) {
      // Handle error state
      state = AsyncValue.error(e, StackTrace.current);
    }
  }
  
}

// Separate provider for ProductsApiService
@riverpod
ProductsApiServices productsApiService(Ref ref) {
  return ProductsApiServices();
}
