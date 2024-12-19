// 

import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  Future<CartModel> build() async {
    if (!TokenStorage().hasTokens) {
      throw Exception('Please login to view your cart');
    }
    return _fetchCart();
  }

  Future<CartModel> _fetchCart() async {
    try {
      final cartService = CartApiService();
      final cart = await cartService.getCart();
      if (cart == null) {
        throw Exception('Failed to fetch cart');
      }
      return cart;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> refreshCart() async {
    state = const AsyncValue.loading();
    try {
      if (!TokenStorage().hasTokens) {
        throw Exception('Please login to view your cart');
      }
      final cartResponse = await _fetchCart();
      state = AsyncValue.data(cartResponse);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e.toString(), stackTrace);
    }
  }

  /// Add to Cart
  Future<void> addToCart(int productId) async {
    state = const AsyncValue.loading(); // Set loading state
    try {
      final response = await CartApiService().addToCart(productId);

      // Extract cart quantity or display success message
      if (response['cart_quantity'] != null) {
        state = AsyncValue.data(response['cart_quantity']);
      } else {
        throw Exception('Failed to update cart: ${response['message']}');
      }
    } catch (e, stackTrace) {
      // Handle errors
      state = AsyncValue.error(e, stackTrace);
    }
  }

  /// Remove from Cart
  // Future<void> removeFromCart(int productId) async {
  //   try {
  //     final response = await CartApiService().removeFromCart(productId);
  //     if (response['success']) {
  //       await refreshCart();
  //     } else {
  //       state = AsyncValue.error(response['message'], StackTrace.current);
  //     }
  //   } catch (e, stackTrace) {
  //     state = AsyncValue.error('Error removing item from cart: $e', stackTrace);
  //   }
  // }

  /// Apply a Coupon
  void applyCoupon(CouponModel coupon) {
    if (state.value != null) {
      final currentCart = state.value!;
      state = AsyncValue.data(
        CartModel(
          cartItems: currentCart.cartItems,
          totalAmount: currentCart.totalAmount,
          appliedCoupon: coupon,
        ),
      );
    }
  }

  /// Calculate Total Amount
  double get cartTotal {
    return state.whenOrNull(
      data: (cart) => cart.discountedTotal,
    ) ?? 0.0;
  }
}