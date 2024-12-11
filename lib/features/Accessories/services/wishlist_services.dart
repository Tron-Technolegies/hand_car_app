import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';

class WishlistServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,)

  );
  static Future<void> addToWishlist(int productId) async {
    try {
      await _dio.post('/wishlist/add/', data: {
        'product_id': productId,
      });
    } catch (e) {
      throw Exception('Failed to add product to wishlist: ${e.toString()}');
    }
  }
  static Future<void> removeFromWishlist(int productId) async {
    try {
      await _dio.post('/wishlist/remove/', data: {
        'product_id': productId,
      });
    } catch (e) {
      throw Exception('Failed to remove product from wishlist: ${e.toString()}');
    }
  }
}