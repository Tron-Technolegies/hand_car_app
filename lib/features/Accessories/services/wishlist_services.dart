import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';


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

   Future<WishlistResponse> addToWishlist(int productId) async {
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

   Future<bool> removeFromWishlist(String productId) async {
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
  Future<Map<String, WishlistResponse>> getWishlist() async {
  try {
    final token = TokenStorage().getAccessToken();
    if (token == null) {
      throw Exception('Please login to continue');
    }

    final response = await _dio.get(
      '/wishlist_items',
      options: Options(
        headers: _createAuthHeaders(token),
      ),
    );

    log('Raw wishlist response: ${response.data}'); // Add this log

    if (response.statusCode == 200) {
      final wishlistData = response.data['wishlist_items'] as List;
      log('Wishlist items: $wishlistData'); // Add this log
      
      final Map<String, WishlistResponse> wishlistMap = {};
      
      for (var item in wishlistData) {
        try {
          final wishlistItem = WishlistResponse.fromJson(item);
          wishlistMap[wishlistItem.id.toString()] = wishlistItem;
        } catch (e) {
          log('Error parsing item: $item, Error: $e');
        }
      }
      
      return wishlistMap;
    }

    throw Exception(response.data['error'] ?? 'Failed to fetch wishlist');
  } on DioException {
    // ...
  } catch (e) {
    // ...
  }
  throw Exception('Failed to fetch wishlist');  
  }
}


