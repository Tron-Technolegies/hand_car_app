// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReviewList _$ReviewListFromJson(Map<String, dynamic> json) {
  return _ReviewList.fromJson(json);
}

/// @nodoc
mixin _$ReviewList {
  List<ReviewModel> get reviews => throw _privateConstructorUsedError;

  /// Serializes this ReviewList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReviewList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReviewListCopyWith<ReviewList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReviewListCopyWith<$Res> {
  factory $ReviewListCopyWith(
          ReviewList value, $Res Function(ReviewList) then) =
      _$ReviewListCopyWithImpl<$Res, ReviewList>;
  @useResult
  $Res call({List<ReviewModel> reviews});
}

/// @nodoc
class _$ReviewListCopyWithImpl<$Res, $Val extends ReviewList>
    implements $ReviewListCopyWith<$Res> {
  _$ReviewListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReviewList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
  }) {
    return _then(_value.copyWith(
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReviewListImplCopyWith<$Res>
    implements $ReviewListCopyWith<$Res> {
  factory _$$ReviewListImplCopyWith(
          _$ReviewListImpl value, $Res Function(_$ReviewListImpl) then) =
      __$$ReviewListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ReviewModel> reviews});
}

/// @nodoc
class __$$ReviewListImplCopyWithImpl<$Res>
    extends _$ReviewListCopyWithImpl<$Res, _$ReviewListImpl>
    implements _$$ReviewListImplCopyWith<$Res> {
  __$$ReviewListImplCopyWithImpl(
      _$ReviewListImpl _value, $Res Function(_$ReviewListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReviewList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reviews = null,
  }) {
    return _then(_$ReviewListImpl(
      reviews: null == reviews
          ? _value.reviews
          : reviews // ignore: cast_nullable_to_non_nullable
              as List<ReviewModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReviewListImpl implements _ReviewList {
  const _$ReviewListImpl({required this.reviews});

  factory _$ReviewListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReviewListImplFromJson(json);

  @override
  final List<ReviewModel> reviews;

  @override
  String toString() {
    return 'ReviewList(reviews: $reviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReviewListImpl &&
            const DeepCollectionEquality().equals(other.reviews, reviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(reviews));

  /// Create a copy of ReviewList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReviewListImplCopyWith<_$ReviewListImpl> get copyWith =>
      __$$ReviewListImplCopyWithImpl<_$ReviewListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReviewListImplToJson(
      this,
    );
  }
}

abstract class _ReviewList implements ReviewList {
  const factory _ReviewList({required final List<ReviewModel> reviews}) =
      _$ReviewListImpl;

  factory _ReviewList.fromJson(Map<String, dynamic> json) =
      _$ReviewListImpl.fromJson;

  @override
  List<ReviewModel> get reviews;

  /// Create a copy of ReviewList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReviewListImplCopyWith<_$ReviewListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
