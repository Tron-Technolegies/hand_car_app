// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'products_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductsModel _$ProductsModelFromJson(Map<String, dynamic> json) {
  return _ProductModel.fromJson(json);
}

/// @nodoc
mixin _$ProductsModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get brand => throw _privateConstructorUsedError;
  @JsonKey(name: "original_price")
  double get originalPrice => throw _privateConstructorUsedError;
  @JsonKey(name: "discounted_price")
  double get discountedPrice => throw _privateConstructorUsedError;
  String? get image => throw _privateConstructorUsedError;
  @JsonKey(name: "discount_percentage")
  int get discountPercentage => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: "is_bestseller")
  bool get isBestseller => throw _privateConstructorUsedError;
  @JsonKey(name: "average_rating")
  double get averageRating => throw _privateConstructorUsedError;
  @JsonKey(name: "total_reviews")
  int get totalReviews => throw _privateConstructorUsedError;

  /// Serializes this ProductsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsModelCopyWith<ProductsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsModelCopyWith<$Res> {
  factory $ProductsModelCopyWith(
          ProductsModel value, $Res Function(ProductsModel) then) =
      _$ProductsModelCopyWithImpl<$Res, ProductsModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      String category,
      String brand,
      @JsonKey(name: "original_price") double originalPrice,
      @JsonKey(name: "discounted_price") double discountedPrice,
      String? image,
      @JsonKey(name: "discount_percentage") int discountPercentage,
      String description,
      @JsonKey(name: "is_bestseller") bool isBestseller,
      @JsonKey(name: "average_rating") double averageRating,
      @JsonKey(name: "total_reviews") int totalReviews});
}

/// @nodoc
class _$ProductsModelCopyWithImpl<$Res, $Val extends ProductsModel>
    implements $ProductsModelCopyWith<$Res> {
  _$ProductsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? brand = null,
    Object? originalPrice = null,
    Object? discountedPrice = null,
    Object? image = freezed,
    Object? discountPercentage = null,
    Object? description = null,
    Object? isBestseller = null,
    Object? averageRating = null,
    Object? totalReviews = null,
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
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discountedPrice: null == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isBestseller: null == isBestseller
          ? _value.isBestseller
          : isBestseller // ignore: cast_nullable_to_non_nullable
              as bool,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductModelImplCopyWith<$Res>
    implements $ProductsModelCopyWith<$Res> {
  factory _$$ProductModelImplCopyWith(
          _$ProductModelImpl value, $Res Function(_$ProductModelImpl) then) =
      __$$ProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String category,
      String brand,
      @JsonKey(name: "original_price") double originalPrice,
      @JsonKey(name: "discounted_price") double discountedPrice,
      String? image,
      @JsonKey(name: "discount_percentage") int discountPercentage,
      String description,
      @JsonKey(name: "is_bestseller") bool isBestseller,
      @JsonKey(name: "average_rating") double averageRating,
      @JsonKey(name: "total_reviews") int totalReviews});
}

