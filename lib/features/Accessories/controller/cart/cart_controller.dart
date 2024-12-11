// 

import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  Future<CartModel> build() async {
    final cartResponse = await CartApiService().getCart();
    return cartResponse ?? const CartModel();
  }

  /// Refresh Cart
  Future<void> refreshCart() async {
    state = const AsyncValue.loading();
    try {
      final cartResponse = await CartApiService().getCart();
      if (cartResponse != null) {
        state = AsyncValue.data(cartResponse);
      } else {
        state = AsyncValue.error(
          'Failed to fetch cart data',
          StackTrace.current,
        );
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Error refreshing cart: $e', stackTrace);
    }
  }

  /// Add to Cart
  Future<void> addToCart(int productId) async {
    try {
      final response = await CartApiService().addToCart(productId);
      if (response['success']) {
        await refreshCart();
      } else {
        state = AsyncValue.error(response['message'], StackTrace.current);
      }
    } catch (e, stackTrace) {
      state = AsyncValue.error('Error adding to cart: $e', stackTrace);
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