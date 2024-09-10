import 'package:flutter/material.dart';

class TypographyExtention extends ThemeExtension<TypographyExtention> {
//Default App Typographys

  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle subtitle;
  final TextStyle body;
  final TextStyle bodySemiBold;
  final TextStyle bodyMedium;
  final TextStyle bodySmall;
  final TextStyle bodySmallSemiBold;
  final TextStyle bodySmallMedium;
  final TextStyle bodyLarge;
  final TextStyle bodyLargeSemiBold;
  final TextStyle bodyLargeMedium;
  final TextStyle caption;
  final TextStyle buttonTxt;

  TypographyExtention({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.subtitle,
    required this.body,
    required this.bodySemiBold,
    required this.bodyMedium,
    required this.bodySmall,
    required this.bodySmallSemiBold,
    required this.bodySmallMedium,
    required this.bodyLarge,
    required this.bodyLargeSemiBold,
    required this.bodyLargeMedium,
    required this.caption,
    required this.buttonTxt,
  });

  @override
  ThemeExtension<TypographyExtention> copyWith({
    TextStyle? h1,
    TextStyle? h2,
    TextStyle? h3,
    TextStyle? subtitle,
    TextStyle? body,
    TextStyle? bodySemiBold,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? bodySmallSemiBold,
    TextStyle? bodySmallMedium,
    TextStyle? bodyLarge,
    TextStyle? bodyLargeSemiBold,
    TextStyle? bodyLargeMedium,
    TextStyle? caption,
    TextStyle? buttonTxt,
    TextStyle? button2,
  }) {
    return TypographyExtention(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      subtitle: subtitle ?? this.subtitle,
      body: body ?? this.body,
      bodySemiBold: bodySemiBold ?? this.bodySemiBold,
      bodyMedium: bodyMedium ?? this.bodyMedium,
      bodySmall: bodySmall ?? this.bodySmall,
      bodySmallSemiBold: bodySmallSemiBold ?? this.bodySmallSemiBold,
      bodySmallMedium: bodySmallMedium ?? this.bodySmallMedium,
      bodyLarge: bodyLarge ?? this.bodyLarge,
      bodyLargeSemiBold: bodyLargeSemiBold ?? this.bodyLargeSemiBold,
      bodyLargeMedium: bodyLargeMedium ?? this.bodyLargeMedium,
      caption: caption ?? this.caption,
      buttonTxt: buttonTxt ?? this.buttonTxt,
    );
  }

  @override
  ThemeExtension<TypographyExtention> lerp(
      covariant ThemeExtension<TypographyExtention>? other, double t) {
    if (other is! TypographyExtention) {
      return this;
    }
    return TypographyExtention(
      h1: TextStyle.lerp(h1, other.h1, t)!,
      h2: TextStyle.lerp(h2, other.h2, t)!,
      h3: TextStyle.lerp(h3, other.h3, t)!,
      subtitle: TextStyle.lerp(subtitle, other.subtitle, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      bodySemiBold: TextStyle.lerp(bodySemiBold, other.bodySemiBold, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodyLarge, other.bodySmall, t)!,
      bodySmallSemiBold:
          TextStyle.lerp(bodyLargeSemiBold, other.bodySmallSemiBold, t)!,
      bodySmallMedium:
          TextStyle.lerp(bodySmallMedium, other.bodySmallMedium, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyLargeSemiBold:
          TextStyle.lerp(bodyLargeSemiBold, other.bodyLargeSemiBold, t)!,
      bodyLargeMedium:
          TextStyle.lerp(bodyLargeMedium, other.bodyLargeMedium, t)!,
      caption: TextStyle.lerp(caption, other.caption, t)!,
      buttonTxt: TextStyle.lerp(buttonTxt, other.buttonTxt, t)!,
    );
  }
}
