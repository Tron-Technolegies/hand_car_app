// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LocationSearchResult {
  String get displayName => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  LatLng get latLng => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  String? get address => throw _privateConstructorUsedError;

  /// Create a copy of LocationSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationSearchResultCopyWith<LocationSearchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationSearchResultCopyWith<$Res> {
  factory $LocationSearchResultCopyWith(LocationSearchResult value,
          $Res Function(LocationSearchResult) then) =
      _$LocationSearchResultCopyWithImpl<$Res, LocationSearchResult>;
  @useResult
  $Res call(
      {String displayName,
      @JsonKey(ignore: true) LatLng latLng,
      String? type,
      String? address});
}

/// @nodoc
class _$LocationSearchResultCopyWithImpl<$Res,
        $Val extends LocationSearchResult>
    implements $LocationSearchResultCopyWith<$Res> {
  _$LocationSearchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? latLng = null,
    Object? type = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationSearchResultImplCopyWith<$Res>
    implements $LocationSearchResultCopyWith<$Res> {
  factory _$$LocationSearchResultImplCopyWith(_$LocationSearchResultImpl value,
          $Res Function(_$LocationSearchResultImpl) then) =
      __$$LocationSearchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String displayName,
      @JsonKey(ignore: true) LatLng latLng,
      String? type,
      String? address});
}

/// @nodoc
class __$$LocationSearchResultImplCopyWithImpl<$Res>
    extends _$LocationSearchResultCopyWithImpl<$Res, _$LocationSearchResultImpl>
    implements _$$LocationSearchResultImplCopyWith<$Res> {
  __$$LocationSearchResultImplCopyWithImpl(_$LocationSearchResultImpl _value,
      $Res Function(_$LocationSearchResultImpl) _then)
      : super(_value, _then);

  /// Create a copy of LocationSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? displayName = null,
    Object? latLng = null,
    Object? type = freezed,
    Object? address = freezed,
  }) {
    return _then(_$LocationSearchResultImpl(
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      latLng: null == latLng
          ? _value.latLng
          : latLng // ignore: cast_nullable_to_non_nullable
              as LatLng,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LocationSearchResultImpl implements _LocationSearchResult {
  const _$LocationSearchResultImpl(
      {required this.displayName,
      @JsonKey(ignore: true) required this.latLng,
      this.type,
      this.address});

  @override
  final String displayName;
  @override
  @JsonKey(ignore: true)
  final LatLng latLng;
  @override
  final String? type;
  @override
  final String? address;

  @override
  String toString() {
    return 'LocationSearchResult(displayName: $displayName, latLng: $latLng, type: $type, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationSearchResultImpl &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.latLng, latLng) || other.latLng == latLng) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, displayName, latLng, type, address);

  /// Create a copy of LocationSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationSearchResultImplCopyWith<_$LocationSearchResultImpl>
      get copyWith =>
          __$$LocationSearchResultImplCopyWithImpl<_$LocationSearchResultImpl>(
              this, _$identity);
}

abstract class _LocationSearchResult implements LocationSearchResult {
  const factory _LocationSearchResult(
      {required final String displayName,
      @JsonKey(ignore: true) required final LatLng latLng,
      final String? type,
      final String? address}) = _$LocationSearchResultImpl;

  @override
  String get displayName;
  @override
  @JsonKey(ignore: true)
  LatLng get latLng;
  @override
  String? get type;
  @override
  String? get address;

  /// Create a copy of LocationSearchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationSearchResultImplCopyWith<_$LocationSearchResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}
