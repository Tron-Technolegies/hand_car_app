import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/core/exception/cart/cart_exception.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_response.dart';

class CartApiService {
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

  Map<String, String> _createAuthHeaders(String token) {
    final tokenValue = token.startsWith('Bearer ') ? token : 'Bearer $token';
    return {
      'Authorization': tokenValue,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  Future<T> _makeAuthenticatedRequest<T>(
    Future<T> Function(String token) request
  ) async {
    try {
      // Check token expiration first
      if (TokenStorage().isAccessTokenExpired()) {
        log('Access token expired, attempting refresh');
        final refreshSuccess = await _refreshToken();
        if (!refreshSuccess) {
          throw const CartException('Session expired. Please login again.');
        }
      }

      final token = await _getToken();
      try {
        return await request(token);
      } on DioException catch (e) {
        log('DioException in request: ${e.message}');
        log('Response status: ${e.response?.statusCode}');
        log('Response data: ${e.response?.data}');

        if (e.response?.statusCode == 401 || 
            (e.response?.data != null && e.response?.data['code'] == 'token_not_valid')) {
          log('Token invalid, attempting refresh');
          final refreshSuccess = await _refreshToken();
          if (refreshSuccess) {
            final newToken = await _getToken();
            return await request(newToken);
          }
          throw const CartException('Session expired. Please login again.');
        }

        final errorMessage = e.response?.data?['detail']?.toString() ??
                           e.response?.data?['error']?.toString() ??
                           'An error occurred';
        throw CartException(errorMessage);
      }
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      if (e is CartException) rethrow;
      throw CartException(e.toString());
    }
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = TokenStorage().getRefreshToken();
      if (refreshToken == null || refreshToken.isEmpty) {
        log('No refresh token available');
        return false;
      }

      log('Attempting token refresh');
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );

      log('Refresh token response: ${response.statusCode}');

      if (response.statusCode == 200 && response.data != null) {
        final newAccessToken = response.data['access']?.toString();
        if (newAccessToken != null && newAccessToken.isNotEmpty) {
          await TokenStorage().saveTokens(
            accessToken: newAccessToken,
            refreshToken: refreshToken,
          );
          log('Token refresh successful');
          return true;
        }
      }
      
      log('Token refresh failed: ${response.data}');
      return false;
    } catch (e) {
      log('Token refresh error: $e');
      return false;
    }
  }

  Future<String> _getToken() async {
    final token = TokenStorage().getAccessToken();
    if (token == null || token.isEmpty) {
      throw const CartException('Please login to continue');
    }
    return token;
  }

  Future<CartResponse> addToCart(int productId) async {
    return _makeAuthenticatedRequest((token) async {
      log('Adding product to cart: $productId');
      
      final response = await _dio.post(
        '/cart/add/$productId/',
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Add to cart response: ${response.data}');

      if (response.statusCode == 200) {
        return CartResponse(
          message: response.data['message'] as String? ?? 'Product added to cart',
          cartQuantity: response.data['cart_quantity'] as int? ?? 1,
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
      log('Fetching cart');
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
      log('Removing product from cart: $productId');
      
      final response = await _dio.delete(
        '/removecart/$productId/',
        options: Options(
          headers: _createAuthHeaders(token),
        ),
      );

      log('Remove from cart response: ${response.data}');

      if (response.statusCode == 200) {
        return CartResponse(
          message: response.data['message'] as String? ?? 'Item removed from cart',
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
      log('Updating quantity for product: $productId to $quantity');
      
      final response = await _dio.post(
        '/cart/update/$productId/',
        data: {'quantity': quantity},
        options: Options(headers: _createAuthHeaders(token)),
      );

      log('Update quantity response: ${response.data}');

      if (response.statusCode == 200) {
        return CartResponse(
          message: response.data['message'] as String? ?? 'Quantity updated',
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