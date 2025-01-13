// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceRatingResponse _$ServiceRatingResponseFromJson(
    Map<String, dynamic> json) {
  return _ServiceRatingResponse.fromJson(json);
}

/// @nodoc
mixin _$ServiceRatingResponse {
  String? get error => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this ServiceRatingResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceRatingResponseCopyWith<ServiceRatingResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRatingResponseCopyWith<$Res> {
  factory $ServiceRatingResponseCopyWith(ServiceRatingResponse value,
          $Res Function(ServiceRatingResponse) then) =
      _$ServiceRatingResponseCopyWithImpl<$Res, ServiceRatingResponse>;
  @useResult
  $Res call({String? error, String? message});
}

/// @nodoc
class _$ServiceRatingResponseCopyWithImpl<$Res,
        $Val extends ServiceRatingResponse>
    implements $ServiceRatingResponseCopyWith<$Res> {
  _$ServiceRatingResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceRatingResponseImplCopyWith<$Res>
    implements $ServiceRatingResponseCopyWith<$Res> {
  factory _$$ServiceRatingResponseImplCopyWith(
          _$ServiceRatingResponseImpl value,
          $Res Function(_$ServiceRatingResponseImpl) then) =
      __$$ServiceRatingResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? error, String? message});
}

/// @nodoc
class __$$ServiceRatingResponseImplCopyWithImpl<$Res>
    extends _$ServiceRatingResponseCopyWithImpl<$Res,
        _$ServiceRatingResponseImpl>
    implements _$$ServiceRatingResponseImplCopyWith<$Res> {
  __$$ServiceRatingResponseImplCopyWithImpl(_$ServiceRatingResponseImpl _value,
      $Res Function(_$ServiceRatingResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = freezed,
    Object? message = freezed,
  }) {
    return _then(_$ServiceRatingResponseImpl(
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceRatingResponseImpl implements _ServiceRatingResponse {
  const _$ServiceRatingResponseImpl({this.error, this.message});

  factory _$ServiceRatingResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRatingResponseImplFromJson(json);

  @override
  final String? error;
  @override
  final String? message;

  @override
  String toString() {
    return 'ServiceRatingResponse(error: $error, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRatingResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  /// Create a copy of ServiceRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceRatingResponseImplCopyWith<_$ServiceRatingResponseImpl>
      get copyWith => __$$ServiceRatingResponseImplCopyWithImpl<
          _$ServiceRatingResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceRatingResponseImplToJson(
      this,
    );
  }
}

abstract class _ServiceRatingResponse implements ServiceRatingResponse {
  const factory _ServiceRatingResponse(
      {final String? error,
      final String? message}) = _$ServiceRatingResponseImpl;

  factory _ServiceRatingResponse.fromJson(Map<String, dynamic> json) =
      _$ServiceRatingResponseImpl.fromJson;

  @override
  String? get error;
  @override
  String? get message;

  /// Create a copy of ServiceRatingResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceRatingResponseImplCopyWith<_$ServiceRatingResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
