// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plan_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlanResponse {
  List<PlanModel> get plan => throw _privateConstructorUsedError;

  /// Create a copy of PlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanResponseCopyWith<PlanResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanResponseCopyWith<$Res> {
  factory $PlanResponseCopyWith(
          PlanResponse value, $Res Function(PlanResponse) then) =
      _$PlanResponseCopyWithImpl<$Res, PlanResponse>;
  @useResult
  $Res call({List<PlanModel> plan});
}

/// @nodoc
class _$PlanResponseCopyWithImpl<$Res, $Val extends PlanResponse>
    implements $PlanResponseCopyWith<$Res> {
  _$PlanResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
  }) {
    return _then(_value.copyWith(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as List<PlanModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanResponseImplCopyWith<$Res>
    implements $PlanResponseCopyWith<$Res> {
  factory _$$PlanResponseImplCopyWith(
          _$PlanResponseImpl value, $Res Function(_$PlanResponseImpl) then) =
      __$$PlanResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PlanModel> plan});
}

/// @nodoc
class __$$PlanResponseImplCopyWithImpl<$Res>
    extends _$PlanResponseCopyWithImpl<$Res, _$PlanResponseImpl>
    implements _$$PlanResponseImplCopyWith<$Res> {
  __$$PlanResponseImplCopyWithImpl(
      _$PlanResponseImpl _value, $Res Function(_$PlanResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? plan = null,
  }) {
    return _then(_$PlanResponseImpl(
      plan: null == plan
          ? _value.plan
          : plan // ignore: cast_nullable_to_non_nullable
              as List<PlanModel>,
    ));
  }
}

/// @nodoc

class _$PlanResponseImpl implements _PlanResponse {
  const _$PlanResponseImpl({this.plan = const []});

  @override
  @JsonKey()
  final List<PlanModel> plan;

  @override
  String toString() {
    return 'PlanResponse(plan: $plan)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanResponseImpl &&
            const DeepCollectionEquality().equals(other.plan, plan));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(plan));

  /// Create a copy of PlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanResponseImplCopyWith<_$PlanResponseImpl> get copyWith =>
      __$$PlanResponseImplCopyWithImpl<_$PlanResponseImpl>(this, _$identity);
}

abstract class _PlanResponse implements PlanResponse {
  const factory _PlanResponse({final List<PlanModel> plan}) =
      _$PlanResponseImpl;

  @override
  List<PlanModel> get plan;

  /// Create a copy of PlanResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanResponseImplCopyWith<_$PlanResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PlanModel {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'service_type')
  String get serviceType => throw _privateConstructorUsedError;
  String get duration => throw _privateConstructorUsedError;
  String get price => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of PlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlanModelCopyWith<PlanModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlanModelCopyWith<$Res> {
  factory $PlanModelCopyWith(PlanModel value, $Res Function(PlanModel) then) =
      _$PlanModelCopyWithImpl<$Res, PlanModel>;
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'service_type') String serviceType,
      String duration,
      String price,
      String? description});
}

/// @nodoc
class _$PlanModelCopyWithImpl<$Res, $Val extends PlanModel>
    implements $PlanModelCopyWith<$Res> {
  _$PlanModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? serviceType = null,
    Object? duration = null,
    Object? price = null,
    Object? description = freezed,
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
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlanModelImplCopyWith<$Res>
    implements $PlanModelCopyWith<$Res> {
  factory _$$PlanModelImplCopyWith(
          _$PlanModelImpl value, $Res Function(_$PlanModelImpl) then) =
      __$$PlanModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      @JsonKey(name: 'service_type') String serviceType,
      String duration,
      String price,
      String? description});
}

/// @nodoc
class __$$PlanModelImplCopyWithImpl<$Res>
    extends _$PlanModelCopyWithImpl<$Res, _$PlanModelImpl>
    implements _$$PlanModelImplCopyWith<$Res> {
  __$$PlanModelImplCopyWithImpl(
      _$PlanModelImpl _value, $Res Function(_$PlanModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PlanModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? serviceType = null,
    Object? duration = null,
    Object? price = null,
    Object? description = freezed,
  }) {
    return _then(_$PlanModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      serviceType: null == serviceType
          ? _value.serviceType
          : serviceType // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PlanModelImpl implements _PlanModel {
  _$PlanModelImpl(
      {required this.id,
      required this.name,
      @JsonKey(name: 'service_type') required this.serviceType,
      required this.duration,
      required this.price,
      this.description});

  @override
  final int id;
  @override
  final String name;
  @override
  @JsonKey(name: 'service_type')
  final String serviceType;
  @override
  final String duration;
  @override
  final String price;
  @override
  final String? description;

  @override
  String toString() {
    return 'PlanModel(id: $id, name: $name, serviceType: $serviceType, duration: $duration, price: $price, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlanModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.serviceType, serviceType) ||
                other.serviceType == serviceType) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, serviceType, duration, price, description);

  /// Create a copy of PlanModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlanModelImplCopyWith<_$PlanModelImpl> get copyWith =>
      __$$PlanModelImplCopyWithImpl<_$PlanModelImpl>(this, _$identity);
}

abstract class _PlanModel implements PlanModel {
  factory _PlanModel(
      {required final int id,
      required final String name,
      @JsonKey(name: 'service_type') required final String serviceType,
      required final String duration,
      required final String price,
      final String? description}) = _$PlanModelImpl;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(name: 'service_type')
  String get serviceType;
  @override
  String get duration;
  @override
  String get price;
  @override
  String? get description;

  /// Create a copy of PlanModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlanModelImplCopyWith<_$PlanModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
