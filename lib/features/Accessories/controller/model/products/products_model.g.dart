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
      discount_percentage: (json['discount_percentage'] as num?)?.toDouble(),
      description: json['description'] as String? ?? '',
      isBestseller: json['isBestseller'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductModelImplToJson(_$ProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'brand': instance.brand,
      'price': instance.price,
      'image': instance.image,
      'discount_percentage': instance.discount_percentage,
      'description': instance.description,
      'isBestseller': instance.isBestseller,
    };
