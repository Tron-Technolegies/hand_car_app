// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'multiple_image_picker_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MultipleImagePickerState {
  List<XFile> get selectedImages => throw _privateConstructorUsedError;

  /// Create a copy of MultipleImagePickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MultipleImagePickerStateCopyWith<MultipleImagePickerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MultipleImagePickerStateCopyWith<$Res> {
  factory $MultipleImagePickerStateCopyWith(MultipleImagePickerState value,
          $Res Function(MultipleImagePickerState) then) =
      _$MultipleImagePickerStateCopyWithImpl<$Res, MultipleImagePickerState>;
  @useResult
  $Res call({List<XFile> selectedImages});
}

/// @nodoc
class _$MultipleImagePickerStateCopyWithImpl<$Res,
        $Val extends MultipleImagePickerState>
    implements $MultipleImagePickerStateCopyWith<$Res> {
  _$MultipleImagePickerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MultipleImagePickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedImages = null,
  }) {
    return _then(_value.copyWith(
      selectedImages: null == selectedImages
          ? _value.selectedImages
          : selectedImages // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MultipleImagePickerStateImplCopyWith<$Res>
    implements $MultipleImagePickerStateCopyWith<$Res> {
  factory _$$MultipleImagePickerStateImplCopyWith(
          _$MultipleImagePickerStateImpl value,
          $Res Function(_$MultipleImagePickerStateImpl) then) =
      __$$MultipleImagePickerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<XFile> selectedImages});
}

/// @nodoc
class __$$MultipleImagePickerStateImplCopyWithImpl<$Res>
    extends _$MultipleImagePickerStateCopyWithImpl<$Res,
        _$MultipleImagePickerStateImpl>
    implements _$$MultipleImagePickerStateImplCopyWith<$Res> {
  __$$MultipleImagePickerStateImplCopyWithImpl(
      _$MultipleImagePickerStateImpl _value,
      $Res Function(_$MultipleImagePickerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MultipleImagePickerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedImages = null,
  }) {
    return _then(_$MultipleImagePickerStateImpl(
      selectedImages: null == selectedImages
          ? _value.selectedImages
          : selectedImages // ignore: cast_nullable_to_non_nullable
              as List<XFile>,
    ));
  }
}

/// @nodoc

class _$MultipleImagePickerStateImpl implements _MultipleImagePickerState {
  const _$MultipleImagePickerStateImpl({required this.selectedImages});

  @override
  final List<XFile> selectedImages;

  @override
  String toString() {
    return 'MultipleImagePickerState(selectedImages: $selectedImages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MultipleImagePickerStateImpl &&
            const DeepCollectionEquality()
                .equals(other.selectedImages, selectedImages));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(selectedImages));

  /// Create a copy of MultipleImagePickerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MultipleImagePickerStateImplCopyWith<_$MultipleImagePickerStateImpl>
      get copyWith => __$$MultipleImagePickerStateImplCopyWithImpl<
          _$MultipleImagePickerStateImpl>(this, _$identity);
}

abstract class _MultipleImagePickerState implements MultipleImagePickerState {
  const factory _MultipleImagePickerState(
          {required final List<XFile> selectedImages}) =
      _$MultipleImagePickerStateImpl;

  @override
  List<XFile> get selectedImages;

  /// Create a copy of MultipleImagePickerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MultipleImagePickerStateImplCopyWith<_$MultipleImagePickerStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
