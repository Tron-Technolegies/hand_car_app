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

ServiceRatingList _$ServiceRatingListFromJson(Map<String, dynamic> json) {
  return _ServiceRatingList.fromJson(json);
}

/// @nodoc
mixin _$ServiceRatingList {
  @JsonKey(name: 'Ratings')
  List<ServiceRating> get ratings => throw _privateConstructorUsedError;

  /// Serializes this ServiceRatingList to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ServiceRatingList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ServiceRatingListCopyWith<ServiceRatingList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ServiceRatingListCopyWith<$Res> {
  factory $ServiceRatingListCopyWith(
          ServiceRatingList value, $Res Function(ServiceRatingList) then) =
      _$ServiceRatingListCopyWithImpl<$Res, ServiceRatingList>;
  @useResult
  $Res call({@JsonKey(name: 'Ratings') List<ServiceRating> ratings});
}

/// @nodoc
class _$ServiceRatingListCopyWithImpl<$Res, $Val extends ServiceRatingList>
    implements $ServiceRatingListCopyWith<$Res> {
  _$ServiceRatingListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ServiceRatingList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_value.copyWith(
      ratings: null == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<ServiceRating>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ServiceRatingListImplCopyWith<$Res>
    implements $ServiceRatingListCopyWith<$Res> {
  factory _$$ServiceRatingListImplCopyWith(_$ServiceRatingListImpl value,
          $Res Function(_$ServiceRatingListImpl) then) =
      __$$ServiceRatingListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'Ratings') List<ServiceRating> ratings});
}

/// @nodoc
class __$$ServiceRatingListImplCopyWithImpl<$Res>
    extends _$ServiceRatingListCopyWithImpl<$Res, _$ServiceRatingListImpl>
    implements _$$ServiceRatingListImplCopyWith<$Res> {
  __$$ServiceRatingListImplCopyWithImpl(_$ServiceRatingListImpl _value,
      $Res Function(_$ServiceRatingListImpl) _then)
      : super(_value, _then);

  /// Create a copy of ServiceRatingList
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ratings = null,
  }) {
    return _then(_$ServiceRatingListImpl(
      ratings: null == ratings
          ? _value.ratings
          : ratings // ignore: cast_nullable_to_non_nullable
              as List<ServiceRating>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ServiceRatingListImpl implements _ServiceRatingList {
  const _$ServiceRatingListImpl(
      {@JsonKey(name: 'Ratings') required this.ratings});

  factory _$ServiceRatingListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRatingListImplFromJson(json);

  @override
  @JsonKey(name: 'Ratings')
  final List<ServiceRating> ratings;

  @override
  String toString() {
    return 'ServiceRatingList(ratings: $ratings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRatingListImpl &&
            const DeepCollectionEquality().equals(other.ratings, ratings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(ratings));

  /// Create a copy of ServiceRatingList
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ServiceRatingListImplCopyWith<_$ServiceRatingListImpl> get copyWith =>
      __$$ServiceRatingListImplCopyWithImpl<_$ServiceRatingListImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ServiceRatingListImplToJson(
      this,
    );
  }
}

abstract class _ServiceRatingList implements ServiceRatingList {
  const factory _ServiceRatingList(
      {@JsonKey(name: 'Ratings')
      required final List<ServiceRating> ratings}) = _$ServiceRatingListImpl;

  factory _ServiceRatingList.fromJson(Map<String, dynamic> json) =
      _$ServiceRatingListImpl.fromJson;

  @override
  @JsonKey(name: 'Ratings')
  List<ServiceRating> get ratings;

  /// Create a copy of ServiceRatingList
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceRatingListImplCopyWith<_$ServiceRatingListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ServiceRating _$ServiceRatingFromJson(Map<String, dynamic> json) {
  return _ServiceRating.fromJson(json);
}

/// @nodoc
mixin _$ServiceRating {
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'vendor_name')
  String get vendorName => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  int get rating => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      @JsonKey(name: 'vendor_name') String vendorName,
      String username,
      int rating,
      String? comment});
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
    Object? id = null,
    Object? vendorName = null,
    Object? username = null,
    Object? rating = null,
    Object? comment = freezed,
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
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
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
abstract class _$$ServiceRatingImplCopyWith<$Res>
    implements $ServiceRatingCopyWith<$Res> {
  factory _$$ServiceRatingImplCopyWith(
          _$ServiceRatingImpl value, $Res Function(_$ServiceRatingImpl) then) =
      __$$ServiceRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      @JsonKey(name: 'vendor_name') String vendorName,
      String username,
      int rating,
      String? comment});
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
    Object? id = null,
    Object? vendorName = null,
    Object? username = null,
    Object? rating = null,
    Object? comment = freezed,
  }) {
    return _then(_$ServiceRatingImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      vendorName: null == vendorName
          ? _value.vendorName
          : vendorName // ignore: cast_nullable_to_non_nullable
              as String,
      username: null == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
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
class _$ServiceRatingImpl implements _ServiceRating {
  const _$ServiceRatingImpl(
      {required this.id,
      @JsonKey(name: 'vendor_name') required this.vendorName,
      required this.username,
      required this.rating,
      this.comment});

  factory _$ServiceRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ServiceRatingImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'vendor_name')
  final String vendorName;
  @override
  final String username;
  @override
  final int rating;
  @override
  final String? comment;

  @override
  String toString() {
    return 'ServiceRating(id: $id, vendorName: $vendorName, username: $username, rating: $rating, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ServiceRatingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.vendorName, vendorName) ||
                other.vendorName == vendorName) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, vendorName, username, rating, comment);

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
  const factory _ServiceRating(
      {required final int id,
      @JsonKey(name: 'vendor_name') required final String vendorName,
      required final String username,
      required final int rating,
      final String? comment}) = _$ServiceRatingImpl;

  factory _ServiceRating.fromJson(Map<String, dynamic> json) =
      _$ServiceRatingImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'vendor_name')
  String get vendorName;
  @override
  String get username;
  @override
  int get rating;
  @override
  String? get comment;

  /// Create a copy of ServiceRating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ServiceRatingImplCopyWith<_$ServiceRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
