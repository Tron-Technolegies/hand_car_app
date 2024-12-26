// cart_api_service.dart
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/core/exception/cart/cart_exception.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_response.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

class CartApiService {
static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      validateStatus: (status) => status != null && status < 400,
      followRedirects: true,
      maxRedirects: 5,
    ),
  );

  // Updated to include 'Bearer' prefix
  Map<String, String> _createAuthHeaders(String token) {
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<String> _getToken() async {
    final token = TokenStorage().getAccessToken();
    if (token == null || token.isEmpty) {
      log('No access token available');
      throw const CartException('Please login to continue');
    }
    log('Using token: $token');
    return token;
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = TokenStorage().getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data['access']?.toString();
        if (newAccessToken != null) {
          await TokenStorage().saveTokens(
            accessToken: newAccessToken,
            refreshToken: refreshToken,
          );
          return true;
        }
      }
      return false;
    } catch (e) {
      log('Token refresh error: $e');
      return false;
    }
  }

  Future<T> _makeAuthenticatedRequest<T>(
    Future<T> Function(String token) request
  ) async {
    try {
      final token = await _getToken();
      try {
        log('Making authenticated request with token');
        return await request(token);
      } on DioException catch (e) {
        log('DioException in request: ${e.message}');
        log('Response status: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');
        log('Request headers: ${e.requestOptions.headers}');

        if (e.response?.statusCode == 401) {
          log('Got 401, attempting token refresh');
          final refreshSuccess = await _refreshToken();
          if (refreshSuccess) {
            log('Token refresh successful, retrying request');
            final newToken = await _getToken();
            return await request(newToken);
          }
          throw const CartException('Session expired. Please login again.');
        }

        final errorMessage = e.response?.data is Map ? 
          e.response?.data['error']?.toString() : 
          e.message;
        throw CartException(errorMessage ?? 'An unexpected error occurred');
      }
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      if (e is CartException) rethrow;
      throw CartException(e.toString());
    }
  }

  Future<CartResponse> addToCart(int productId) async {
    return _makeAuthenticatedRequest((token) async {
      final response = await _dio.post(
        '/cart/add/$productId/',
        options: Options(headers: _createAuthHeaders(token)),
      );

      if (response.statusCode == 200) {
        return CartResponse(
          message: response.data['message'] as String,
          cartQuantity: response.data['cart_quantity'] as int,
          isSuccess: true,
        );
      }

      throw CartException(
        response.data['error']?.toString() ?? 'Failed to add item to cart'
      );
    });
  }

  Future<CartModel> getCart() async {
    return _makeAuthenticatedRequest((token) async {
      final response = await _dio.get(
        '/viewcartitems/',
        options: Options(headers: _createAuthHeaders(token)),
      );

      log('Cart response: ${response.data}');

      if (response.statusCode == 200) {
        if (response.data is! Map<String, dynamic>) {
          throw const CartException('Invalid response format');
        }
        return CartModel.fromJson(response.data);
      }

      throw CartException(
        response.data['error']?.toString() ?? 'Failed to fetch cart'
      );
    });
  }

 Future<CartResponse> removeFromCart(int productId) async {
     return _makeAuthenticatedRequest((token) async {
       final response = await _dio.delete(
         '/removecart/$productId/', // Include productId in the URL path
         options: Options(headers: _createAuthHeaders(token)),
       );
        
       if (response.statusCode == 200) {
         return CartResponse(
           message: response.data['message'] as String,
           isSuccess: true,
         );
       }
        
       throw CartException(
         response.data['error']?.toString() ?? 'Failed to remove item'
       );
     });
}
  Future<CartResponse> updateQuantity(int productId, int quantity) async {
    return _makeAuthenticatedRequest((token) async {
      final response = await _dio.post(
        '/cart/update/$productId/',
        data: {'quantity': quantity},
        options: Options(headers: _createAuthHeaders(token)),
      );

      if (response.statusCode == 200) {
        return CartResponse(
          message: response.data['message'] as String,
          cartQuantity: quantity,
          isSuccess: true,
        );
      }

      throw CartException(
        response.data['error']?.toString() ?? 'Failed to update quantity'
      );
    });
  }


}
