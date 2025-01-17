// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ServiceModelImpl _$$ServiceModelImplFromJson(Map<String, dynamic> json) =>
    _$ServiceModelImpl(
      id: (json['id'] as num).toInt(),
      vendorName: json['vendor_name'] as String,
      phoneNumber: json['phone_number'] as String,
      whatsappNumber: json['whatsapp_number'] as String,
      serviceCategory: json['service_category'] as String?,
      serviceDetails: json['service_details'] as String,
      address: json['address'] as String,
      rate: _parseRate(json['rate']),
      images: json['images'] == null ? const [] : _parseImages(json['images']),
      distance: _parseDistance(json['distance']),
    );

Map<String, dynamic> _$$ServiceModelImplToJson(_$ServiceModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vendor_name': instance.vendorName,
      'phone_number': instance.phoneNumber,
      'whatsapp_number': instance.whatsappNumber,
      if (instance.serviceCategory case final value?) 'service_category': value,
      'service_details': instance.serviceDetails,
      'address': instance.address,
      if (instance.rate case final value?) 'rate': value,
      'images': instance.images,
      if (instance.distance case final value?) 'distance': value,
    };
