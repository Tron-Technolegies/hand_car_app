import 'dart:developer';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_response.freezed.dart';


@freezed
class CartResponse with _$CartResponse {
  const factory CartResponse({
    @Default('') String message,
    @JsonKey(name: 'cart_quantity', defaultValue: 0) required int cartQuantity,
    @Default(true) bool isSuccess,
    String? error,
  }) = _CartResponse;

  factory CartResponse.fromJson(Map<String, dynamic> json) {
    try {
      // Success case
      if (json.containsKey('message') && json.containsKey('cart_quantity')) {
        return CartResponse(
          message: json['message'] as String? ?? '',
          cartQuantity: _parseCartQuantity(json['cart_quantity']),
          
          isSuccess: true,
        );
      }
      
      // Error case
      if (json.containsKey('error')) {
        return CartResponse(
          message: 'Error',
          cartQuantity: 0,
          isSuccess: false,
          error: json['error'] as String? ?? 'Unknown error',
        );
      }
      
      // Default case with proper error handling
      return CartResponse(
        message: json['message'] as String? ?? '',
        cartQuantity: _parseCartQuantity(json['cart_quantity']),
        error: json['error'] as String?,
      );
    } catch (e) {
      log('Error parsing CartResponse: $e');
      return const CartResponse(
        message: 'Error parsing response',
        cartQuantity: 0,
        isSuccess: false,
        error: 'Failed to parse response',
      );
    }
  }

  static int _parseCartQuantity(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) {
      try {
        return int.parse(value);
      } catch (_) {
        return 0;
      }
    }
    return 0;
  }
}