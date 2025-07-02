import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    @JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
    required String id,
    required String name,
    @JsonKey(name: "phone_number") required String phoneNumber,
    required String street,

    @JsonKey(name: 'building_name') required String buildingName,
    @JsonKey(name: 'floor_apartment_no') required String floorApartmentNo,
    String? landmark,
    required String city,
    @JsonKey(name: 'area_district') required String areaDistrict,
    required String country,
    @JsonKey(name: 'address_type') required String addressType,

    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) =>
      _$AddressModelFromJson(json);
}

// Move the conversion methods outside the class as top-level functions
String _convertToString(dynamic value) {
  if (value == null) return '';
  return value.toString();
}

int _convertToInt(String value) {
  try {
    return int.parse(value);
  } catch (e) {
    return 0; // or throw an exception based on your needs
  }
}
