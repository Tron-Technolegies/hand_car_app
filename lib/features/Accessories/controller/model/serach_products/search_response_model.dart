import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hand_car/features/Accessories/controller/model/products/products_model.dart';

part 'search_response_model.freezed.dart';
part 'search_response_model.g.dart';

@freezed
class SearchResponse with _$SearchResponse {
  const factory SearchResponse({
    required List<ProductsModel> accessories,
    required String query,
  }) = _SearchResponse;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => _SearchResponse(
        accessories: (json['accessories'] as List<dynamic>)
            .map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        query: json['query'] as String,
      );
}
