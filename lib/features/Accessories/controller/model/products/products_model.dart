import 'package:freezed_annotation/freezed_annotation.dart';

part 'products_model.freezed.dart';
part 'products_model.g.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required int id,
    required String name,
    required String price,
    required String brand,
    required String? imageUrl,
    required String description,
  }) = _Product;

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}
