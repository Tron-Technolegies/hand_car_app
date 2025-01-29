// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) {
  return _ServiceModel.fromJson(json);
}

/// @nodoc
mixin _$ServiceModel {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_name')
  String get vendorName => throw _privateConstructorUsedError;
  @JsonKey(name: 'phone_number')
  String get phoneNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'whatsapp_number')
  String get whatsappNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_category', fromJson: _parseCategory)
  String? get serviceCategory => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_details')
  String get serviceDetails => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'rate', fromJson: _parseRate)
  double? get rate => throw _privateConstructorUsedError;
  @JsonKey(fromJson: _parseImages)
  List<String> get images => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;

  /// Serializes this ServiceModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceModelCopyWith<ServiceModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceModelCopyWith<$Res> {
  factory $ServiceModelCopyWith(
          ServiceModel value, $Res Function(ServiceModel) then) =
      _$ServiceModelCopyWithImpl<$Res, ServiceModel>;
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'vendor_name') String vendorName,
      @JsonKey(name: 'phone_number') String phoneNumber,
      @JsonKey(name: 'whatsapp_number') String whatsappNumber,
      @JsonKey(name: 'service_category', fromJson: _parseCategory)
      String? serviceCategory,
      @JsonKey(name: 'service_details') String serviceDetails,
      String address,
      @JsonKey(name: 'rate', fromJson: _parseRate) double? rate,
      @JsonKey(fromJson: _parseImages) List<String> images,
      double? latitude,
      double? longitude,
      double? distance});
}

/// @nodoc
class _$ServiceModelCopyWithImpl<$Res, $Val extends ServiceModel>
    implements $ServiceModelCopyWith<$Res> {
  _$ServiceModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vendorName = null,
    Object? phoneNumber = null,
    Object? whatsappNumber = null,
    Object? serviceCategory = freezed,
    Object? serviceDetails = null,
    Object? address = null,
    Object? rate = freezed,
    Object? images = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distance = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      vendorName: null == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      whatsappNumber: null == whatsappNumber
          ? _value.whatsappNumber
          : whatsappNumber // ignore: cast_nullable_to_non_nullable
              as String,
      serviceCategory: freezed == serviceCategory
          ? _value.serviceCategory
          : serviceCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDetails: null == serviceDetails
          ? _value.serviceDetails
          : serviceDetails // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceModelImplCopyWith<$Res>
    implements $ServiceModelCopyWith<$Res> {
  factory _$$ServiceModelImplCopyWith(
          _$ServiceModelImpl value, $Res Function(_$ServiceModelImpl) then) =
      __$$ServiceModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'vendor_name') String vendorName,
      @JsonKey(name: 'phone_number') String phoneNumber,
      @JsonKey(name: 'whatsapp_number') String whatsappNumber,
      @JsonKey(name: 'service_category', fromJson: _parseCategory)
      String? serviceCategory,
      @JsonKey(name: 'service_details') String serviceDetails,
      String address,
      @JsonKey(name: 'rate', fromJson: _parseRate) double? rate,
      @JsonKey(fromJson: _parseImages) List<String> images,
      double? latitude,
      double? longitude,
      double? distance});
}

