
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/controller/model/cart/cart_model.dart';

class CartApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) => status! < 500, // Accept all status codes less than 500
  ));

  /// Get the cart items for the user.Future<CartModel?> getCart() async {
  Future<CartModel?> getCart() async {
    try {
      final response = await _dio.get(
        '/viewcartitems/',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        log('Cart API Response: ${response.data}'); // Add this log
        return CartModel.fromJson(response.data);
      } else {
        log('Error fetching cart: ${response.data['error']}');
        return null;
      }
    } catch (e) {
      log('Exception during getCart: $e');
      return null;
    }
  }
  



   
  static String _handleDioError(DioException e) {
    if (e.response != null) {
      return 'Error ${e.response?.statusCode}: ${e.response?.data['error'] ?? 'Unknown error'}';
    }
    return 'Network error: ${e.message}';
  }
}