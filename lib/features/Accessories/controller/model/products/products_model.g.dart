// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductImpl _$$ProductImplFromJson(Map<String, dynamic> json) =>
    _$ProductImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      price: json['price'] as String,
      brand: json['brand'] as String,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$ProductImplToJson(_$ProductImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'brand': instance.brand,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
    };
