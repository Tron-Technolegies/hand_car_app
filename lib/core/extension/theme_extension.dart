import 'package:flutter/material.dart';
import 'package:hand_car/core/theme/extensions/color_extention.dart';
import 'package:hand_car/core/theme/extensions/shadow_extension.dart';
import 'package:hand_car/core/theme/extensions/space_extension.dart';
import 'package:hand_car/core/theme/extensions/typography_extention.dart';

// Apptheme extention
extension ThemeExtension on BuildContext {
  ColorExtention get colors {
    return Theme.of(this).extension<ColorExtention>()!;
  }

  TypographyExtention get typography {
    return Theme.of(this).extension<TypographyExtention>()!;
  }

  AppShadowExtension get shadow {
    return Theme.of(this).extension<AppShadowExtension>()!;
  }

  AppSpaceExtension get space {
    return Theme.of(this).extension<AppSpaceExtension>()!;
  }
}
