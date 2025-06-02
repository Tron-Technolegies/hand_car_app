import 'dart:developer';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_response.freezed.dart';
part 'cart_response.g.dart';

@freezed
class CartResponse with _$CartResponse {
  const factory CartResponse({
    @Default('') String message,
    @JsonKey(name: 'cart_quantity', defaultValue: 0) required int cartQuantity,
    @Default(true) bool isSuccess,
    String? error,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);
}