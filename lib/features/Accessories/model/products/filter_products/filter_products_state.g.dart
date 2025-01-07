// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_products_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductsFilterStateImpl _$$ProductsFilterStateImplFromJson(
        Map<String, dynamic> json) =>
    _$ProductsFilterStateImpl(
      categoryId: json['category_id'] as String?,
      minPrice: (json['min_price'] as num?)?.toDouble() ?? 0.0,
      maxPrice: (json['max_price'] as num?)?.toDouble() ?? double.infinity,
      brandId: json['brand_id'] as String?,
      minRating: (json['min_rating'] as num?)?.toDouble() ?? 0.0,
      showNewArrivals: json['show_new_arrivals'] as bool? ?? false,
      showBestsellers: json['show_bestsellers'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductsFilterStateImplToJson(
        _$ProductsFilterStateImpl instance) =>
    <String, dynamic>{
      if (instance.categoryId case final value?) 'category_id': value,
      'min_price': instance.minPrice,
      'max_price': instance.maxPrice,
      if (instance.brandId case final value?) 'brand_id': value,
      'min_rating': instance.minRating,
      'show_new_arrivals': instance.showNewArrivals,
      'show_bestsellers': instance.showBestsellers,
    };
