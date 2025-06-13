
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

  Future<WishlistResponse> addToWishlist(int productId, {String? productName}) async {
    try {
      final token = TokenStorage().getAccessToken();
      if (token == null) {
        throw Exception('Please login to continue');
      }

      log('Making request to add product $productId to wishlist');

      final response = await _dio.post(
        '/add_to_wishlist/$productId/',
        options: Options(headers: _createAuthHeaders(token)),
      );

      log('Add to wishlist response status: ${response.statusCode}');
      log('Add to wishlist response data: ${response.data}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map) {
          if (response.data.containsKey('wishlist_item')) {
            final wishlistItemData = response.data['wishlist_item'];
            try {
              final wishlistItem = WishlistResponse.fromJson(wishlistItemData as Map<String, dynamic>);
              log('Parsed WishlistResponse: ${wishlistItem.toJson()}');
              return wishlistItem;
            } catch (parseError) {
              log('Error parsing wishlist_item: $parseError');
              throw Exception('Invalid wishlist_item format: $parseError');
            }
          } else if (response.data.containsKey('product_id')) {
            final productIdRaw = response.data['product_id'];
            if (productIdRaw == null) {
              log('Missing product_id in response');
              throw Exception('Invalid response format: missing product_id');
            }
            // Fetch updated wishlist to get full item data
            try {
              final wishlist = await getWishlist();
              final wishlistItem = wishlist[productIdRaw.toString()];
              if (wishlistItem != null) {
                log('Retrieved wishlist item from getWishlist: ${wishlistItem.toJson()}');
                return wishlistItem;
              }
              log('Wishlist item not found after add, using fallback');
              return WishlistResponse(
                id: int.tryParse(productIdRaw.toString()) ?? productId,
                productName: productName ?? 'Unknown Product',
                productPrice: null,
                productImage: null,
                productDescription: null,
              );
            } catch (fetchError) {
              log('Error fetching wishlist: $fetchError');
              throw Exception('Failed to fetch wishlist item: $fetchError');
            }
          }
        }
        log('Unexpected response format: ${response.data}');
        throw Exception('Invalid response format');
      }

      String errorMessage = 'Failed to add to wishlist';
      if (response.data is Map && response.data.containsKey('error')) {
        errorMessage = response.data['error'].toString();
      }
      throw Exception(errorMessage);
    } on DioException catch (e) {
      log('DioException in addToWishlist: ${e.message}');
      log('Response data: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Please login to continue');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Product not found');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Invalid request data');
      } else if (e.response?.data is Map && e.response?.data.containsKey('error')) {
        throw Exception(e.response?.data['error'].toString());
      }
      throw Exception('Failed to add to wishlist: ${e.message}');
    } catch (e) {
      log('Unexpected error in addToWishlist: $e');
      throw Exception('Failed to add to wishlist: $e');
    }
  }

  Future<bool> removeFromWishlist(String productId) async {
    try {
      final token = TokenStorage().getAccessToken();
      if (token == null) {
        throw Exception('Please login to continue');
      }

      log('Removing wishlist item: $productId');

      final response = await _dio.delete(
        '/remove_wishlist/$productId/',
        options: Options(headers: _createAuthHeaders(token)),
      );

      log('Remove from wishlist response: ${response.statusCode}');
      log('Remove response data: ${response.data}');

      return response.statusCode == 200 || response.statusCode == 204;
    } on DioException catch (e) {
      log('DioException in removeFromWishlist: ${e.message}');
      log('Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Please login to continue');
      } else if (e.response?.statusCode == 404) {
        log('Product not found in wishlist, treating as successful removal');
        return true;
      }

      String errorMessage = 'Failed to remove from wishlist';
      if (e.response?.data is Map && e.response?.data.containsKey('error')) {
        errorMessage = e.response!.data['error'].toString();
      }
      throw Exception(errorMessage);
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
        '/wishlist_items/',
        options: Options(headers: _createAuthHeaders(token)),
      );

      log('Get wishlist response status: ${response.statusCode}');
      log('Raw wishlist response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is Map && response.data.containsKey('wishlist_items')) {
          final wishlistData = response.data['wishlist_items'] as List;
          log('Wishlist items count: ${wishlistData.length}');

          final Map<String, WishlistResponse> wishlistMap = {};
          for (var item in wishlistData) {
            try {
              if (item is Map<String, dynamic>) {
                final wishlistItem = WishlistResponse.fromJson(item);
                wishlistMap[wishlistItem.id.toString()] = wishlistItem;
                log('Parsed wishlist item: ${wishlistItem.toJson()}');
              } else {
                log('Skipping invalid item format: $item');
              }
            } catch (e) {
              log('Error parsing wishlist item: $item, Error: $e');
            }
          }

          log('Successfully parsed ${wishlistMap.length} wishlist items');
          return wishlistMap;
        } else {
          throw Exception('Unexpected response format');
        }
      }

      String errorMessage = 'Failed to fetch wishlist';
      if (response.data is Map && response.data.containsKey('error')) {
        errorMessage = response.data['error'].toString();
      }
      throw Exception(errorMessage);
    } on DioException catch (e) {
      log('DioException in getWishlist: ${e.message}');
      log('Response: ${e.response?.data}');

      if (e.response?.statusCode == 401) {
        throw Exception('Please login to continue');
      }
      throw Exception('Failed to fetch wishlist: ${e.message}');
    } catch (e) {
      log('Unexpected error in getWishlist: $e');
      throw Exception('Failed to fetch wishlist');
    }
  }
}
