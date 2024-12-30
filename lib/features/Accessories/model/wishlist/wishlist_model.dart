import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_model.freezed.dart';
part 'wishlist_model.g.dart';

@freezed
class WishlistResponse with _$WishlistResponse {
  const factory WishlistResponse({
    required int id,
    @JsonKey(name: 'product_name')
    required String productName,
    @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)  // Updated to use full path
    required double productPrice,
    @JsonKey(name: 'product_image')
    String? productImage,
    @JsonKey(name: 'product_description')
    String? productDescription,
  }) = _WishlistResponse;

  // Add this static method outside the factory constructor
  static double _priceFromJson(dynamic price) {
    if (price == null) return 0.0;
    if (price is num) return price.toDouble();
    if (price is String) {
      // Remove any currency symbols and whitespace
      final cleanPrice = price.replaceAll(RegExp(r'[^\d.]'), '');
      return double.tryParse(cleanPrice) ?? 0.0;
    }
    return 0.0;
  }

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistResponseFromJson(json);
}