import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_response_model.dart';

class WishlistServices {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      validateStatus: (status) => status != null && status < 500,
      followRedirects: true,
      maxRedirects: 5,
    ),
  );

  static Map<String, String> _createAuthHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  static Future<WishlistResponse> addToWishlist(int productId) async {
    try {
      final token = TokenStorage().getAccessToken();
      if (token == null) {
        throw Exception('Please login to continue');
      }

      log('Adding product to wishlist: $productId');
      final response = await _dio.post(
        '/add_to_wishlist/$productId/',
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Wishlist response: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        return WishlistResponse.fromJson(response.data);
      }

      throw Exception(response.data['error'] ?? 'Failed to add to wishlist');
    } on DioException catch (e) {
      log('DioException in addToWishlist: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Please login to continue');
      }
      throw Exception(e.response?.data?['error'] ?? 'Failed to add to wishlist');
    } catch (e) {
      log('Error in addToWishlist: $e');
      throw Exception(e.toString());
    }
  }

  static Future<bool> removeFromWishlist(String productId) async {
    try {
      final token = TokenStorage().getAccessToken();
      if (token == null) {
        throw Exception('Please login to continue');
      }

      log('Removing product from wishlist: $productId');
      final response = await _dio.delete(
        '/api/wishlist/remove/$productId/',
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Remove from wishlist response: ${response.statusCode}');
      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      log('DioException in removeFromWishlist: ${e.message}');
      if (e.response?.statusCode == 401) {
        throw Exception('Please login to continue');
      }
      throw Exception(e.response?.data?['error'] ?? 'Failed to remove from wishlist');
    } catch (e) {
      log('Error in removeFromWishlist: $e');
      throw Exception(e.toString());
    }
  }
}