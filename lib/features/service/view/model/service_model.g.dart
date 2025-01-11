// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceModelImpl _$$ServiceModelImplFromJson(Map<String, dynamic> json) =>
    _$ServiceModelImpl(
      serviceName: json['service_name'] as String,
      serviceCategory: json['service_category'] as String,
      serviceDetails: json['service_details'] as String,
      rate: (json['rate'] as num).toDouble(),
      image: json['image'] as String,
    );

Map<String, dynamic> _$$ServiceModelImplToJson(_$ServiceModelImpl instance) =>
    <String, dynamic>{
      'service_name': instance.serviceName,
      'service_category': instance.serviceCategory,
      'service_details': instance.serviceDetails,
      'rate': instance.rate,
      'image': instance.image,
    };
