import 'package:dio/dio.dart';
import 'package:hand_car/features/Accessories/controller/model/cart/cart_model.dart';

class CartApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.1.50:8000', // Replace with your actual API base URL
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // Add item to cart
  static Future<bool> addToCart(CartItem item) async {
    try {
      final response = await _dio.post(
        '/cart/add',
        data: item.toJson(),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error adding to cart: $e');
      return false;
    }
  }

  // Remove item from cart
  static Future<bool> removeFromCart(String itemId) async {
    try {
      final response = await _dio.delete(
        '/cart/remove/$itemId',
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error removing from cart: $e');
      return false;
    }
  }

  // Update cart item quantity
  static Future<bool> updateCartItemQuantity(String itemId, int quantity) async {
    try {
      final response = await _dio.put(
        '/cart/update/$itemId',
        data: {'quantity': quantity},
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Error updating cart quantity: $e');
      return false;
    }
  }

  // Get cart items
  static Future<CartModel?> getCart() async {
    try {
      final response = await _dio.get('rviewcartitems/');
      if (response.statusCode == 200) {
        return CartModel.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('Error getting cart: $e');
      return null;
    }
  }

  // Clear cart
  static Future<bool> clearCart() async {
    try {
      final response = await _dio.delete('/cart/clear');
      return response.statusCode == 200;
    } catch (e) {
      print('Error clearing cart: $e');
      return false;
    }
  }
}
