// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderResponseImpl _$$OrderResponseImplFromJson(Map<String, dynamic> json) =>
    _$OrderResponseImpl(
      message: json['message'] as String,
      orderId: json['order_id'] as String,
      orderDetails: json['order_details'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$OrderResponseImplToJson(_$OrderResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'order_id': instance.orderId,
      'order_details': instance.orderDetails,
    };
