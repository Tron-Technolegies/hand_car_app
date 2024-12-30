// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchResponseImpl _$$SearchResponseImplFromJson(Map<String, dynamic> json) =>
    _$SearchResponseImpl(
      accessories: (json['accessories'] as List<dynamic>)
          .map((e) => ProductsModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      query: json['query'] as String,
    );

Map<String, dynamic> _$$SearchResponseImplToJson(
        _$SearchResponseImpl instance) =>
    <String, dynamic>{
      'accessories': instance.accessories.map((e) => e.toJson()).toList(),
      'query': instance.query,
    };
