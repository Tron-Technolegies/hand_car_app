import 'package:freezed_annotation/freezed_annotation.dart';

part 'coupon_model.freezed.dart';
part 'coupon_model.g.dart';

@freezed
class CouponModel with _$CouponModel {
  const factory CouponModel({
    required int id,
    required String name,
    @JsonKey(name: 'coupon_code') required String couponCode,
    @JsonKey(name: 'discount_percentage') required double discountPercentage,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @JsonKey(name: 'end_date') required DateTime endDate,
    required String description,
  }) = _CouponModel;

  factory CouponModel.fromJson(Map<String, dynamic> json) => _$CouponModelFromJson(json);
}