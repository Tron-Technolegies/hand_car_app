// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductModelImpl _$$ProductModelImplFromJson(Map<String, dynamic> json) =>
    _$ProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: json['price'] as String,
      image: json['image'] as String?,
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      description: json['description'] as String? ?? '',
      isBestseller: json['is_bestseller'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'brand': instance.brand,
      'price': instance.price,
      if (instance.image case final value?) 'image': value,
      'discount_percentage': instance.discountPercentage,
      'description': instance.description,
      'is_bestseller': instance.isBestseller,
    };
