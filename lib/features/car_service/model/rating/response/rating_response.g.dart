// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceRatingResponseImpl _$$ServiceRatingResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceRatingResponseImpl(
      error: json['error'] as String?,
      success: json['success'] as bool?,
    );

Map<String, dynamic> _$$ServiceRatingResponseImplToJson(
        _$ServiceRatingResponseImpl instance) =>
    <String, dynamic>{
      if (instance.error case final value?) 'error': value,
      if (instance.success case final value?) 'success': value,
    };