/// @nodoc
class __$$ServiceModelImplCopyWithImpl<$Res>
    extends _$ServiceModelCopyWithImpl<$Res, _$ServiceModelImpl>
    implements _$$ServiceModelImplCopyWith<$Res> {
  __$$ServiceModelImplCopyWithImpl(
      _$ServiceModelImpl _value, $Res Function(_$ServiceModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? vendorName = null,
    Object? phoneNumber = null,
    Object? whatsappNumber = null,
    Object? serviceCategory = freezed,
    Object? serviceDetails = null,
    Object? address = null,
    Object? rate = freezed,
    Object? images = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? distance = freezed,
  }) {
    return _then(_$ServiceModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      vendorName: null == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String,
      phoneNumber: null == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String,
      whatsappNumber: null == whatsappNumber
          ? _value.whatsappNumber
          : whatsappNumber // ignore: cast_nullable_to_non_nullable
              as String,
      serviceCategory: freezed == serviceCategory
          ? _value.serviceCategory
          : serviceCategory // ignore: cast_nullable_to_non_nullable
              as String?,
      serviceDetails: null == serviceDetails
          ? _value.serviceDetails
          : serviceDetails // ignore: cast_nullable_to_non_nullable
              as String,
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      images: null == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceModelImpl extends _ServiceModel {
  const _$ServiceModelImpl(
      {required this.id,
      @JsonKey(name: 'vendor_name') required this.vendorName,
      @JsonKey(name: 'phone_number') this.phoneNumber = '',
      @JsonKey(name: 'whatsapp_number') this.whatsappNumber = '',
      @JsonKey(name: 'service_category', fromJson: _parseCategory)
      this.serviceCategory,
      @JsonKey(name: 'service_details') this.serviceDetails = '',
      this.address = '',
      @JsonKey(name: 'rate', fromJson: _parseRate) this.rate,
      @JsonKey(fromJson: _parseImages) this.images = const [],
      this.latitude,
      this.longitude,
      this.distance})
      : super._();

  factory _$ServiceModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceModelImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'vendor_name')
  final String vendorName;
  @override
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  @override
  @JsonKey(name: 'whatsapp_number')
  final String whatsappNumber;
  @override
  @JsonKey(name: 'service_category', fromJson: _parseCategory)
  final String? serviceCategory;
  @override
  @JsonKey(name: 'service_details')
  final String serviceDetails;
  @override
  @JsonKey()
  final String address;
  @override
  @JsonKey(name: 'rate', fromJson: _parseRate)
  final double? rate;
  @override
  @JsonKey(fromJson: _parseImages)
  final List<String> images;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final double? distance;

  @override
  String toString() {
    return 'ServiceModel(id: $id, vendorName: $vendorName, phoneNumber: $phoneNumber, whatsappNumber: $whatsappNumber, serviceCategory: $serviceCategory, serviceDetails: $serviceDetails, address: $address, rate: $rate, images: $images, latitude: $latitude, longitude: $longitude, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vendorName, vendorName) ||
                other.vendorName == vendorName) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.whatsappNumber, whatsappNumber) ||
                other.whatsappNumber == whatsappNumber) &&
            (identical(other.serviceCategory, serviceCategory) ||
                other.serviceCategory == serviceCategory) &&
            (identical(other.serviceDetails, serviceDetails) ||
                other.serviceDetails == serviceDetails) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      vendorName,
      phoneNumber,
      whatsappNumber,
      serviceCategory,
      serviceDetails,
      address,
      rate,
      const DeepCollectionEquality().hash(images),
      latitude,
      longitude,
      distance);

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceModelImplCopyWith<_$ServiceModelImpl> get copyWith =>
      __$$ServiceModelImplCopyWithImpl<_$ServiceModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceModelImplToJson(
      this,
    );
  }
}

abstract class _ServiceModel extends ServiceModel {
  const factory _ServiceModel(
      {required final int id,
      @JsonKey(name: 'vendor_name') required final String vendorName,
      @JsonKey(name: 'phone_number') final String phoneNumber,
      @JsonKey(name: 'whatsapp_number') final String whatsappNumber,
      @JsonKey(name: 'service_category', fromJson: _parseCategory)
      final String? serviceCategory,
      @JsonKey(name: 'service_details') final String serviceDetails,
      final String address,
      @JsonKey(name: 'rate', fromJson: _parseRate) final double? rate,
      @JsonKey(fromJson: _parseImages) final List<String> images,
      final double? latitude,
      final double? longitude,
      final double? distance}) = _$ServiceModelImpl;
  const _ServiceModel._() : super._();

  factory _ServiceModel.fromJson(Map<String, dynamic> json) =
      _$ServiceModelImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'vendor_name')
  String get vendorName;
  @override
  @JsonKey(name: 'phone_number')
  String get phoneNumber;
  @override
  @JsonKey(name: 'whatsapp_number')
  String get whatsappNumber;
  @override
  @JsonKey(name: 'service_category', fromJson: _parseCategory)
  String? get serviceCategory;
  @override
  @JsonKey(name: 'service_details')
  String get serviceDetails;
  @override
  String get address;
  @override
  @JsonKey(name: 'rate', fromJson: _parseRate)
  double? get rate;
  @override
  @JsonKey(fromJson: _parseImages)
  List<String> get images;
  @override
  double? get latitude;
  @override
  double? get longitude;
  @override
  double? get distance;

  /// Create a copy of ServiceModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceModelImplCopyWith<_$ServiceModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
