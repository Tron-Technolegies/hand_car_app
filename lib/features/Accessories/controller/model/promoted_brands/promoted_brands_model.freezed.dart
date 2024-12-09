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

PromotedProduct _$PromotedProductFromJson(Map<String, dynamic> json) {
  return _PromotedProduct.fromJson(json);
}

/// @nodoc
mixin _$PromotedProduct {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Serializes this PromotedProduct to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PromotedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PromotedProductCopyWith<PromotedProduct> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromotedProductCopyWith<$Res> {
  factory $PromotedProductCopyWith(
          PromotedProduct value, $Res Function(PromotedProduct) then) =
      _$PromotedProductCopyWithImpl<$Res, PromotedProduct>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$PromotedProductCopyWithImpl<$Res, $Val extends PromotedProduct>
    implements $PromotedProductCopyWith<$Res> {
  _$PromotedProductCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PromotedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromotedProductImplCopyWith<$Res>
    implements $PromotedProductCopyWith<$Res> {
  factory _$$PromotedProductImplCopyWith(_$PromotedProductImpl value,
          $Res Function(_$PromotedProductImpl) then) =
      __$$PromotedProductImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$PromotedProductImplCopyWithImpl<$Res>
    extends _$PromotedProductCopyWithImpl<$Res, _$PromotedProductImpl>
    implements _$$PromotedProductImplCopyWith<$Res> {
  __$$PromotedProductImplCopyWithImpl(
      _$PromotedProductImpl _value, $Res Function(_$PromotedProductImpl) _then)
      : super(_value, _then);

  /// Create a copy of PromotedProduct
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$PromotedProductImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromotedProductImpl implements _PromotedProduct {
  const _$PromotedProductImpl({required this.id, required this.name});

  factory _$PromotedProductImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromotedProductImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'PromotedProduct(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromotedProductImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  /// Create a copy of PromotedProduct
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PromotedProductImplCopyWith<_$PromotedProductImpl> get copyWith =>
      __$$PromotedProductImplCopyWithImpl<_$PromotedProductImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromotedProductImplToJson(
      this,
    );
  }
}

abstract class _PromotedProduct implements PromotedProduct {
  const factory _PromotedProduct(
      {required final int id,
      required final String name}) = _$PromotedProductImpl;

  factory _PromotedProduct.fromJson(Map<String, dynamic> json) =
      _$PromotedProductImpl.fromJson;

  @override
  int get id;
  @override
  String get name;

  /// Create a copy of PromotedProduct
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PromotedProductImplCopyWith<_$PromotedProductImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
