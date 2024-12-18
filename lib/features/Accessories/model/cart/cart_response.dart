import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_response.freezed.dart';
part 'cart_response.g.dart';

@freezed
//Cart Response Model
class CartResponse with _$CartResponse {
  const factory CartResponse({
    String? message,
    int? cartQuantity,
    String? error,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}
