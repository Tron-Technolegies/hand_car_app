import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:html/parser.dart'; // For stripping HTML tags

part 'coupon_model.freezed.dart';
part 'coupon_model.g.dart';


/// Coupon Model class to get the data from the API
@freezed
class CouponModel with _$CouponModel {
  const CouponModel._(); // Added private constructor for custom getters
   //Factory constructor to create a CouponModel
  const factory CouponModel({
    
    required int id,
    required String name,
    @JsonKey(name: 'coupon_code') required String couponCode,
    @JsonKey(
      name: 'discount_percentage',
      fromJson: _parseDiscountPercentage,
    )
    required double discountPercentage,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    required String description,
  }) = _CouponModel;

  /// Factory to parse JSON data
  factory CouponModel.fromJson(Map<String, dynamic> json) =>
      _$CouponModelFromJson(json);

  /// Custom getter to return plain text from description
  String get plainDescription {
    final document = parse(description); // Parse HTML
    return document.body?.text ?? ''; // Extract plain text
  }
}

/// Helper to parse discount_percentage as a double
double _parseDiscountPercentage(dynamic value) {
  if (value is String) {
    return double.tryParse(value) ?? 0.0;
  } else if (value is num) {
    return value.toDouble();
  }
  throw ArgumentError('Invalid discount_percentage value: $value');
}
