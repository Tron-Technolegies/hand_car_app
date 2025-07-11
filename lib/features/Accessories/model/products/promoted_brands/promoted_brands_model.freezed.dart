// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promoted_brands_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PromotedBrandProductModel _$PromotedBrandProductModelFromJson(
    Map<String, dynamic> json) {
  return _PromotedBrandProductModel.fromJson(json);
}

/// @nodoc
mixin _$PromotedBrandProductModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: "original_price")
  double get originalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: "discounted_price")
  double get discountedPrice => throw _privateConstructorUsedError;
  @JsonKey(name: "discount_percentage")
  int get discountPercentage => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;

  /// Serializes this PromotedBrandProductModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromotedBrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotedBrandProductModelCopyWith<PromotedBrandProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotedBrandProductModelCopyWith<$Res> {
  factory $PromotedBrandProductModelCopyWith(PromotedBrandProductModel value,
          $Res Function(PromotedBrandProductModel) then) =
      _$PromotedBrandProductModelCopyWithImpl<$Res, PromotedBrandProductModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: "original_price") double originalPrice,
      @JsonKey(name: "discounted_price") double discountedPrice,
      @JsonKey(name: "discount_percentage") int discountPercentage,
      String? image});
}

/// @nodoc
class _$PromotedBrandProductModelCopyWithImpl<$Res,
        $Val extends PromotedBrandProductModel>
    implements $PromotedBrandProductModelCopyWith<$Res> {
  _$PromotedBrandProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromotedBrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? originalPrice = null,
    Object? discountedPrice = null,
    Object? discountPercentage = null,
    Object? image = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discountedPrice: null == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromotedBrandProductModelImplCopyWith<$Res>
    implements $PromotedBrandProductModelCopyWith<$Res> {
  factory _$$PromotedBrandProductModelImplCopyWith(
          _$PromotedBrandProductModelImpl value,
          $Res Function(_$PromotedBrandProductModelImpl) then) =
      __$$PromotedBrandProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: "original_price") double originalPrice,
      @JsonKey(name: "discounted_price") double discountedPrice,
      @JsonKey(name: "discount_percentage") int discountPercentage,
      String? image});
}

/// @nodoc
class __$$PromotedBrandProductModelImplCopyWithImpl<$Res>
    extends _$PromotedBrandProductModelCopyWithImpl<$Res,
        _$PromotedBrandProductModelImpl>
    implements _$$PromotedBrandProductModelImplCopyWith<$Res> {
  __$$PromotedBrandProductModelImplCopyWithImpl(
      _$PromotedBrandProductModelImpl _value,
      $Res Function(_$PromotedBrandProductModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PromotedBrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? originalPrice = null,
    Object? discountedPrice = null,
    Object? discountPercentage = null,
    Object? image = freezed,
  }) {
    return _then(_$PromotedBrandProductModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discountedPrice: null == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotedBrandProductModelImpl implements _PromotedBrandProductModel {
  const _$PromotedBrandProductModelImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: "original_price") required this.originalPrice,
      @JsonKey(name: "discounted_price") required this.discountedPrice,
      @JsonKey(name: "discount_percentage") required this.discountPercentage,
      this.image});

  factory _$PromotedBrandProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotedBrandProductModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: "original_price")
  final double originalPrice;
  @override
  @JsonKey(name: "discounted_price")
  final double discountedPrice;
  @override
  @JsonKey(name: "discount_percentage")
  final int discountPercentage;
  @override
  final String? image;

  @override
  String toString() {
    return 'PromotedBrandProductModel(id: $id, name: $name, originalPrice: $originalPrice, discountedPrice: $discountedPrice, discountPercentage: $discountPercentage, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotedBrandProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountedPrice, discountedPrice) ||
                other.discountedPrice == discountedPrice) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, originalPrice,
      discountedPrice, discountPercentage, image);

  /// Create a copy of PromotedBrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotedBrandProductModelImplCopyWith<_$PromotedBrandProductModelImpl>
      get copyWith => __$$PromotedBrandProductModelImplCopyWithImpl<
          _$PromotedBrandProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotedBrandProductModelImplToJson(
      this,
    );
  }
}

abstract class _PromotedBrandProductModel implements PromotedBrandProductModel {
  const factory _PromotedBrandProductModel(
      {required final int id,
      required final String name,
      @JsonKey(name: "original_price") required final double originalPrice,
      @JsonKey(name: "discounted_price") required final double discountedPrice,
      @JsonKey(name: "discount_percentage")
      required final int discountPercentage,
      final String? image}) = _$PromotedBrandProductModelImpl;

  factory _PromotedBrandProductModel.fromJson(Map<String, dynamic> json) =
      _$PromotedBrandProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: "original_price")
  double get originalPrice;
  @override
  @JsonKey(name: "discounted_price")
  double get discountedPrice;
  @override
  @JsonKey(name: "discount_percentage")
  int get discountPercentage;
  @override
  String? get image;

  /// Create a copy of PromotedBrandProductModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotedBrandProductModelImplCopyWith<_$PromotedBrandProductModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
