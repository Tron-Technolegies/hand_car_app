// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceRatingListImpl _$$ServiceRatingListImplFromJson(
        Map<String, dynamic> json) =>
    _$ServiceRatingListImpl(
      ratings: (json['ratings'] as List<dynamic>)
          .map((e) => ServiceRating.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ServiceRatingListImplToJson(
        _$ServiceRatingListImpl instance) =>
    <String, dynamic>{
      'ratings': instance.ratings.map((e) => e.toJson()).toList(),
    };

_$ServiceRatingImpl _$$ServiceRatingImplFromJson(Map<String, dynamic> json) =>
    _$ServiceRatingImpl(
      id: json['id'] as String,
      vendorName: json['vendor_name'] as String,
      phoneNumber: json['phone_number'] as String,
      whatsappNumber: (json['whatsapp_number'] as num).toDouble(),
      serviceCategory: json['service_category'] as String?,
    );

Map<String, dynamic> _$$ServiceRatingImplToJson(_$ServiceRatingImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor_name': instance.vendorName,
      'phone_number': instance.phoneNumber,
      'whatsapp_number': instance.whatsappNumber,
      if (instance.serviceCategory case final value?) 'service_category': value,
    };
