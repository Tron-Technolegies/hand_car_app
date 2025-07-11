import 'package:freezed_annotation/freezed_annotation.dart';

part 'promoted_products_model.freezed.dart';
part 'promoted_products_model.g.dart';

@freezed
class PromotedProductsModel with _$PromotedProductsModel {
  const factory PromotedProductsModel({
    required int id,
    required String name,
    @JsonKey(name: "category") String? category,
    @JsonKey(name: "brand") String? brand,
    @JsonKey(name: "original_price") required double originalPrice,
    @JsonKey(name: "discounted_price") required double discountedPrice,
    @JsonKey(name: "discount_percentage") required int discountPercentage,
    @JsonKey(name: "description") @Default('') String description,
    @JsonKey(name: "is_bestseller") @Default(false) bool isBestseller,
    @JsonKey(name: "average_rating") double? averageRating,
    String? image,
    @JsonKey(name: "created_at") String? createdAt,
  }) = _PromotedProductsModel;

  factory PromotedProductsModel.fromJson(Map<String, dynamic> json) =>
      _$PromotedProductsModelFromJson(json);
}
