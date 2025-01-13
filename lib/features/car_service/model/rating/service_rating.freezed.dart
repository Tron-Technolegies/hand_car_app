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

ServiceRatingModel _$ServiceRatingModelFromJson(Map<String, dynamic> json) {
  return _ServiceRatingModel.fromJson(json);
}

/// @nodoc
mixin _$ServiceRatingModel {
  String get serviceId => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  /// Serializes this ServiceRatingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceRatingModelCopyWith<ServiceRatingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRatingModelCopyWith<$Res> {
  factory $ServiceRatingModelCopyWith(
          ServiceRatingModel value, $Res Function(ServiceRatingModel) then) =
      _$ServiceRatingModelCopyWithImpl<$Res, ServiceRatingModel>;
  @useResult
  $Res call({String serviceId, int rating, String? comment});
}

/// @nodoc
class _$ServiceRatingModelCopyWithImpl<$Res, $Val extends ServiceRatingModel>
    implements $ServiceRatingModelCopyWith<$Res> {
  _$ServiceRatingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? rating = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceRatingModelImplCopyWith<$Res>
    implements $ServiceRatingModelCopyWith<$Res> {
  factory _$$ServiceRatingModelImplCopyWith(_$ServiceRatingModelImpl value,
          $Res Function(_$ServiceRatingModelImpl) then) =
      __$$ServiceRatingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String serviceId, int rating, String? comment});
}

/// @nodoc
class __$$ServiceRatingModelImplCopyWithImpl<$Res>
    extends _$ServiceRatingModelCopyWithImpl<$Res, _$ServiceRatingModelImpl>
    implements _$$ServiceRatingModelImplCopyWith<$Res> {
  __$$ServiceRatingModelImplCopyWithImpl(_$ServiceRatingModelImpl _value,
      $Res Function(_$ServiceRatingModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? serviceId = null,
    Object? rating = null,
    Object? comment = freezed,
  }) {
    return _then(_$ServiceRatingModelImpl(
      serviceId: null == serviceId
          ? _value.serviceId
          : serviceId // ignore: cast_nullable_to_non_nullable
              as String,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as int,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceRatingModelImpl implements _ServiceRatingModel {
  const _$ServiceRatingModelImpl(
      {required this.serviceId, required this.rating, this.comment});

  factory _$ServiceRatingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRatingModelImplFromJson(json);

  @override
  final String serviceId;
  @override
  final int rating;
  @override
  final String? comment;

  @override
  String toString() {
    return 'ServiceRatingModel(serviceId: $serviceId, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRatingModelImpl &&
            (identical(other.serviceId, serviceId) ||
                other.serviceId == serviceId) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, serviceId, rating, comment);

  /// Create a copy of ServiceRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceRatingModelImplCopyWith<_$ServiceRatingModelImpl> get copyWith =>
      __$$ServiceRatingModelImplCopyWithImpl<_$ServiceRatingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceRatingModelImplToJson(
      this,
    );
  }
}

abstract class _ServiceRatingModel implements ServiceRatingModel {
  const factory _ServiceRatingModel(
      {required final String serviceId,
      required final int rating,
      final String? comment}) = _$ServiceRatingModelImpl;

  factory _ServiceRatingModel.fromJson(Map<String, dynamic> json) =
      _$ServiceRatingModelImpl.fromJson;

  @override
  String get serviceId;
  @override
  int get rating;
  @override
  String? get comment;

  /// Create a copy of ServiceRatingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceRatingModelImplCopyWith<_$ServiceRatingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
