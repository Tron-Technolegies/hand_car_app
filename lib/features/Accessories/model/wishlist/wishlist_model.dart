import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_model.freezed.dart';
part 'wishlist_model.g.dart';

@freezed
class WishlistResponse with _$WishlistResponse {
  const factory WishlistResponse({
    required int id,                    // Changed from productId to id
    @JsonKey(name: 'product_name')     // Map API field to model field
    required String productName,
    @JsonKey(name: 'product_price')    // Map API field to model field
    required double productPrice,
    @JsonKey(name: 'product_image')    // Map API field to model field
    String? productImage,
    @JsonKey(name: 'product_description') // Map API field to model field
    String? productDescription,
  }) = _WishlistResponse;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistResponseFromJson(json);
}