// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CarServiceState {
  List<ServiceModel> get services => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of CarServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarServiceStateCopyWith<CarServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarServiceStateCopyWith<$Res> {
  factory $CarServiceStateCopyWith(
          CarServiceState value, $Res Function(CarServiceState) then) =
      _$CarServiceStateCopyWithImpl<$Res, CarServiceState>;
  @useResult
  $Res call({List<ServiceModel> services, bool isLoading, String? error});
}

/// @nodoc
class _$CarServiceStateCopyWithImpl<$Res, $Val extends CarServiceState>
    implements $CarServiceStateCopyWith<$Res> {
  _$CarServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarServiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CarServiceStateImplCopyWith<$Res>
    implements $CarServiceStateCopyWith<$Res> {
  factory _$$CarServiceStateImplCopyWith(_$CarServiceStateImpl value,
          $Res Function(_$CarServiceStateImpl) then) =
      __$$CarServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ServiceModel> services, bool isLoading, String? error});
}

/// @nodoc
class __$$CarServiceStateImplCopyWithImpl<$Res>
    extends _$CarServiceStateCopyWithImpl<$Res, _$CarServiceStateImpl>
    implements _$$CarServiceStateImplCopyWith<$Res> {
  __$$CarServiceStateImplCopyWithImpl(
      _$CarServiceStateImpl _value, $Res Function(_$CarServiceStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CarServiceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? services = null,
    Object? isLoading = null,
    Object? error = freezed,
  }) {
    return _then(_$CarServiceStateImpl(
      services: null == services
          ? _value.services
          : services // ignore: cast_nullable_to_non_nullable
              as List<ServiceModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$CarServiceStateImpl implements _CarServiceState {
  const _$CarServiceStateImpl(
      {this.services = const [], this.isLoading = false, this.error});

  @override
  @JsonKey()
  final List<ServiceModel> services;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;

  @override
  String toString() {
    return 'CarServiceState(services: $services, isLoading: $isLoading, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarServiceStateImpl &&
            const DeepCollectionEquality().equals(other.services, services) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(services), isLoading, error);

  /// Create a copy of CarServiceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarServiceStateImplCopyWith<_$CarServiceStateImpl> get copyWith =>
      __$$CarServiceStateImplCopyWithImpl<_$CarServiceStateImpl>(
          this, _$identity);
}

abstract class _CarServiceState implements CarServiceState {
  const factory _CarServiceState(
      {final List<ServiceModel> services,
      final bool isLoading,
      final String? error}) = _$CarServiceStateImpl;

  @override
  List<ServiceModel> get services;
  @override
  bool get isLoading;
  @override
  String? get error;

  /// Create a copy of CarServiceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarServiceStateImplCopyWith<_$CarServiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
