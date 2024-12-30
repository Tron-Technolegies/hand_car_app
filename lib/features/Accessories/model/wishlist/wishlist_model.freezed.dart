// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist_model.dart';

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
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_name')
  String get productName => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
  double get productPrice => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_image')
  String? get productImage => throw _privateConstructorUsedError;
  @JsonKey(name: 'product_description')
  String? get productDescription => throw _privateConstructorUsedError;

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
  $Res call(
      {int id,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
      double productPrice,
      @JsonKey(name: 'product_image') String? productImage,
      @JsonKey(name: 'product_description') String? productDescription});
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
    Object? id = null,
    Object? productName = null,
    Object? productPrice = null,
    Object? productImage = freezed,
    Object? productDescription = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productPrice: null == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double,
      productImage: freezed == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String?,
      productDescription: freezed == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
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
  $Res call(
      {int id,
      @JsonKey(name: 'product_name') String productName,
      @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
      double productPrice,
      @JsonKey(name: 'product_image') String? productImage,
      @JsonKey(name: 'product_description') String? productDescription});
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
    Object? id = null,
    Object? productName = null,
    Object? productPrice = null,
    Object? productImage = freezed,
    Object? productDescription = freezed,
  }) {
    return _then(_$WishlistResponseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      productName: null == productName
          ? _value.productName
          : productName // ignore: cast_nullable_to_non_nullable
              as String,
      productPrice: null == productPrice
          ? _value.productPrice
          : productPrice // ignore: cast_nullable_to_non_nullable
              as double,
      productImage: freezed == productImage
          ? _value.productImage
          : productImage // ignore: cast_nullable_to_non_nullable
              as String?,
      productDescription: freezed == productDescription
          ? _value.productDescription
          : productDescription // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WishlistResponseImpl implements _WishlistResponse {
  const _$WishlistResponseImpl(
      {required this.id,
      @JsonKey(name: 'product_name') required this.productName,
      @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
      required this.productPrice,
      @JsonKey(name: 'product_image') this.productImage,
      @JsonKey(name: 'product_description') this.productDescription});

  factory _$WishlistResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishlistResponseImplFromJson(json);

  @override
  final int id;
  @override
  @JsonKey(name: 'product_name')
  final String productName;
  @override
  @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
  final double productPrice;
  @override
  @JsonKey(name: 'product_image')
  final String? productImage;
  @override
  @JsonKey(name: 'product_description')
  final String? productDescription;

  @override
  String toString() {
    return 'WishlistResponse(id: $id, productName: $productName, productPrice: $productPrice, productImage: $productImage, productDescription: $productDescription)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistResponseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.productName, productName) ||
                other.productName == productName) &&
            (identical(other.productPrice, productPrice) ||
                other.productPrice == productPrice) &&
            (identical(other.productImage, productImage) ||
                other.productImage == productImage) &&
            (identical(other.productDescription, productDescription) ||
                other.productDescription == productDescription));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, productName, productPrice,
      productImage, productDescription);

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
      {required final int id,
      @JsonKey(name: 'product_name') required final String productName,
      @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
      required final double productPrice,
      @JsonKey(name: 'product_image') final String? productImage,
      @JsonKey(name: 'product_description')
      final String? productDescription}) = _$WishlistResponseImpl;

  factory _WishlistResponse.fromJson(Map<String, dynamic> json) =
      _$WishlistResponseImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(name: 'product_name')
  String get productName;
  @override
  @JsonKey(name: 'product_price', fromJson: WishlistResponse._priceFromJson)
  double get productPrice;
  @override
  @JsonKey(name: 'product_image')
  String? get productImage;
  @override
  @JsonKey(name: 'product_description')
  String? get productDescription;

  /// Create a copy of WishlistResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WishlistResponseImplCopyWith<_$WishlistResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
