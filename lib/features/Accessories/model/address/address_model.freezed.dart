// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) {
  return _AddressModel.fromJson(json);
}

/// @nodoc
mixin _$AddressModel {
  @JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "phone_number")
  String get phoneNumber => throw _privateConstructorUsedError;
  String get street => throw _privateConstructorUsedError;
  @JsonKey(name: 'building_name')
  String get buildingName => throw _privateConstructorUsedError;
  @JsonKey(name: 'floor_apartment_no')
  String get floorApartmentNo => throw _privateConstructorUsedError;
  String? get landmark => throw _privateConstructorUsedError;
  String get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'area_district')
  String get areaDistrict => throw _privateConstructorUsedError;
  String get country => throw _privateConstructorUsedError;
  @JsonKey(name: 'address_type')
  String get addressType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_default')
  bool get isDefault => throw _privateConstructorUsedError;

  /// Serializes this AddressModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressModelCopyWith<AddressModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressModelCopyWith<$Res> {
  factory $AddressModelCopyWith(
          AddressModel value, $Res Function(AddressModel) then) =
      _$AddressModelCopyWithImpl<$Res, AddressModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
      String id,
      String name,
      @JsonKey(name: "phone_number") String phoneNumber,
      String street,
      @JsonKey(name: 'building_name') String buildingName,
      @JsonKey(name: 'floor_apartment_no') String floorApartmentNo,
      String? landmark,
      String city,
      @JsonKey(name: 'area_district') String areaDistrict,
      String country,
      @JsonKey(name: 'address_type') String addressType,
      @JsonKey(name: 'is_default') bool isDefault});
}

/// @nodoc
class _$AddressModelCopyWithImpl<$Res, $Val extends AddressModel>
    implements $AddressModelCopyWith<$Res> {
  _$AddressModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? street = null,
    Object? buildingName = null,
    Object? floorApartmentNo = null,
    Object? landmark = freezed,
    Object? city = null,
    Object? areaDistrict = null,
    Object? country = null,
    Object? addressType = null,
    Object? isDefault = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      buildingName: null == buildingName
          ? _value.buildingName
          : buildingName // ignore: cast_nullable_to_non_nullable
              as String,
      floorApartmentNo: null == floorApartmentNo
          ? _value.floorApartmentNo
          : floorApartmentNo // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      areaDistrict: null == areaDistrict
          ? _value.areaDistrict
          : areaDistrict // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      addressType: null == addressType
          ? _value.addressType
          : addressType // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AddressModelImplCopyWith<$Res>
    implements $AddressModelCopyWith<$Res> {
  factory _$$AddressModelImplCopyWith(
          _$AddressModelImpl value, $Res Function(_$AddressModelImpl) then) =
      __$$AddressModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
      String id,
      String name,
      @JsonKey(name: "phone_number") String phoneNumber,
      String street,
      @JsonKey(name: 'building_name') String buildingName,
      @JsonKey(name: 'floor_apartment_no') String floorApartmentNo,
      String? landmark,
      String city,
      @JsonKey(name: 'area_district') String areaDistrict,
      String country,
      @JsonKey(name: 'address_type') String addressType,
      @JsonKey(name: 'is_default') bool isDefault});
}

