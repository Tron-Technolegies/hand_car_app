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
      // Get both tokens
      final accessToken = _tokenStorage.getAccessToken();
      final refreshToken = _tokenStorage.getRefreshToken();

      if (accessToken == null) {
        throw CartException('No access token found');
      }

      // Set cookies in Dio
      _dio.options.headers['Cookie'] = _createCookieHeader(
        accessToken: accessToken,
        refreshToken: refreshToken,
      );

      return await request();
    } on DioException catch (e) {
      log('DioException in _makeAuthenticatedRequest: ${e.message}');
      if (e.response?.statusCode == 401) {
        // Token expired or invalid
        await _handleTokenExpiration();
        // Retry the request once after handling token expiration
        return await request();
      }
      throw CartException(e.response?.data?['error']?.toString() ?? 'Request failed: ${e.message}');
    } catch (e) {
      log('Error in _makeAuthenticatedRequest: $e');
      throw CartException('An unexpected error occurred');
    }
  }

  Future<void> _handleTokenExpiration() async {
    final refreshToken = _tokenStorage.getRefreshToken();
    if (refreshToken == null) {
      await _tokenStorage.clearTokens();
      throw CartException('Session expired, please login again');
    }

    try {
      // Call your refresh token endpoint
      final response = await _dio.post(
        '/api/token/refresh/',
        data: {'refresh': refreshToken},
      );

      if (response.statusCode == 200) {
        // Save the new tokens
        await _tokenStorage.saveTokens(
          accessToken: response.data['access'],
          refreshToken: refreshToken, // Keep the same refresh token
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

  String _createCookieHeader({required String accessToken, String? refreshToken}) {
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
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      
      log('Add to cart response: ${response.data}');
      
      // Parse response into CartResponse object
      final cartResponse = CartResponse.fromJson(response.data);
      
      // Only throw an error if the response indicates failure
      if (!cartResponse.isSuccess) {
        throw CartException(cartResponse.error ?? 'Failed to add item to cart');
      }
      
      return cartResponse;
    });
  }

  Future<CartModel> getCart() async {
    return _makeAuthenticatedRequest(() async {
      log('Fetching cart');
      
      final response = await _dio.get(
        '/display_cart',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${_tokenStorage.getAccessToken()}'
            },
          
        ),
      );
      
      log('Cart response: ${response.data}');
      
      if (response.statusCode == 200) {
        return CartModel.fromJson(response.data);
      }
      
      throw CartException(
        response.data['error']?.toString() ?? 'Failed to fetch cart'
      );
    });
  }

  Future<void> removeFromCart(int itemId) async {
    return _makeAuthenticatedRequest(() async {
      final response = await _dio.post(
        '/removecart/',
        data: FormData.fromMap({'item_id': itemId}),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${_tokenStorage.getAccessToken()}'
            },
        ),
      );
      
      if (response.statusCode != 200) {
        throw CartException(
          response.data['error']?.toString() ?? 'Failed to remove item from cart'
        );
      }
    });
  }

  Future<CartResponse> updateQuantity(String productId, int quantity) async {
    if (quantity < 1) {
      throw CartException('Quantity cannot be less than 1');
    }

    try {
      // Add to cart the required number of times
      CartResponse lastResponse;
      int currentQuantity = 0;
      int targetQuantity = quantity;

      while (currentQuantity < targetQuantity) {
        lastResponse = await addToCart(productId);
        currentQuantity = lastResponse.cartQuantity;
        
        // Safety check
        if (currentQuantity >= targetQuantity) break;
      }

      return CartResponse(
        message: 'Quantity updated successfully',
        cartQuantity: quantity,
        isSuccess: true,
      );
    } catch (e) {
      log('Error updating quantity: $e');
      throw CartException('Failed to update quantity: $e');
    }
  }
}
