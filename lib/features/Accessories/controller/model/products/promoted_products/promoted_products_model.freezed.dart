// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promoted_products_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PromotedProductsModel _$PromotedProductsModelFromJson(
    Map<String, dynamic> json) {
  return _PromotedProductsModel.fromJson(json);
}

/// @nodoc
mixin _$PromotedProductsModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_bestseller')
  bool get isBestseller => throw _privateConstructorUsedError;
  @JsonKey(name: 'discount_percentage')
  int get discountPercentage => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this PromotedProductsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromotedProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotedProductsModelCopyWith<PromotedProductsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotedProductsModelCopyWith<$Res> {
  factory $PromotedProductsModelCopyWith(PromotedProductsModel value,
          $Res Function(PromotedProductsModel) then) =
      _$PromotedProductsModelCopyWithImpl<$Res, PromotedProductsModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String category,
      String brand,
      String price,
      String description,
      @JsonKey(name: 'is_bestseller') bool isBestseller,
      @JsonKey(name: 'discount_percentage') int discountPercentage,
      String? image,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$PromotedProductsModelCopyWithImpl<$Res,
        $Val extends PromotedProductsModel>
    implements $PromotedProductsModelCopyWith<$Res> {
  _$PromotedProductsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromotedProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? brand = null,
    Object? price = null,
    Object? description = null,
    Object? isBestseller = null,
    Object? discountPercentage = null,
    Object? image = freezed,
    Object? createdAt = null,
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
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isBestseller: null == isBestseller
          ? _value.isBestseller
          : isBestseller // ignore: cast_nullable_to_non_nullable
              as bool,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromotedProductsModelImplCopyWith<$Res>
    implements $PromotedProductsModelCopyWith<$Res> {
  factory _$$PromotedProductsModelImplCopyWith(
          _$PromotedProductsModelImpl value,
          $Res Function(_$PromotedProductsModelImpl) then) =
      __$$PromotedProductsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String category,
      String brand,
      String price,
      String description,
      @JsonKey(name: 'is_bestseller') bool isBestseller,
      @JsonKey(name: 'discount_percentage') int discountPercentage,
      String? image,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$PromotedProductsModelImplCopyWithImpl<$Res>
    extends _$PromotedProductsModelCopyWithImpl<$Res,
        _$PromotedProductsModelImpl>
    implements _$$PromotedProductsModelImplCopyWith<$Res> {
  __$$PromotedProductsModelImplCopyWithImpl(_$PromotedProductsModelImpl _value,
      $Res Function(_$PromotedProductsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PromotedProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? brand = null,
    Object? price = null,
    Object? description = null,
    Object? isBestseller = null,
    Object? discountPercentage = null,
    Object? image = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$PromotedProductsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      brand: null == brand
          ? _value.brand
          : brand // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isBestseller: null == isBestseller
          ? _value.isBestseller
          : isBestseller // ignore: cast_nullable_to_non_nullable
              as bool,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotedProductsModelImpl implements _PromotedProductsModel {
  const _$PromotedProductsModelImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.brand,
      required this.price,
      required this.description,
      @JsonKey(name: 'is_bestseller') required this.isBestseller,
      @JsonKey(name: 'discount_percentage') required this.discountPercentage,
      this.image,
      @JsonKey(name: 'created_at') required this.createdAt});

  factory _$PromotedProductsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotedProductsModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String brand;
  @override
  final String price;
  @override
  final String description;
  @override
  @JsonKey(name: 'is_bestseller')
  final bool isBestseller;
  @override
  @JsonKey(name: 'discount_percentage')
  final int discountPercentage;
  @override
  final String? image;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'PromotedProductsModel(id: $id, name: $name, category: $category, brand: $brand, price: $price, description: $description, isBestseller: $isBestseller, discountPercentage: $discountPercentage, image: $image, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotedProductsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isBestseller, isBestseller) ||
                other.isBestseller == isBestseller) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, category, brand, price,
      description, isBestseller, discountPercentage, image, createdAt);

  /// Create a copy of PromotedProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotedProductsModelImplCopyWith<_$PromotedProductsModelImpl>
      get copyWith => __$$PromotedProductsModelImplCopyWithImpl<
          _$PromotedProductsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotedProductsModelImplToJson(
      this,
    );
  }
}

abstract class _PromotedProductsModel implements PromotedProductsModel {
  const factory _PromotedProductsModel(
          {required final int id,
          required final String name,
          required final String category,
          required final String brand,
          required final String price,
          required final String description,
          @JsonKey(name: 'is_bestseller') required final bool isBestseller,
          @JsonKey(name: 'discount_percentage')
          required final int discountPercentage,
          final String? image,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$PromotedProductsModelImpl;

  factory _PromotedProductsModel.fromJson(Map<String, dynamic> json) =
      _$PromotedProductsModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get brand;
  @override
  String get price;
  @override
  String get description;
  @override
  @JsonKey(name: 'is_bestseller')
  bool get isBestseller;
  @override
  @JsonKey(name: 'discount_percentage')
  int get discountPercentage;
  @override
  String? get image;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of PromotedProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotedProductsModelImplCopyWith<_$PromotedProductsModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
