// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressResponseImpl _$$AddressResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AddressResponseImpl(
      message: json['message'] as String?,
      address: json['address'] == null
          ? null
          : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
      isSuccess: json['is_success'] as bool? ?? false,
    );

Map<String, dynamic> _$$AddressResponseImplToJson(
        _$AddressResponseImpl instance) =>
    <String, dynamic>{
      if (instance.message case final value?) 'message': value,
      if (instance.address?.toJson() case final value?) 'address': value,
      'is_success': instance.isSuccess,
    };
