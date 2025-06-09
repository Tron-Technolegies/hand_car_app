


import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response.freezed.dart';
part 'order_response.g.dart';
@freezed
class OrderResponse with _$OrderResponse {
  
  const factory OrderResponse({
    required String message,
    @JsonKey(name:'order_id')  required String orderId,
    @JsonKey(name:'order_details') required Map<String, dynamic> orderDetails,
  }) = _OrderResponse;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);
}