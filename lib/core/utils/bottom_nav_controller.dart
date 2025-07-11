import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_controller.freezed.dart';
part 'bottom_nav_controller.g.dart';


@freezed
class NavigationState with _$NavigationState {
  const factory NavigationState({
    required int selectedNavBarItemIndex,
    required PageController pageController,
  }) = _NavigationState;
}

@riverpod
class Navigation extends _$Navigation {
  @override
  NavigationState build() {
    return NavigationState(
      selectedNavBarItemIndex: 2, 
      pageController: PageController(initialPage: 2),
    );
  }

  /// Change the page in the page view
  void jumpToPage(int pageIndex) {
    state.pageController.jumpToPage(pageIndex);
  }

  /// Update the selected page index state
  void changeSelectedItemIndex(int newlySelectedNavBarItem) {
    state = state.copyWith(selectedNavBarItemIndex: newlySelectedNavBarItem);
  }
}