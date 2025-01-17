// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceRatingListImpl _$$ServiceRatingListImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceRatingListImpl(
      ratings: (json['Ratings'] as List<dynamic>?)
              ?.map((e) => ServiceRating.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ServiceRatingListImplToJson(
        _$ServiceRatingListImpl instance) =>
    <String, dynamic>{
      'Ratings': instance.ratings.map((e) => e.toJson()).toList(),
    };

_$ServiceRatingImpl _$$ServiceRatingImplFromJson(Map<String, dynamic> json) =>
    _$ServiceRatingImpl(
      id: (json['id'] as num).toInt(),
      vendorName: json['vendor_name'] as String,
      username: json['username'] as String,
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$ServiceRatingImplToJson(_$ServiceRatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor_name': instance.vendorName,
      'username': instance.username,
      'rating': instance.rating,
      if (instance.comment case final value?) 'comment': value,
    };
