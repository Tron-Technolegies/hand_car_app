import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_model.freezed.dart';
part 'products_model.g.dart';

@freezed
class ProductsModel with _$ProductsModel {
  const factory ProductsModel({
    required int id,
    required String name,
    required String category,
    required String brand,
    @JsonKey(name: "original_price") 
    required double originalPrice, 
    @JsonKey(name: "discounted_price") 
    required double discountedPrice, 
    String? image,
    @JsonKey(name: "discount_percentage")
    @Default(0) int discountPercentage,  
    @Default('') String description,
    @JsonKey(name: "is_bestseller")      
    @Default(false) bool isBestseller,
    @JsonKey(name: "average_rating")
    @Default(0.0) double averageRating, 
    @JsonKey(name: "total_reviews")
    @Default(0) int totalReviews,
  }) = _ProductModel;

  factory ProductsModel.fromJson(Map<String, dynamic> json) =>
      _$ProductsModelFromJson(json);
}