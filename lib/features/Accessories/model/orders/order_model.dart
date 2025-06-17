import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderSummary with _$OrderSummary {
  const factory OrderSummary({
    required String orderId,
    required String status,
    @JsonKey(name: 'total_price', fromJson: _parseDouble) required double totalPrice,
    required List<OrderItem> items,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _OrderSummary;

  factory OrderSummary.fromJson(Map<String, dynamic> json) =>
      _$OrderSummaryFromJson(json);
}

double _parseDouble(dynamic value) {
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.parse(value);
  throw FormatException('Invalid double value: $value');
}

@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String name,
    @JsonKey(fromJson: _parseDouble) required double price,
    required int quantity,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}