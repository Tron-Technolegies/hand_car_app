import 'package:freezed_annotation/freezed_annotation.dart';

part 'promoted_brands_model.freezed.dart';
part 'promoted_brands_model.g.dart';
@freezed
class PromotedBrandProductModel with _$PromotedBrandProductModel {
  const factory PromotedBrandProductModel({
    required int id,
    required String name,
    @JsonKey(name: "original_price") required double originalPrice,
    @JsonKey(name: "discounted_price") required double discountedPrice,
    @JsonKey(name: "discount_percentage", fromJson: _intFromJson) required int discountPercentage,
    String? image,
  }) = _PromotedBrandProductModel;

  factory PromotedBrandProductModel.fromJson(Map<String, dynamic> json) =>
      _$PromotedBrandProductModelFromJson(json);
}

int _intFromJson(dynamic value) => (value as num).toInt();