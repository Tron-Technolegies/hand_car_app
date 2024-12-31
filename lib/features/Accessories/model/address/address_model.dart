import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class AddressModel with _$AddressModel {
  const factory AddressModel({
    @JsonKey(
      name: 'id', 
      fromJson: _convertToString, 
      toJson: _convertToInt
    ) required String id,
    required String street,
    required String city,
    required String state,
    @JsonKey(name: 'zip_code') required String zipCode,
    required String country,
    @JsonKey(name: 'is_default') @Default(false) bool isDefault,
  }) = _AddressModel;

  factory AddressModel.fromJson(Map<String, dynamic> json) => 
      _$AddressModelFromJson(json);
}

// Convert dynamic (int or String) to String
String _convertToString(dynamic value) {
  return value.toString();
}

// Convert String back to int for toJson if needed
int _convertToInt(String value) {
  return int.parse(value);
}