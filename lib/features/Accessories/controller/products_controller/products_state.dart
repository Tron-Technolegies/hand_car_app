import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';
import 'package:hand_car/features/Accessories/controller/model/serach_products/search_response_model.dart';
part 'products_state.freezed.dart';

//product state
@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial() = _Initial;
  const factory ProductState.loading() = _Loading;
  const factory ProductState.loaded(List<ProductsModel> products) = _Loaded;
  const factory ProductState.searching() = _Searching;
  const factory ProductState.searchResults(SearchResponse response) =
      _SearchResults;
  const factory ProductState.error(String message) = _Error;
}
