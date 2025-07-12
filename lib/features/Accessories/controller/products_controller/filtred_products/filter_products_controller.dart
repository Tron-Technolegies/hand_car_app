import 'package:hand_car/features/Accessories/controller/products_controller/products_controller.dart';
import 'package:hand_car/features/Accessories/model/products/filter_products/filter_products_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'filter_products_controller.g.dart';

@riverpod
class ProductsFilterNotifier extends _$ProductsFilterNotifier {
  @override
  ProductsFilterState build() {
    return const ProductsFilterState();
  }

  // Updated brand handling methods
  void toggleBrand(String brandId, bool selected) {

    state = state.copyWith(
  brand: brandId,
    );
  }

  void updatePriceRange(double min, double max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
  }

  void resetFilters() {
    state = const ProductsFilterState();
  }

  void applyFilters() {
    _refreshProducts();
  }

  void _refreshProducts() {
    ref.read(productsControllerProvider.notifier).applyFilters(state);
  }
}
