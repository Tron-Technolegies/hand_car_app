import 'package:freezed_annotation/freezed_annotation.dart';

part 'wishlist_response_model.freezed.dart';
part 'wishlist_response_model.g.dart';

//Wishlist Model class to get the data from the API
@freezed
class WishlistResponse with _$WishlistResponse {
  const factory WishlistResponse({
    required String message,
    required String productId,
    String? error,
  }) = _WishlistResponse;

  factory WishlistResponse.fromJson(Map<String, dynamic> json) =>
      _$WishlistResponseFromJson(json);
}
