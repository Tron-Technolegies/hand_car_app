// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:hand_car/config.dart';
// import 'package:hand_car/core/router/user_validation.dart';
// import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
// // Import the token storage class

// // Cart API Service for Cart Page Fetching and Adding Cart
// class CartApiService {
//   static final Dio _dio = Dio(BaseOptions(
//     baseUrl: baseUrl,
//     connectTimeout: const Duration(seconds: 5),
//     receiveTimeout: const Duration(seconds: 3),
//     validateStatus: (status) => status! < 500, // Accept all status codes < 500
//   ));

//   /// Get the access token
//   Future<String?> _getToken() async {
//     return TokenStorage().getAccessToken(); // Fetch token from local storage
//   }

//   /// Get the cart items for the user.
//   Future<CartModel?> getCart() async {
//     final token = await _getToken(); // Retrieve the access token
//     if (token == null) {
//       throw Exception('Authorization token not found');
//     }

//     try {
//       final response = await _dio.get(
//         '/viewcartitems/',
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Authorization': 'Bearer $token', // Include the token here
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         log('Cart API Response: ${response.data}');
//         return CartModel.fromJson(response.data);
//       } else {
//         log('Error fetching cart: ${response.data['error']}');
//         return null;
//       }
//     } catch (e) {
//       log('Exception during getCart: $e');
//       return null;
//     }
//   }

//   /// Add a product to the cart
//   Future<Map<String, dynamic>> addToCart(int productId) async {
//     final token = await _getToken(); // Retrieve the access token
//     if (token == null) {
//       throw Exception('Authorization token not found');
//     }

//     try {
//       final response = await _dio.post(
//         '/cart/add/$productId/',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Pass the token here
//           },
//         ),
//       );
//       return response.data; // Response should be a JSON Map
//     } on DioException catch (e) {
//       if (e.response != null) {
//         throw Exception('Failed: ${e.response?.data['error'] ?? 'Unknown error'}');
//       }
//       throw Exception('Network Error: ${e.message}');
//     } catch (e) {
//       throw Exception('Unexpected Error: ${e.toString()}');
//     }
//   }

//   /// Remove a product from the cart
//   Future<Map<String, dynamic>> removeFromCart(int productId) async {
//     final token = await _getToken(); // Retrieve the access token
//     if (token == null) {
//       throw Exception('Authorization token not found');
//     }

//     try {
//       final response = await _dio.post(
//         '/cart/remove/',
//         data: {
//           'product_id': productId,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token', // Include the token here
//           },
//         ),
//       );
//       return response.data;
//     } catch (e) {
//       throw Exception('Failed to remove product from cart: ${e.toString()}');
//     }
//   }
// }
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';

class CartApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ),
  );

  Future<String?> _getToken() async {
    final token = TokenStorage().getAccessToken();
    log('Access Token: $token'); // Log the token
    return token;
  }

  /// Refresh Token if Expired
  Future<void> _refreshToken() async {
    final refreshToken = TokenStorage().getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw Exception('No refresh token available. Please log in again.');
    }

    final response = await _dio.post(
      '/api/token/refresh/',
      data: {'refresh_token': refreshToken},
      options: Options(headers: {'Content-Type': 'application/json'}),
    );

    if (response.statusCode == 200) {
      final newAccessToken = response.data['access_token'];
      final newRefreshToken = response.data['refresh_token'];
      await TokenStorage().saveTokens(
        accessToken: newAccessToken,
        refreshToken: newRefreshToken,
      );
    } else {
      throw Exception('Failed to refresh token. Please log in again.');
    }
  }

  /// Generic Method to Handle Requests with Token Expiry
  Future<Response> _makeRequest(Future<Response> Function() request) async {
    try {
      return await request();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        // Token expired, try refreshing
        await _refreshToken();
        return await request(); // Retry the original request
      }
      rethrow; // Propagate other errors
    }
  }

  /// Get Cart Items
  Future<CartModel> getCart() async {
    final token = await _getToken();
    try {
      final response = await _dio.get(
        '/viewcartitems/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      log('Response Headers: ${response.headers}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return CartModel.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to fetch cart: ${response.data['error'] ?? 'Unknown error'}');
      }
    } on DioException catch (e) {
      log('Error in getCart: $e');
      rethrow;
    }
  }

  /// Add a Product to Cart
  Future<Map<String, dynamic>> addToCart(int productId) async {
    final token = await _getToken();
    try {
      final response = await _dio.post(
        '/cart/add/$productId/',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      log('Response Headers: ${response.headers}');
      log('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to add product to cart: ${response.data['error'] ?? 'Unknown error'}');
      }
    } on DioException catch (e) {
      log('Error in addToCart: $e');
      rethrow;
    }
  }

  /// Remove a Product from Cart
  Future<Map<String, dynamic>> removeFromCart(int productId) async {
    final token = await _getToken();
    try {
      final response = await _makeRequest(() async {
        return await _dio.post(
          '/cart/remove/',
          data: {'product_id': productId},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      });

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(
            'Failed to remove product from cart: ${response.data['error'] ?? 'Unknown error'}');
      }
    } catch (e) {
      log('Error in removeFromCart: $e');
      rethrow;
    }
  }
}
