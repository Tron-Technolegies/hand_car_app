import 'dart:async';

import 'package:hand_car/features/Accessories/controller/model/coupon/coupon_model.dart';
import 'package:hand_car/features/Accessories/services/coupon_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'coupon_controller.g.dart';

@riverpod
class CouponController extends _$CouponController {
  @override
  Future<List<CouponModel>> build() async {
    return await _fetchCoupon();
  }

  Future<List<CouponModel>> _fetchCoupon() async {
    try {
      // Mark state as loading
      state = const AsyncValue.loading();
      
      // Fetch coupons from the service
      final coupons = await CouponServices.getCoupons();
      
      // Update state with data
      state = AsyncValue.data(coupons);
      return coupons;
    } catch (e, stackTrace) {
      // Handle errors by updating state with the error
      state = AsyncValue.error(e, stackTrace);
      rethrow; // Re-throw to propagate the error if needed
    }
  }
}