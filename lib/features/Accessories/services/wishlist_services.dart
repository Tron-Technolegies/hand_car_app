import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_response_model.dart';

class WishlistServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,)

  );
   static Future<WishlistResponse?> addToWishlist(int productId) async {
    try {
      final response = await _dio.post(
        '/api/wishlist/add/$productId/',
        // Add any necessary headers or authentication
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            // Add auth token if needed
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return WishlistResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      // You might want to handle specific DioExceptions here
      rethrow;
    }
  }

  static Future<bool> removeFromWishlist(String productId) async {
    try {
      final response = await _dio.delete(
        '/api/wishlist/remove/$productId/',
        // Add any necessary headers or authentication
      );

      return response.statusCode == 200 || response.statusCode == 204;
    } catch (e) {
      rethrow;
    }
  }}