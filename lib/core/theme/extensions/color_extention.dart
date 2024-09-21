import 'package:flutter/material.dart';

class ColorExtention extends ThemeExtension<ColorExtention> {
// App default colors

  final Color primary;
  final Color primaryTxt;
  final Color secondaryTxt;
  final Color backgroundSubtle;
  final Color white;
  final Color warning;
  final Color green100;
  final Color background;
  final Color btnShadow;
  final Color containerShadow;
  final Color green;
  final Color yellow;
  ColorExtention(
      {required this.primary,
      required this.primaryTxt,
      required this.secondaryTxt,
      required this.backgroundSubtle,
      required this.white,
      required this.warning,
      required this.green100,
      required this.background,
      required this.btnShadow,
      required this.containerShadow,
      required this.green,
      required this.yellow
      });
  @override
  ThemeExtension<ColorExtention> copyWith({
    Color? primary,
    Color? primaryTxt,
    Color? secondaryTxt,
    Color? backgroundSubtle,
    Color? white,
    Color? warning,
    Color? green100,
    Color? background,
    Color? btnShadow,
    Color? containerShadow,
    Color? green,
    Color? yellow

    
  }) {
    return ColorExtention(
        primary: primary ?? this.primary,
        primaryTxt: primaryTxt ?? this.primaryTxt,
        secondaryTxt: secondaryTxt ?? this.secondaryTxt,
        backgroundSubtle: backgroundSubtle ?? this.backgroundSubtle,
        white: white ?? this.white,
        warning: warning ?? this.warning,
        green100: green100 ?? this.green100,
        background: background ?? this.background,
        btnShadow: btnShadow ?? this.btnShadow,
        containerShadow: containerShadow ?? this.containerShadow,
        green: green ?? this.green,
        yellow: yellow?? this.yellow,
        );
  }

  @override
  ThemeExtension<ColorExtention> lerp(
      covariant ThemeExtension<ColorExtention>? other, double t) {
    if (other is! ColorExtention) {
      return this;
    }
    return ColorExtention(
        primary: Color.lerp(primary, other.primary, t)!,
        primaryTxt: Color.lerp(primaryTxt, other.primaryTxt, t)!,
        secondaryTxt: Color.lerp(secondaryTxt, other.secondaryTxt, t)!,
        backgroundSubtle:
            Color.lerp(backgroundSubtle, other.backgroundSubtle, t)!,
        white: Color.lerp(white, other.white, t)!,
        warning: Color.lerp(warning, other.warning, t)!,
        green: Color.lerp(green, other.green, t)!,
        background: Color.lerp(background, other.background, t)!,
        btnShadow: Color.lerp(btnShadow, other.btnShadow, t)!,
        containerShadow: Color.lerp(containerShadow, other.containerShadow, t)!,
        green100: Color.lerp(green100, other.green100, t)!,
        yellow: Color.lerp(yellow, other.yellow, t)!,
        );
  }
}
