// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WishlistResponse _$WishlistResponseFromJson(Map<String, dynamic> json) {
  return _WishlistResponse.fromJson(json);
}

/// @nodoc
mixin _$WishlistResponse {
  String get message => throw _privateConstructorUsedError;
  String get productId => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Serializes this WishlistResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WishlistResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WishlistResponseCopyWith<WishlistResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistResponseCopyWith<$Res> {
  factory $WishlistResponseCopyWith(
          WishlistResponse value, $Res Function(WishlistResponse) then) =
      _$WishlistResponseCopyWithImpl<$Res, WishlistResponse>;
  @useResult
  $Res call({String message, String productId, String? error});
}

/// @nodoc
class _$WishlistResponseCopyWithImpl<$Res, $Val extends WishlistResponse>
    implements $WishlistResponseCopyWith<$Res> {
  _$WishlistResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WishlistResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? productId = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WishlistResponseImplCopyWith<$Res>
    implements $WishlistResponseCopyWith<$Res> {
  factory _$$WishlistResponseImplCopyWith(_$WishlistResponseImpl value,
          $Res Function(_$WishlistResponseImpl) then) =
      __$$WishlistResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String message, String productId, String? error});
}

/// @nodoc
class __$$WishlistResponseImplCopyWithImpl<$Res>
    extends _$WishlistResponseCopyWithImpl<$Res, _$WishlistResponseImpl>
    implements _$$WishlistResponseImplCopyWith<$Res> {
  __$$WishlistResponseImplCopyWithImpl(_$WishlistResponseImpl _value,
      $Res Function(_$WishlistResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of WishlistResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? productId = null,
    Object? error = freezed,
  }) {
    return _then(_$WishlistResponseImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      productId: null == productId
          ? _value.productId
          : productId // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishlistResponseImpl implements _WishlistResponse {
  const _$WishlistResponseImpl(
      {required this.message, required this.productId, this.error});

  factory _$WishlistResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishlistResponseImplFromJson(json);

  @override
  final String message;
  @override
  final String productId;
  @override
  final String? error;

  @override
  String toString() {
    return 'WishlistResponse(message: $message, productId: $productId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistResponseImpl &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.error, error) || other.error == error));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, message, productId, error);

  /// Create a copy of WishlistResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WishlistResponseImplCopyWith<_$WishlistResponseImpl> get copyWith =>
      __$$WishlistResponseImplCopyWithImpl<_$WishlistResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishlistResponseImplToJson(
      this,
    );
  }
}

abstract class _WishlistResponse implements WishlistResponse {
  const factory _WishlistResponse(
      {required final String message,
      required final String productId,
      final String? error}) = _$WishlistResponseImpl;

  factory _WishlistResponse.fromJson(Map<String, dynamic> json) =
      _$WishlistResponseImpl.fromJson;

  @override
  String get message;
  @override
  String get productId;
  @override
  String? get error;

  /// Create a copy of WishlistResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishlistResponseImplCopyWith<_$WishlistResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
