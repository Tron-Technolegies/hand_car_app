// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartResponseImpl _$$CartResponseImplFromJson(Map<String, dynamic> json) =>
    _$CartResponseImpl(
      message: json['message'] as String? ?? '',
      cartQuantity: (json['cart_quantity'] as num?)?.toInt() ?? 0,
      isSuccess: json['is_success'] as bool? ?? true,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$CartResponseImplToJson(_$CartResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cart_quantity': instance.cartQuantity,
      'is_success': instance.isSuccess,
      if (instance.error case final value?) 'error': value,
    };
