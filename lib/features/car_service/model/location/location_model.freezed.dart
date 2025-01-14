// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceLocation _$ServiceLocationFromJson(Map<String, dynamic> json) {
  return _ServiceLocation.fromJson(json);
}

/// @nodoc
mixin _$ServiceLocation {
  String get name => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  double get distance => throw _privateConstructorUsedError;

  /// Serializes this ServiceLocation to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceLocationCopyWith<ServiceLocation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceLocationCopyWith<$Res> {
  factory $ServiceLocationCopyWith(
          ServiceLocation value, $Res Function(ServiceLocation) then) =
      _$ServiceLocationCopyWithImpl<$Res, ServiceLocation>;
  @useResult
  $Res call({String name, double latitude, double longitude, double distance});
}

/// @nodoc
class _$ServiceLocationCopyWithImpl<$Res, $Val extends ServiceLocation>
    implements $ServiceLocationCopyWith<$Res> {
  _$ServiceLocationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distance = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceLocationImplCopyWith<$Res>
    implements $ServiceLocationCopyWith<$Res> {
  factory _$$ServiceLocationImplCopyWith(_$ServiceLocationImpl value,
          $Res Function(_$ServiceLocationImpl) then) =
      __$$ServiceLocationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double latitude, double longitude, double distance});
}

/// @nodoc
class __$$ServiceLocationImplCopyWithImpl<$Res>
    extends _$ServiceLocationCopyWithImpl<$Res, _$ServiceLocationImpl>
    implements _$$ServiceLocationImplCopyWith<$Res> {
  __$$ServiceLocationImplCopyWithImpl(
      _$ServiceLocationImpl _value, $Res Function(_$ServiceLocationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceLocation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? distance = null,
  }) {
    return _then(_$ServiceLocationImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      distance: null == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceLocationImpl implements _ServiceLocation {
  const _$ServiceLocationImpl(
      {required this.name,
      required this.latitude,
      required this.longitude,
      required this.distance});

  factory _$ServiceLocationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceLocationImplFromJson(json);

  @override
  final String name;
  @override
  final double latitude;
  @override
  final double longitude;
  @override
  final double distance;

  @override
  String toString() {
    return 'ServiceLocation(name: $name, latitude: $latitude, longitude: $longitude, distance: $distance)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceLocationImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.distance, distance) ||
                other.distance == distance));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, latitude, longitude, distance);

  /// Create a copy of ServiceLocation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceLocationImplCopyWith<_$ServiceLocationImpl> get copyWith =>
      __$$ServiceLocationImplCopyWithImpl<_$ServiceLocationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceLocationImplToJson(
      this,
    );
  }
}

abstract class _ServiceLocation implements ServiceLocation {
  const factory _ServiceLocation(
      {required final String name,
      required final double latitude,
      required final double longitude,
      required final double distance}) = _$ServiceLocationImpl;

  factory _ServiceLocation.fromJson(Map<String, dynamic> json) =
      _$ServiceLocationImpl.fromJson;

  @override
  String get name;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  double get distance;

  /// Create a copy of ServiceLocation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceLocationImplCopyWith<_$ServiceLocationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ServicesState {
  List<ServiceLocation> get services => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServicesStateCopyWith<ServicesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServicesStateCopyWith<$Res> {
  factory $ServicesStateCopyWith(
          ServicesState value, $Res Function(ServicesState) then) =
      _$ServicesStateCopyWithImpl<$Res, ServicesState>;
  @useResult
  $Res call({List<ServiceLocation> services, bool isLoading, String? error});
}

/// @nodoc
class _$ServicesStateCopyWithImpl<$Res, $Val extends ServicesState>
    implements $ServicesStateCopyWith<$Res> {
  _$ServicesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceLocation>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServicesStateImplCopyWith<$Res>
    implements $ServicesStateCopyWith<$Res> {
  factory _$$ServicesStateImplCopyWith(
          _$ServicesStateImpl value, $Res Function(_$ServicesStateImpl) then) =
      __$$ServicesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ServiceLocation> services, bool isLoading, String? error});
}

/// @nodoc
class __$$ServicesStateImplCopyWithImpl<$Res>
    extends _$ServicesStateCopyWithImpl<$Res, _$ServicesStateImpl>
    implements _$$ServicesStateImplCopyWith<$Res> {
  __$$ServicesStateImplCopyWithImpl(
      _$ServicesStateImpl _value, $Res Function(_$ServicesStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$ServicesStateImpl(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceLocation>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ServicesStateImpl implements _ServicesState {
  const _$ServicesStateImpl(
      {this.services = const [], this.isLoading = false, this.error});

  @override
  @JsonKey()
  final List<ServiceLocation> services;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'ServicesState(services: $services, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServicesStateImpl &&
            const DeepCollectionEquality().equals(other.services, services) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(services), isLoading, error);

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServicesStateImplCopyWith<_$ServicesStateImpl> get copyWith =>
      __$$ServicesStateImplCopyWithImpl<_$ServicesStateImpl>(this, _$identity);
}

abstract class _ServicesState implements ServicesState {
  const factory _ServicesState(
      {final List<ServiceLocation> services,
      final bool isLoading,
      final String? error}) = _$ServicesStateImpl;

  @override
  List<ServiceLocation> get services;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of ServicesState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServicesStateImplCopyWith<_$ServicesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
