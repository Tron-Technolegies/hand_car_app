// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistResponseImpl _$$WishlistResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WishlistResponseImpl(
      message: json['message'] as String,
      productId: json['productId'] as String,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$$WishlistResponseImplToJson(
        _$WishlistResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'productId': instance.productId,
      'error': instance.error,
    };
