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

  void updateCategory(String? categoryId) {
    state = state.copyWith(categoryId: categoryId);
    _refreshProducts();
  }

  void updatePriceRange(double min, double max) {
    state = state.copyWith(minPrice: min, maxPrice: max);
    _refreshProducts();
  }

  void updateBrand(String? brandId) {
    state = state.copyWith(brandId: brandId);
    _refreshProducts();
  }

  void updateRating(double rating) {
    state = state.copyWith(minRating: rating);
    _refreshProducts();
  }

  void toggleNewArrivals(bool value) {
    state = state.copyWith(showNewArrivals: value);
    _refreshProducts();
  }

  void toggleBestsellers(bool value) {
    state = state.copyWith(showBestsellers: value);
    _refreshProducts();
  }

  void resetFilters() {
    state = const ProductsFilterState();
    _refreshProducts();
  }

  void _refreshProducts() {
    ref.read(productsControllerProvider.notifier).applyFilters(state);
  }
}
