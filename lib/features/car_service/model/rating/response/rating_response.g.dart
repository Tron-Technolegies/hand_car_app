// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceRatingResponseImpl _$$ServiceRatingResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceRatingResponseImpl(
      error: json['error'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$ServiceRatingResponseImplToJson(
        _$ServiceRatingResponseImpl instance) =>
    <String, dynamic>{
      if (instance.error case final value?) 'error': value,
      if (instance.message case final value?) 'message': value,
    };
