
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_products_state.freezed.dart';
part 'filter_products_state.g.dart';

@freezed
class ProductsFilterState with _$ProductsFilterState {
  const factory ProductsFilterState({
    String? categoryId,
    @Default(0.0) double minPrice,
    @Default(double.infinity) double maxPrice,
    String? brandId,
    @Default(0.0) double minRating,
    @Default(false) bool showNewArrivals,
    @Default(false) bool showBestsellers,
  }) = _ProductsFilterState;

  factory ProductsFilterState.fromJson(Map<String, dynamic> json) =>
      _$ProductsFilterStateFromJson(json);
}