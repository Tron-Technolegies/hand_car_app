// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promoted_brands_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromotedBrandProductModelImpl _$$PromotedBrandProductModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PromotedBrandProductModelImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      originalPrice: (json['original_price'] as num).toDouble(),
      discountedPrice: (json['discounted_price'] as num).toDouble(),
      discountPercentage: (json['discount_percentage'] as num).toInt(),
      image: json['image'] as String?,
    );

Map<String, dynamic> _$$PromotedBrandProductModelImplToJson(
        _$PromotedBrandProductModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'original_price': instance.originalPrice,
      'discounted_price': instance.discountedPrice,
      'discount_percentage': instance.discountPercentage,
      if (instance.image case final value?) 'image': value,
    };
