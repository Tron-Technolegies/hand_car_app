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
      category: json['category'] as String?,
      brand: json['brand'] as String?,
      originalPrice: (json['original_price'] as num).toDouble(),
      discountedPrice: (json['discounted_price'] as num).toDouble(),
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      description: json['description'] as String? ?? '',
      isBestseller: json['is_bestseller'] as bool? ?? false,
      averageRating: (json['average_rating'] as num?)?.toDouble(),
      image: json['image'] as String?,
      createdAt: json['created_at'] as String?,
    );

Map<String, dynamic> _$$PromotedProductsModelImplToJson(
        _$PromotedProductsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      if (instance.category case final value?) 'category': value,
      if (instance.brand case final value?) 'brand': value,
      'original_price': instance.originalPrice,
      'discounted_price': instance.discountedPrice,
      'discount_percentage': instance.discountPercentage,
      'description': instance.description,
      'is_bestseller': instance.isBestseller,
      if (instance.averageRating case final value?) 'average_rating': value,
      if (instance.image case final value?) 'image': value,
      if (instance.createdAt case final value?) 'created_at': value,
    };
