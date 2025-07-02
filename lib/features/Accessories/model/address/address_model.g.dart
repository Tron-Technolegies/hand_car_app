// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressModelImpl _$$AddressModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressModelImpl(
      id: _convertToString(json['id']),
      name: json['name'] as String,
      phoneNumber: json['phone_number'] as String,
      street: json['street'] as String,
      buildingName: json['building_name'] as String,
      floorApartmentNo: json['floor_apartment_no'] as String,
      landmark: json['landmark'] as String?,
      city: json['city'] as String,
      areaDistrict: json['area_district'] as String,
      country: json['country'] as String,
      addressType: json['address_type'] as String,
      isDefault: json['is_default'] as bool? ?? false,
    );

Map<String, dynamic> _$$AddressModelImplToJson(_$AddressModelImpl instance) =>
    <String, dynamic>{
      'id': _convertToInt(instance.id),
      'name': instance.name,
      'phone_number': instance.phoneNumber,
      'street': instance.street,
      'building_name': instance.buildingName,
      'floor_apartment_no': instance.floorApartmentNo,
      if (instance.landmark case final value?) 'landmark': value,
      'city': instance.city,
      'area_district': instance.areaDistrict,
      'country': instance.country,
      'address_type': instance.addressType,
      'is_default': instance.isDefault,
    };
