// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filter_products_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProductsFilterState _$ProductsFilterStateFromJson(Map<String, dynamic> json) {
  return _ProductsFilterState.fromJson(json);
}

/// @nodoc
mixin _$ProductsFilterState {
  String? get categoryId => throw _privateConstructorUsedError;
  double get minPrice => throw _privateConstructorUsedError;
  double get maxPrice => throw _privateConstructorUsedError;
  String? get brandId => throw _privateConstructorUsedError;
  double get minRating => throw _privateConstructorUsedError;
  bool get showNewArrivals => throw _privateConstructorUsedError;
  bool get showBestsellers => throw _privateConstructorUsedError;

  /// Serializes this ProductsFilterState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductsFilterStateCopyWith<ProductsFilterState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductsFilterStateCopyWith<$Res> {
  factory $ProductsFilterStateCopyWith(
          ProductsFilterState value, $Res Function(ProductsFilterState) then) =
      _$ProductsFilterStateCopyWithImpl<$Res, ProductsFilterState>;
  @useResult
  $Res call(
      {String? categoryId,
      double minPrice,
      double maxPrice,
      String? brandId,
      double minRating,
      bool showNewArrivals,
      bool showBestsellers});
}

/// @nodoc
class _$ProductsFilterStateCopyWithImpl<$Res, $Val extends ProductsFilterState>
    implements $ProductsFilterStateCopyWith<$Res> {
  _$ProductsFilterStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? brandId = freezed,
    Object? minRating = null,
    Object? showNewArrivals = null,
    Object? showBestsellers = null,
  }) {
    return _then(_value.copyWith(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double,
      maxPrice: null == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double,
      brandId: freezed == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as String?,
      minRating: null == minRating
          ? _value.minRating
          : minRating // ignore: cast_nullable_to_non_nullable
              as double,
      showNewArrivals: null == showNewArrivals
          ? _value.showNewArrivals
          : showNewArrivals // ignore: cast_nullable_to_non_nullable
              as bool,
      showBestsellers: null == showBestsellers
          ? _value.showBestsellers
          : showBestsellers // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProductsFilterStateImplCopyWith<$Res>
    implements $ProductsFilterStateCopyWith<$Res> {
  factory _$$ProductsFilterStateImplCopyWith(_$ProductsFilterStateImpl value,
          $Res Function(_$ProductsFilterStateImpl) then) =
      __$$ProductsFilterStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? categoryId,
      double minPrice,
      double maxPrice,
      String? brandId,
      double minRating,
      bool showNewArrivals,
      bool showBestsellers});
}

/// @nodoc
class __$$ProductsFilterStateImplCopyWithImpl<$Res>
    extends _$ProductsFilterStateCopyWithImpl<$Res, _$ProductsFilterStateImpl>
    implements _$$ProductsFilterStateImplCopyWith<$Res> {
  __$$ProductsFilterStateImplCopyWithImpl(_$ProductsFilterStateImpl _value,
      $Res Function(_$ProductsFilterStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ProductsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryId = freezed,
    Object? minPrice = null,
    Object? maxPrice = null,
    Object? brandId = freezed,
    Object? minRating = null,
    Object? showNewArrivals = null,
    Object? showBestsellers = null,
  }) {
    return _then(_$ProductsFilterStateImpl(
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as String?,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as double,
      maxPrice: null == maxPrice
          ? _value.maxPrice
          : maxPrice // ignore: cast_nullable_to_non_nullable
              as double,
      brandId: freezed == brandId
          ? _value.brandId
          : brandId // ignore: cast_nullable_to_non_nullable
              as String?,
      minRating: null == minRating
          ? _value.minRating
          : minRating // ignore: cast_nullable_to_non_nullable
              as double,
      showNewArrivals: null == showNewArrivals
          ? _value.showNewArrivals
          : showNewArrivals // ignore: cast_nullable_to_non_nullable
              as bool,
      showBestsellers: null == showBestsellers
          ? _value.showBestsellers
          : showBestsellers // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductsFilterStateImpl implements _ProductsFilterState {
  const _$ProductsFilterStateImpl(
      {this.categoryId,
      this.minPrice = 0.0,
      this.maxPrice = double.infinity,
      this.brandId,
      this.minRating = 0.0,
      this.showNewArrivals = false,
      this.showBestsellers = false});

  factory _$ProductsFilterStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductsFilterStateImplFromJson(json);

  @override
  final String? categoryId;
  @override
  @JsonKey()
  final double minPrice;
  @override
  @JsonKey()
  final double maxPrice;
  @override
  final String? brandId;
  @override
  @JsonKey()
  final double minRating;
  @override
  @JsonKey()
  final bool showNewArrivals;
  @override
  @JsonKey()
  final bool showBestsellers;

  @override
  String toString() {
    return 'ProductsFilterState(categoryId: $categoryId, minPrice: $minPrice, maxPrice: $maxPrice, brandId: $brandId, minRating: $minRating, showNewArrivals: $showNewArrivals, showBestsellers: $showBestsellers)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductsFilterStateImpl &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice) &&
            (identical(other.maxPrice, maxPrice) ||
                other.maxPrice == maxPrice) &&
            (identical(other.brandId, brandId) || other.brandId == brandId) &&
            (identical(other.minRating, minRating) ||
                other.minRating == minRating) &&
            (identical(other.showNewArrivals, showNewArrivals) ||
                other.showNewArrivals == showNewArrivals) &&
            (identical(other.showBestsellers, showBestsellers) ||
                other.showBestsellers == showBestsellers));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, categoryId, minPrice, maxPrice,
      brandId, minRating, showNewArrivals, showBestsellers);

  /// Create a copy of ProductsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductsFilterStateImplCopyWith<_$ProductsFilterStateImpl> get copyWith =>
      __$$ProductsFilterStateImplCopyWithImpl<_$ProductsFilterStateImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductsFilterStateImplToJson(
      this,
    );
  }
}

abstract class _ProductsFilterState implements ProductsFilterState {
  const factory _ProductsFilterState(
      {final String? categoryId,
      final double minPrice,
      final double maxPrice,
      final String? brandId,
      final double minRating,
      final bool showNewArrivals,
      final bool showBestsellers}) = _$ProductsFilterStateImpl;

  factory _ProductsFilterState.fromJson(Map<String, dynamic> json) =
      _$ProductsFilterStateImpl.fromJson;

  @override
  String? get categoryId;
  @override
  double get minPrice;
  @override
  double get maxPrice;
  @override
  String? get brandId;
  @override
  double get minRating;
  @override
  bool get showNewArrivals;
  @override
  bool get showBestsellers;

  /// Create a copy of ProductsFilterState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductsFilterStateImplCopyWith<_$ProductsFilterStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