/// @nodoc
class __$$ProductModelImplCopyWithImpl<$Res>
    extends _$ProductsModelCopyWithImpl<$Res, _$ProductModelImpl>
    implements _$$ProductModelImplCopyWith<$Res> {
  __$$ProductModelImplCopyWithImpl(
      _$ProductModelImpl _value, $Res Function(_$ProductModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? category = null,
    Object? brand = null,
    Object? originalPrice = null,
    Object? discountedPrice = null,
    Object? image = freezed,
    Object? discountPercentage = null,
    Object? description = null,
    Object? isBestseller = null,
    Object? averageRating = null,
    Object? totalReviews = null,
  }) {
    return _then(_$ProductModelImpl(
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
      originalPrice: null == originalPrice
          ? _value.originalPrice
          : originalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      discountedPrice: null == discountedPrice
          ? _value.discountedPrice
          : discountedPrice // ignore: cast_nullable_to_non_nullable
              as double,
      image: freezed == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      discountPercentage: null == discountPercentage
          ? _value.discountPercentage
          : discountPercentage // ignore: cast_nullable_to_non_nullable
              as int,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      isBestseller: null == isBestseller
          ? _value.isBestseller
          : isBestseller // ignore: cast_nullable_to_non_nullable
              as bool,
      averageRating: null == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double,
      totalReviews: null == totalReviews
          ? _value.totalReviews
          : totalReviews // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductModelImpl implements _ProductModel {
  const _$ProductModelImpl(
      {required this.id,
      required this.name,
      required this.category,
      required this.brand,
      @JsonKey(name: "original_price") required this.originalPrice,
      @JsonKey(name: "discounted_price") required this.discountedPrice,
      this.image,
      @JsonKey(name: "discount_percentage") this.discountPercentage = 0,
      this.description = '',
      @JsonKey(name: "is_bestseller") this.isBestseller = false,
      @JsonKey(name: "average_rating") this.averageRating = 0.0,
      @JsonKey(name: "total_reviews") this.totalReviews = 0});

  factory _$ProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductModelImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String category;
  @override
  final String brand;
  @override
  @JsonKey(name: "original_price")
  final double originalPrice;
  @override
  @JsonKey(name: "discounted_price")
  final double discountedPrice;
  @override
  final String? image;
  @override
  @JsonKey(name: "discount_percentage")
  final int discountPercentage;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey(name: "is_bestseller")
  final bool isBestseller;
  @override
  @JsonKey(name: "average_rating")
  final double averageRating;
  @override
  @JsonKey(name: "total_reviews")
  final int totalReviews;

  @override
  String toString() {
    return 'ProductsModel(id: $id, name: $name, category: $category, brand: $brand, originalPrice: $originalPrice, discountedPrice: $discountedPrice, image: $image, discountPercentage: $discountPercentage, description: $description, isBestseller: $isBestseller, averageRating: $averageRating, totalReviews: $totalReviews)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.discountedPrice, discountedPrice) ||
                other.discountedPrice == discountedPrice) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.discountPercentage, discountPercentage) ||
                other.discountPercentage == discountPercentage) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.isBestseller, isBestseller) ||
                other.isBestseller == isBestseller) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalReviews, totalReviews) ||
                other.totalReviews == totalReviews));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      category,
      brand,
      originalPrice,
      discountedPrice,
      image,
      discountPercentage,
      description,
      isBestseller,
      averageRating,
      totalReviews);

  /// Create a copy of ProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      __$$ProductModelImplCopyWithImpl<_$ProductModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductModelImplToJson(
      this,
    );
  }
}

abstract class _ProductModel implements ProductsModel {
  const factory _ProductModel(
      {required final int id,
      required final String name,
      required final String category,
      required final String brand,
      @JsonKey(name: "original_price") required final double originalPrice,
      @JsonKey(name: "discounted_price") required final double discountedPrice,
      final String? image,
      @JsonKey(name: "discount_percentage") final int discountPercentage,
      final String description,
      @JsonKey(name: "is_bestseller") final bool isBestseller,
      @JsonKey(name: "average_rating") final double averageRating,
      @JsonKey(name: "total_reviews")
      final int totalReviews}) = _$ProductModelImpl;

  factory _ProductModel.fromJson(Map<String, dynamic> json) =
      _$ProductModelImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get category;
  @override
  String get brand;
  @override
  @JsonKey(name: "original_price")
  double get originalPrice;
  @override
  @JsonKey(name: "discounted_price")
  double get discountedPrice;
  @override
  String? get image;
  @override
  @JsonKey(name: "discount_percentage")
  int get discountPercentage;
  @override
  String get description;
  @override
  @JsonKey(name: "is_bestseller")
  bool get isBestseller;
  @override
  @JsonKey(name: "average_rating")
  double get averageRating;
  @override
  @JsonKey(name: "total_reviews")
  int get totalReviews;

  /// Create a copy of ProductsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductModelImplCopyWith<_$ProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
