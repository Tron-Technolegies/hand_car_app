import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:hand_car/config.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/core/exception/cart/cart_exception.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_response.dart';

class CartApiService {
  final _dio = Dio(BaseOptions(
    baseUrl: baseUrl,
    validateStatus: (status) => status! < 500,
  ));

  final _tokenStorage = TokenStorage();

  Future<T> _makeAuthenticatedRequest<T>(Future<T> Function() request) async {
    try {
      final accessToken = _tokenStorage.getAccessToken();
      final refreshToken = _tokenStorage.getRefreshToken();

      if (accessToken == null) {
        throw CartException('No access token found');
      }

      _dio.options.headers['Cookie'] = _createCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );
      _dio.options.headers['Authorization'] = 'Bearer $accessToken';

      return await request();
    } on DioException catch (e) {
      log('DioException: ${e.message}, Status: ${e.response?.statusCode}, Data: ${e.response?.data}');
      if (e.response?.statusCode == 401) {
        await _handleTokenExpiration();
        return await request();
      }
      String errorMessage;
      if (e.response?.data is Map<String, dynamic>) {
        errorMessage = e.response?.data['error']?.toString() ??
            'Request failed: ${e.message}';
      } else if (e.response?.data is String &&
          e.response?.data.contains('<!doctype html>')) {
        errorMessage =
            'Server returned an unexpected HTML response (404 Not Found)';
      } else {
        errorMessage = 'Request failed: ${e.message}';
      }
      throw CartException(errorMessage);
    } catch (e) {
      log('Unexpected error: $e');
      throw CartException('An unexpected error occurred: $e');
    }
  }

  Future<void> _handleTokenExpiration() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clearTokens();
      throw CartException('Session expired, please login again');
    }

    try {
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        await _tokenStorage.saveTokens(
          accessToken: response.data['access'],
          refreshToken: refreshToken,
        );
      } else {
        await _tokenStorage.clearTokens();
        throw CartException('Session expired, please login again');
      }
    } catch (e) {
      await _tokenStorage.clearTokens();
      throw CartException('Session expired, please login again');
    }
  }

  String _createCookieHeader(
      {required String accessToken, String? refreshToken}) {
    final cookies = [
      'access_token=$accessToken',
      if (refreshToken != null) 'refresh_token=$refreshToken',
    ];
    return cookies.join('; ');
  }

  Future<CartResponse> addToCart(String productId) async {
    return _makeAuthenticatedRequest(() async {
      log('Adding product to cart: $productId');
      final response = await _dio.post(
        '/add_to_cart/$productId/',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      log('Add to cart response: ${response.data}');
      try {
        final cartResponse = CartResponse.fromJson(response.data);
        if (!cartResponse.isSuccess) {
          throw CartException(
              cartResponse.error ?? 'Failed to add item to cart');
        }
        return cartResponse;
      } catch (e) {
        throw CartException('Invalid response format: $e');
      }
    });
  }

  Future<CartModel> getCart() async {
    return _makeAuthenticatedRequest(() async {
      log('Fetching cart from $baseUrl/display_cart');
      final response = await _dio.get(
        '/display_cart',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );
      log('Cart response: status=${response.statusCode}, data=${response.data}');
      if (response.statusCode == 200) {
        try {
          return CartModel.fromJson(response.data);
        } catch (e) {
          log('Error parsing cart: $e');
          throw CartException('Failed to parse cart: $e');
        }
      }
      String errorMessage;
      if (response.data is Map<String, dynamic>) {
        errorMessage =
            response.data['error']?.toString() ?? 'Failed to fetch cart';
      } else if (response.data is String &&
          response.data.contains('<!doctype html>')) {
        errorMessage =
            'Server returned an unexpected HTML response (404 Not Found)';
      } else {
        errorMessage = 'Failed to fetch cart: ${response.statusCode}';
      }
      throw CartException(errorMessage);
    });
  }

  Future<void> removeFromCart(int cartItemId) async {
    return _makeAuthenticatedRequest(() async {
      log('Removing item from cart: $cartItemId');
      final response = await _dio.delete(
        '/removecart/$cartItemId/',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      log('Remove from cart response: ${response.data}');
      if (response.statusCode != 200) {
        String errorMessage;
        if (response.data is Map<String, dynamic>) {
          errorMessage =
              response.data['error']?.toString() ?? 'Failed to remove item';
        } else if (response.data is String &&
            response.data.contains('<!doctype html>')) {
          errorMessage =
              'Server returned an unexpected HTML response (404 Not Found)';
        } else {
          errorMessage = 'Failed to remove item: ${response.statusCode}';
        }
        throw CartException(errorMessage);
      }
    });
  }

  Future<void> updateQuantity(int cartItemId, int quantity) async {
    return _makeAuthenticatedRequest(() async {
      log('Updating quantity for cart item $cartItemId to $quantity at $baseUrl/update_cart_item/$cartItemId/');
      final response = await _dio.put(
        '/update_cart/$cartItemId/',
        data: {'quantity': quantity},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      log('Update quantity response: status=${response.statusCode}, data=${response.data}');
      if (response.statusCode != 200) {
        String errorMessage;
        if (response.data is Map<String, dynamic>) {
          errorMessage =
              response.data['error']?.toString() ?? 'Failed to update quantity';
        } else if (response.data is String &&
            response.data.contains('<!doctype html>')) {
          errorMessage = 'Invalid cart item ID or server error (404 Not Found)';
        } else {
          errorMessage = 'Failed to update quantity: ${response.statusCode}';
        }
        throw CartException(errorMessage);
      }
    });
  }
}
