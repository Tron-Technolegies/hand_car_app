
import 'package:freezed_annotation/freezed_annotation.dart';

part 'promoted_products_model.freezed.dart';
part 'promoted_products_model.g.dart';

@freezed
class PromotedProductsModel with _$PromotedProductsModel {
  const factory PromotedProductsModel({
    required int id,
    required String name,
    required String category,
    required String brand,
    required String price,
    required String description,
    @JsonKey(name: 'is_bestseller') required bool isBestseller,
    @JsonKey(name: 'discount_percentage') required int discountPercentage,
    String? image,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _PromotedProductsModel;

  factory PromotedProductsModel.fromJson(Map<String, dynamic> json) => _$PromotedProductsModelFromJson(json);
}