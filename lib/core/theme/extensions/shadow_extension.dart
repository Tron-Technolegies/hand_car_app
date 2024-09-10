import 'package:flutter/material.dart';

class AppShadowExtension extends ThemeExtension<AppShadowExtension> {
  final BoxShadow buttonShadow;
  final BoxShadow offerContainerShadow;
  final BoxShadow headingShadow;
  AppShadowExtension(
      {required this.buttonShadow,
      required this.offerContainerShadow,
      required this.headingShadow});
  @override
  ThemeExtension<AppShadowExtension> copyWith(
      {BoxShadow? buttonShadow,
      BoxShadow? offerContainerShadow,
      BoxShadow? headingShadow}) {
    return AppShadowExtension(
        buttonShadow: buttonShadow ?? this.buttonShadow,
        offerContainerShadow: offerContainerShadow ?? this.offerContainerShadow,
        headingShadow: headingShadow ?? this.headingShadow);
  }

  @override
  ThemeExtension<AppShadowExtension> lerp(
      covariant ThemeExtension<AppShadowExtension>? other, double t) {
    if (other is! AppShadowExtension) {
      return this;
    }
    return AppShadowExtension(
      buttonShadow: BoxShadow.lerp(buttonShadow, other.buttonShadow, t)!,
      offerContainerShadow:
          BoxShadow.lerp(offerContainerShadow, other.offerContainerShadow, t)!,
      headingShadow: BoxShadow.lerp(headingShadow, other.headingShadow, t)!,
    );
  }
}
