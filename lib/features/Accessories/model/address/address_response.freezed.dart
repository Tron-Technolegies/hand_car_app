// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AddressResponse _$AddressResponseFromJson(Map<String, dynamic> json) {
  return _AddressResponse.fromJson(json);
}

/// @nodoc
mixin _$AddressResponse {
  String? get message => throw _privateConstructorUsedError;
  AddressModel? get address => throw _privateConstructorUsedError;
  bool get isSuccess => throw _privateConstructorUsedError;

  /// Serializes this AddressResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressResponseCopyWith<AddressResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressResponseCopyWith<$Res> {
  factory $AddressResponseCopyWith(
          AddressResponse value, $Res Function(AddressResponse) then) =
      _$AddressResponseCopyWithImpl<$Res, AddressResponse>;
  @useResult
  $Res call({String? message, AddressModel? address, bool isSuccess});

  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class _$AddressResponseCopyWithImpl<$Res, $Val extends AddressResponse>
    implements $AddressResponseCopyWith<$Res> {
  _$AddressResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? address = freezed,
    Object? isSuccess = null,
  }) {
    return _then(_value.copyWith(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of AddressResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AddressModelCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressModelCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AddressResponseImplCopyWith<$Res>
    implements $AddressResponseCopyWith<$Res> {
  factory _$$AddressResponseImplCopyWith(_$AddressResponseImpl value,
          $Res Function(_$AddressResponseImpl) then) =
      __$$AddressResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? message, AddressModel? address, bool isSuccess});

  @override
  $AddressModelCopyWith<$Res>? get address;
}

/// @nodoc
class __$$AddressResponseImplCopyWithImpl<$Res>
    extends _$AddressResponseCopyWithImpl<$Res, _$AddressResponseImpl>
    implements _$$AddressResponseImplCopyWith<$Res> {
  __$$AddressResponseImplCopyWithImpl(
      _$AddressResponseImpl _value, $Res Function(_$AddressResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of AddressResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = freezed,
    Object? address = freezed,
    Object? isSuccess = null,
  }) {
    return _then(_$AddressResponseImpl(
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as AddressModel?,
      isSuccess: null == isSuccess
          ? _value.isSuccess
          : isSuccess // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressResponseImpl implements _AddressResponse {
  const _$AddressResponseImpl(
      {this.message, this.address, this.isSuccess = false});

  factory _$AddressResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AddressResponseImplFromJson(json);

  @override
  final String? message;
  @override
  final AddressModel? address;
  @override
  @JsonKey()
  final bool isSuccess;

  @override
  String toString() {
    return 'AddressResponse(message: $message, address: $address, isSuccess: $isSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.isSuccess, isSuccess) ||
                other.isSuccess == isSuccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, address, isSuccess);

  /// Create a copy of AddressResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressResponseImplCopyWith<_$AddressResponseImpl> get copyWith =>
      __$$AddressResponseImplCopyWithImpl<_$AddressResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressResponseImplToJson(
      this,
    );
  }
}

abstract class _AddressResponse implements AddressResponse {
  const factory _AddressResponse(
      {final String? message,
      final AddressModel? address,
      final bool isSuccess}) = _$AddressResponseImpl;

  factory _AddressResponse.fromJson(Map<String, dynamic> json) =
      _$AddressResponseImpl.fromJson;

  @override
  String? get message;
  @override
  AddressModel? get address;
  @override
  bool get isSuccess;

  /// Create a copy of AddressResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressResponseImplCopyWith<_$AddressResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
