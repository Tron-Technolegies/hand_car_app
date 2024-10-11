// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_nav_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NavigationState {
  int get selectedNavBarItemIndex => throw _privateConstructorUsedError;
  PageController get pageController => throw _privateConstructorUsedError;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NavigationStateCopyWith<NavigationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NavigationStateCopyWith<$Res> {
  factory $NavigationStateCopyWith(
          NavigationState value, $Res Function(NavigationState) then) =
      _$NavigationStateCopyWithImpl<$Res, NavigationState>;
  @useResult
  $Res call({int selectedNavBarItemIndex, PageController pageController});
}

/// @nodoc
class _$NavigationStateCopyWithImpl<$Res, $Val extends NavigationState>
    implements $NavigationStateCopyWith<$Res> {
  _$NavigationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedNavBarItemIndex = null,
    Object? pageController = null,
  }) {
    return _then(_value.copyWith(
      selectedNavBarItemIndex: null == selectedNavBarItemIndex
          ? _value.selectedNavBarItemIndex
          : selectedNavBarItemIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageController: null == pageController
          ? _value.pageController
          : pageController // ignore: cast_nullable_to_non_nullable
              as PageController,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BottomNavBarStateImplCopyWith<$Res>
    implements $NavigationStateCopyWith<$Res> {
  factory _$$BottomNavBarStateImplCopyWith(_$BottomNavBarStateImpl value,
          $Res Function(_$BottomNavBarStateImpl) then) =
      __$$BottomNavBarStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int selectedNavBarItemIndex, PageController pageController});
}

/// @nodoc
class __$$BottomNavBarStateImplCopyWithImpl<$Res>
    extends _$NavigationStateCopyWithImpl<$Res, _$BottomNavBarStateImpl>
    implements _$$BottomNavBarStateImplCopyWith<$Res> {
  __$$BottomNavBarStateImplCopyWithImpl(_$BottomNavBarStateImpl _value,
      $Res Function(_$BottomNavBarStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedNavBarItemIndex = null,
    Object? pageController = null,
  }) {
    return _then(_$BottomNavBarStateImpl(
      selectedNavBarItemIndex: null == selectedNavBarItemIndex
          ? _value.selectedNavBarItemIndex
          : selectedNavBarItemIndex // ignore: cast_nullable_to_non_nullable
              as int,
      pageController: null == pageController
          ? _value.pageController
          : pageController // ignore: cast_nullable_to_non_nullable
              as PageController,
    ));
  }
}

/// @nodoc

class _$BottomNavBarStateImpl implements _BottomNavBarState {
  const _$BottomNavBarStateImpl(
      {required this.selectedNavBarItemIndex, required this.pageController});

  @override
  final int selectedNavBarItemIndex;
  @override
  final PageController pageController;

  @override
  String toString() {
    return 'NavigationState(selectedNavBarItemIndex: $selectedNavBarItemIndex, pageController: $pageController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BottomNavBarStateImpl &&
            (identical(
                    other.selectedNavBarItemIndex, selectedNavBarItemIndex) ||
                other.selectedNavBarItemIndex == selectedNavBarItemIndex) &&
            (identical(other.pageController, pageController) ||
                other.pageController == pageController));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, selectedNavBarItemIndex, pageController);

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BottomNavBarStateImplCopyWith<_$BottomNavBarStateImpl> get copyWith =>
      __$$BottomNavBarStateImplCopyWithImpl<_$BottomNavBarStateImpl>(
          this, _$identity);
}

abstract class _BottomNavBarState implements NavigationState {
  const factory _BottomNavBarState(
      {required final int selectedNavBarItemIndex,
      required final PageController pageController}) = _$BottomNavBarStateImpl;

  @override
  int get selectedNavBarItemIndex;
  @override
  PageController get pageController;

  /// Create a copy of NavigationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BottomNavBarStateImplCopyWith<_$BottomNavBarStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
