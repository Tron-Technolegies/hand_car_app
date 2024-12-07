import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/controller/model/coupon/coupon_model.dart';

class CouponServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
   Future<List<CouponModel>> getCoupons() async {
    try {
      final response = await _dio.get('/your-coupon-endpoint');
      
      // Assuming the response has a 'coupon' key with a list
      final List<dynamic> couponData = response.data['coupon'];
      
      return couponData.map((json) => CouponModel.fromJson(json)).toList();
    } on DioException catch (e) {
      // Handle network errors
      throw Exception('Failed to load coupons: ${e.message}');
    }
  }
}