/// @nodoc
class __$$AddressModelImplCopyWithImpl<$Res>
    extends _$AddressModelCopyWithImpl<$Res, _$AddressModelImpl>
    implements _$$AddressModelImplCopyWith<$Res> {
  __$$AddressModelImplCopyWithImpl(
      _$AddressModelImpl _value, $Res Function(_$AddressModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? phoneNumber = null,
    Object? street = null,
    Object? buildingName = null,
    Object? floorApartmentNo = null,
    Object? landmark = freezed,
    Object? city = null,
    Object? areaDistrict = null,
    Object? country = null,
    Object? addressType = null,
    Object? isDefault = null,
  }) {
    return _then(_$AddressModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      street: null == street
          ? _value.street
          : street // ignore: cast_nullable_to_non_nullable
              as String,
      buildingName: null == buildingName
          ? _value.buildingName
          : buildingName // ignore: cast_nullable_to_non_nullable
              as String,
      floorApartmentNo: null == floorApartmentNo
          ? _value.floorApartmentNo
          : floorApartmentNo // ignore: cast_nullable_to_non_nullable
              as String,
      landmark: freezed == landmark
          ? _value.landmark
          : landmark // ignore: cast_nullable_to_non_nullable
              as String?,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as String,
      areaDistrict: null == areaDistrict
          ? _value.areaDistrict
          : areaDistrict // ignore: cast_nullable_to_non_nullable
              as String,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      addressType: null == addressType
          ? _value.addressType
          : addressType // ignore: cast_nullable_to_non_nullable
              as String,
      isDefault: null == isDefault
          ? _value.isDefault
          : isDefault // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressModelImpl implements _AddressModel {
  const _$AddressModelImpl(
      {@JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
      required this.id,
      required this.name,
      @JsonKey(name: "phone_number") required this.phoneNumber,
      required this.street,
      @JsonKey(name: 'building_name') required this.buildingName,
      @JsonKey(name: 'floor_apartment_no') required this.floorApartmentNo,
      this.landmark,
      required this.city,
      @JsonKey(name: 'area_district') required this.areaDistrict,
      required this.country,
      @JsonKey(name: 'address_type') required this.addressType,
      @JsonKey(name: 'is_default') this.isDefault = false});

  factory _$AddressModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressModelImplFromJson(json);

  @override
  @JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
  final String id;
  @override
  final String name;
  @override
  @JsonKey(name: "phone_number")
  final String phoneNumber;
  @override
  final String street;
  @override
  @JsonKey(name: 'building_name')
  final String buildingName;
  @override
  @JsonKey(name: 'floor_apartment_no')
  final String floorApartmentNo;
  @override
  final String? landmark;
  @override
  final String city;
  @override
  @JsonKey(name: 'area_district')
  final String areaDistrict;
  @override
  final String country;
  @override
  @JsonKey(name: 'address_type')
  final String addressType;
  @override
  @JsonKey(name: 'is_default')
  final bool isDefault;

  @override
  String toString() {
    return 'AddressModel(id: $id, name: $name, phoneNumber: $phoneNumber, street: $street, buildingName: $buildingName, floorApartmentNo: $floorApartmentNo, landmark: $landmark, city: $city, areaDistrict: $areaDistrict, country: $country, addressType: $addressType, isDefault: $isDefault)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.street, street) || other.street == street) &&
            (identical(other.buildingName, buildingName) ||
                other.buildingName == buildingName) &&
            (identical(other.floorApartmentNo, floorApartmentNo) ||
                other.floorApartmentNo == floorApartmentNo) &&
            (identical(other.landmark, landmark) ||
                other.landmark == landmark) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.areaDistrict, areaDistrict) ||
                other.areaDistrict == areaDistrict) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.addressType, addressType) ||
                other.addressType == addressType) &&
            (identical(other.isDefault, isDefault) ||
                other.isDefault == isDefault));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phoneNumber,
      street,
      buildingName,
      floorApartmentNo,
      landmark,
      city,
      areaDistrict,
      country,
      addressType,
      isDefault);

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      __$$AddressModelImplCopyWithImpl<_$AddressModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressModelImplToJson(
      this,
    );
  }
}

abstract class _AddressModel implements AddressModel {
  const factory _AddressModel(
      {@JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
      required final String id,
      required final String name,
      @JsonKey(name: "phone_number") required final String phoneNumber,
      required final String street,
      @JsonKey(name: 'building_name') required final String buildingName,
      @JsonKey(name: 'floor_apartment_no')
      required final String floorApartmentNo,
      final String? landmark,
      required final String city,
      @JsonKey(name: 'area_district') required final String areaDistrict,
      required final String country,
      @JsonKey(name: 'address_type') required final String addressType,
      @JsonKey(name: 'is_default') final bool isDefault}) = _$AddressModelImpl;

  factory _AddressModel.fromJson(Map<String, dynamic> json) =
      _$AddressModelImpl.fromJson;

  @override
  @JsonKey(name: 'id', fromJson: _convertToString, toJson: _convertToInt)
  String get id;
  @override
  String get name;
  @override
  @JsonKey(name: "phone_number")
  String get phoneNumber;
  @override
  String get street;
  @override
  @JsonKey(name: 'building_name')
  String get buildingName;
  @override
  @JsonKey(name: 'floor_apartment_no')
  String get floorApartmentNo;
  @override
  String? get landmark;
  @override
  String get city;
  @override
  @JsonKey(name: 'area_district')
  String get areaDistrict;
  @override
  String get country;
  @override
  @JsonKey(name: 'address_type')
  String get addressType;
  @override
  @JsonKey(name: 'is_default')
  bool get isDefault;

  /// Create a copy of AddressModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressModelImplCopyWith<_$AddressModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
