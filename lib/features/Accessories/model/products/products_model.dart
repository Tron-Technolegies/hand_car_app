import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_model.freezed.dart';
part 'products_model.g.dart';

//Products Model class to get the data from the API


@freezed
class ProductsModel with _$ProductsModel {
  const factory ProductsModel({
    required int id,
    required String name,
    required String category,
    required String brand,
    required String price,
    String? image,
    @JsonKey(name: "discount_percentage")
    @Default(0) int discountPercentage,  // Set default value to 0
    @Default('') String description,
    @JsonKey(name: "is_bestseller")      // Add JsonKey for is_bestseller
    @Default(false) bool isBestseller,
  }) = _ProductModel;

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);
}
