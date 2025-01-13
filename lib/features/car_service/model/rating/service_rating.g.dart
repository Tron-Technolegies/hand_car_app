// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceRatingModelImpl _$$ServiceRatingModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceRatingModelImpl(
      serviceId: _parseId(json['service_id']),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$$ServiceRatingModelImplToJson(
        _$ServiceRatingModelImpl instance) =>
    <String, dynamic>{
      'service_id': instance.serviceId,
      'rating': instance.rating,
      if (instance.comment case final value?) 'comment': value,
    };
