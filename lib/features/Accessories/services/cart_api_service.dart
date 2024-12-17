import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';

//Cart Api Service for Cart Page Fetching and Adding Ca
class CartApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
    validateStatus: (status) =>
        status! < 500, // Accept all status codes less than 500
  ));

  /// Get the cart items for the user.
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

  /// Add a product to the cart
Future<Map<String, dynamic>> addToCart(int productId) async {
    try {
      final response = await _dio.post(
        '/cart/add/$productId/', // Append product_id to the endpoint
      );
      return response.data; // Response should be a JSON Map
    } on DioException catch (e) {
      // Handle Dio-specific errors
      if (e.response != null) {
        throw Exception('Failed: ${e.response?.data['error'] ?? 'Unknown error'}');
      }
      throw Exception('Network Error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected Error: ${e.toString()}');
    }
  }
  /// Remove a product from the cart
  Future<Map<String, dynamic>> removeFromCart(int productId) async {
    try {
      final response = await _dio.post('/cart/remove/', data: {
        'product_id': productId,
      });
      return response.data;
    } catch (e) {
      throw Exception('Failed to remove product from cart: ${e.toString()}');
    }
  }
}
