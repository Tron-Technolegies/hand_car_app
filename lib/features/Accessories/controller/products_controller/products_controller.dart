import 'package:hand_car/features/Accessories/controller/products_controller/products_state.dart';
import 'package:hand_car/features/Accessories/services/products_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products_controller.g.dart';

@riverpod
class ProductsController extends _$ProductsController {
  late final ProductsApiServices _apiService = ProductsApiServices();

  @override
  FutureOr<ProductState> build() async {
    return const ProductState.initial();
  }

  Future<void> fetchProducts() async {
    try {
      state = const AsyncValue.data(ProductState.loading());
      final products = await _apiService.getProducts();
      state = AsyncValue.data(ProductState.loaded(products));
    } catch (e) {
      state = AsyncValue.data(ProductState.error(e.toString()));
    }
  }
  Future<void> searchProducts(String query) async {
    try {
      state =  AsyncValue.data(ProductState.searching());
      final searchResponse = await _apiService.searchProducts(query);
      state = AsyncValue.data(ProductState.searchResults(searchResponse));
    } catch (e) {
      state = AsyncValue.data(ProductState.error(e.toString()));
    }
  }
}