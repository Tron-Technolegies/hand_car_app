// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderSummaryImpl _$$OrderSummaryImplFromJson(Map<String, dynamic> json) =>
    _$OrderSummaryImpl(
      orderId: json['order_id'] as String,
      status: json['status'] as String,
      totalPrice: _parseDouble(json['total_price']),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$OrderSummaryImplToJson(_$OrderSummaryImpl instance) =>
    <String, dynamic>{
      'order_id': instance.orderId,
      'status': instance.status,
      'total_price': instance.totalPrice,
      'items': instance.items.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
    };

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      name: json['name'] as String,
      price: _parseDouble(json['price']),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
    };
