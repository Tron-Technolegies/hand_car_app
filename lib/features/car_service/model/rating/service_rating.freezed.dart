// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ServiceRating _$ServiceRatingFromJson(Map<String, dynamic> json) {
  return _ServiceRating.fromJson(json);
}

/// @nodoc
mixin _$ServiceRating {
  double get rating => throw _privateConstructorUsedError;

  /// Serializes this ServiceRating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceRatingCopyWith<ServiceRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRatingCopyWith<$Res> {
  factory $ServiceRatingCopyWith(
          ServiceRating value, $Res Function(ServiceRating) then) =
      _$ServiceRatingCopyWithImpl<$Res, ServiceRating>;
  @useResult
  $Res call({double rating});
}

/// @nodoc
class _$ServiceRatingCopyWithImpl<$Res, $Val extends ServiceRating>
    implements $ServiceRatingCopyWith<$Res> {
  _$ServiceRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceRating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
  }) {
    return _then(_value.copyWith(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceRatingImplCopyWith<$Res>
    implements $ServiceRatingCopyWith<$Res> {
  factory _$$ServiceRatingImplCopyWith(
          _$ServiceRatingImpl value, $Res Function(_$ServiceRatingImpl) then) =
      __$$ServiceRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double rating});
}

/// @nodoc
class __$$ServiceRatingImplCopyWithImpl<$Res>
    extends _$ServiceRatingCopyWithImpl<$Res, _$ServiceRatingImpl>
    implements _$$ServiceRatingImplCopyWith<$Res> {
  __$$ServiceRatingImplCopyWithImpl(
      _$ServiceRatingImpl _value, $Res Function(_$ServiceRatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceRating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rating = null,
  }) {
    return _then(_$ServiceRatingImpl(
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceRatingImpl implements _ServiceRating {
  const _$ServiceRatingImpl({required this.rating});

  factory _$ServiceRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRatingImplFromJson(json);

  @override
  final double rating;

  @override
  String toString() {
    return 'ServiceRating(rating: $rating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRatingImpl &&
            (identical(other.rating, rating) || other.rating == rating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, rating);

  /// Create a copy of ServiceRating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceRatingImplCopyWith<_$ServiceRatingImpl> get copyWith =>
      __$$ServiceRatingImplCopyWithImpl<_$ServiceRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceRatingImplToJson(
      this,
    );
  }
}

abstract class _ServiceRating implements ServiceRating {
  const factory _ServiceRating({required final double rating}) =
      _$ServiceRatingImpl;

  factory _ServiceRating.fromJson(Map<String, dynamic> json) =
      _$ServiceRatingImpl.fromJson;

  @override
  double get rating;

  /// Create a copy of ServiceRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceRatingImplCopyWith<_$ServiceRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
