
// features/Accessories/model/wishlist/wishlist_model.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_model.freezed.dart';
part 'wishlist_model.g.dart';

@freezed
class WishlistResponse with _$WishlistResponse {
  const factory WishlistResponse({
    required int id, // Wishlist item ID
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
    double? productPrice,
    @JsonKey(name: 'product_image') String? productImage,
    @JsonKey(name: 'product_description') String? productDescription,
  }) = _WishlistResponse;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistResponseFromJson(json);

  static double? _priceFromJson(dynamic price) {
    if (price == null) return null;
    if (price is num) return price.toDouble();
    if (price is String) {
      final cleanPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleanPrice);
    }
    return null;
  }
}
