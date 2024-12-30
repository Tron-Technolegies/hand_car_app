// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistResponseImpl _$$WishlistResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WishlistResponseImpl(
      id: (json['id'] as num).toInt(),
      productName: json['product_name'] as String,
      productPrice: WishlistResponse._priceFromJson(json['product_price']),
      productImage: json['product_image'] as String?,
      productDescription: json['product_description'] as String?,
    );

Map<String, dynamic> _$$WishlistResponseImplToJson(
        _$WishlistResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'product_name': instance.productName,
      'product_price': instance.productPrice,
      if (instance.productImage case final value?) 'product_image': value,
      if (instance.productDescription case final value?)
        'product_description': value,
    };
