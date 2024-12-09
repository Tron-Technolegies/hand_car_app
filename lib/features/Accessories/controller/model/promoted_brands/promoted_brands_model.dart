import 'package:freezed_annotation/freezed_annotation.dart';

part 'promoted_brands_model.freezed.dart';
part 'promoted_brands_model.g.dart';

@freezed
class PromotedProduct with _$PromotedProduct {
  const factory PromotedProduct({
    required int id,
    required String name,
  }) = _PromotedProduct;

  factory PromotedProduct.fromJson(Map<String, dynamic> json) =>
      _$PromotedProductFromJson(json);
}