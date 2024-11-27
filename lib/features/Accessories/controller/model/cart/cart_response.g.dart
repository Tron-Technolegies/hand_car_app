// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartResponseImpl _$$CartResponseImplFromJson(Map<String, dynamic> json) =>
    _$CartResponseImpl(
      message: json['message'] as String?,
      cartQuantity: (json['cartQuantity'] as num?)?.toInt(),
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$CartResponseImplToJson(_$CartResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'cartQuantity': instance.cartQuantity,
      'error': instance.error,
    };
