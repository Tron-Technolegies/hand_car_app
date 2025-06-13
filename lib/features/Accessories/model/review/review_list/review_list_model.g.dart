// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewListImpl _$$ReviewListImplFromJson(Map<String, dynamic> json) =>
    _$ReviewListImpl(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ReviewListImplToJson(_$ReviewListImpl instance) =>
    <String, dynamic>{
      'reviews': instance.reviews.map((e) => e.toJson()).toList(),
    };
