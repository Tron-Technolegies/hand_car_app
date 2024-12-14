import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

class CouponServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  // Function to fetch coupons
  static Future<List<CouponModel>> getCoupons() async {
    try {
      final response = await _dio.get('/view_coupons');

      // Assuming the response has a 'coupon' key with a list
      final List<dynamic> couponData = response.data['coupon'];
      log('Coupon data: $couponData');

      return couponData.map((json) => CouponModel.fromJson(json)).toList();
    } on DioException catch (e) {
      // Handle network errors
      throw Exception('Failed to load coupons: ${e.message}');
    }
  }
}
