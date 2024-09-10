/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/hand_car_icon.svg
  String get handCarIcon => 'assets/icons/hand_car_icon.svg';

  /// File path: assets/icons/ic_car_service_filled.svg
  String get icCarServiceFilled => 'assets/icons/ic_car_service_filled.svg';

  /// File path: assets/icons/ic_car_service_outline.svg
  String get icCarServiceOutline => 'assets/icons/ic_car_service_outline.svg';

  /// File path: assets/icons/ic_car_wash_filled.svg
  String get icCarWashFilled => 'assets/icons/ic_car_wash_filled.svg';

  /// File path: assets/icons/ic_car_wash_outline.svg
  String get icCarWashOutline => 'assets/icons/ic_car_wash_outline.svg';

  /// File path: assets/icons/ic_home_filled.svg
  String get icHomeFilled => 'assets/icons/ic_home_filled.svg';

  /// File path: assets/icons/ic_home_outline.svg
  String get icHomeOutline => 'assets/icons/ic_home_outline.svg';

  /// File path: assets/icons/ic_subscription_filled.svg
  String get icSubscriptionFilled => 'assets/icons/ic_subscription_filled.svg';

  /// File path: assets/icons/ic_subscription_outline.svg
  String get icSubscriptionOutline =>
      'assets/icons/ic_subscription_outline.svg';

  /// File path: assets/icons/ic_tire_filled.svg
  String get icTireFilled => 'assets/icons/ic_tire_filled.svg';

  /// File path: assets/icons/ic_tire_outline.svg
  String get icTireOutline => 'assets/icons/ic_tire_outline.svg';

  /// List of all assets
  List<String> get values => [
        handCarIcon,
        icCarServiceFilled,
        icCarServiceOutline,
        icCarWashFilled,
        icCarWashOutline,
        icHomeFilled,
        icHomeOutline,
        icSubscriptionFilled,
        icSubscriptionOutline,
        icTireFilled,
        icTireOutline
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Auto Body Paint Shop.svg
  String get autoBodyPaintShop => 'assets/images/Auto Body Paint Shop.svg';

  /// File path: assets/images/Car Engine Repair.svg
  String get carEngineRepair => 'assets/images/Car Engine Repair.svg';

  /// File path: assets/images/Car Maintenance.svg
  String get carMaintenance => 'assets/images/Car Maintenance.svg';

  /// File path: assets/images/Car Mechanic with Client.svg
  String get carMechanicWithClient =>
      'assets/images/Car Mechanic with Client.svg';

  /// File path: assets/images/Car Repair Tune Up.svg
  String get carRepairTuneUp => 'assets/images/Car Repair Tune Up.svg';

  /// File path: assets/images/Car Wash.svg
  String get carWash => 'assets/images/Car Wash.svg';

  /// File path: assets/images/Mechanic rolling Car Wheel.svg
  String get mechanicRollingCarWheel =>
      'assets/images/Mechanic rolling Car Wheel.svg';

  /// File path: assets/images/Tire Mechanic.svg
  String get tireMechanic => 'assets/images/Tire Mechanic.svg';

  /// File path: assets/images/accessories.png
  AssetGenImage get accessories =>
      const AssetGenImage('assets/images/accessories.png');

  /// File path: assets/images/car.png
  AssetGenImage get car => const AssetGenImage('assets/images/car.png');

  /// File path: assets/images/spare_parts.png
  AssetGenImage get spareParts =>
      const AssetGenImage('assets/images/spare_parts.png');

  /// List of all assets
  List<dynamic> get values => [
        autoBodyPaintShop,
        carEngineRepair,
        carMaintenance,
        carMechanicWithClient,
        carRepairTuneUp,
        carWash,
        mechanicRollingCarWheel,
        tireMechanic,
        accessories,
        car,
        spareParts
      ];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
