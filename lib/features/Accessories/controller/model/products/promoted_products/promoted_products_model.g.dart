// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promoted_products_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotedProductsModelImpl _$$PromotedProductsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PromotedProductsModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      category: json['category'] as String,
      brand: json['brand'] as String,
      price: json['price'] as String,
      description: json['description'] as String,
      isBestseller: json['is_bestseller'] as bool,
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      image: json['image'] as String?,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$$PromotedProductsModelImplToJson(
        _$PromotedProductsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'brand': instance.brand,
      'price': instance.price,
      'description': instance.description,
      'is_bestseller': instance.isBestseller,
      'discount_percentage': instance.discountPercentage,
      'image': instance.image,
      'created_at': instance.createdAt,
    };
