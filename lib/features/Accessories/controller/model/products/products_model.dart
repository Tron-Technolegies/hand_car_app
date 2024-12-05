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
        required int discountPercentage,
    @Default('') String description,
    @Default(false) bool isBestseller,
  }) = _ProductModel;

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);
}
