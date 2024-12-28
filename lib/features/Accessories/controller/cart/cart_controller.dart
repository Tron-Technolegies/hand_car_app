import 'dart:developer';

import 'package:hand_car/core/exception/cart/cart_exception.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:hand_car/core/router/user_validation.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  late final CartApiService _cartService;

  @override
  Future<CartModel> build() async {
    _cartService = CartApiService();
    if (!TokenStorage().hasTokens) {
      throw const CartException('Please login to view your cart');
    }
    return _fetchCart();
  }

  Future<void> addToCart(int productId) async {
    final previousState = state;
    try {
      // Check authentication first
      if (!TokenStorage().hasTokens) {
        throw const CartException('Please login to continue');
      }

      log('Adding product to cart: $productId');

      // Make API call first
      final response = await _cartService.addToCart(productId);
      
      if (!response.isSuccess) {
        throw CartException(response.error ?? 'Failed to add item to cart');
      }

      log('Product added successfully, refreshing cart');

      // Only update UI after successful API call
      await refreshCart();

    } catch (e) {
      log('Error adding to cart: $e');
      // Restore previous state on error
      state = previousState;
      rethrow; // Rethrow to handle in UI
    }
  }

  Future<CartModel> _fetchCart() async {
    try {
      return await _cartService.getCart();
    } catch (e) {
      log('Error fetching cart: $e');
      if (e is CartException) rethrow;
      throw CartException('Failed to fetch cart: ${e.toString()}');
    }
  }

  Future<void> refreshCart() async {
    state = const AsyncValue.loading();
    try {
      if (!TokenStorage().hasTokens) {
        throw const CartException('Please login to view your cart');
      }
      final cartResponse = await _fetchCart();
      state = AsyncValue.data(cartResponse);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  Future<void> removeFromCart(int productId) async {
    final previousState = state;
    try {
      // Optimistically update UI
      state.whenData((currentCart) {
        final updatedItems = currentCart.cartItems
            .where((item) => item.productId != productId)
            .toList();

        state = AsyncValue.data(currentCart.copyWith(
          cartItems: updatedItems,
          isLoading: true,
        ));
      });

      await _cartService.removeFromCart(productId);
      
      if (!state.isLoading) {
        state = previousState;
        return;
      }

      // Force refresh to get updated cart
      await refreshCart();
    } catch (e) {
      if (!state.isLoading) return;
      state = previousState;
      if (e is CartException) rethrow;
      throw CartException('Failed to remove item: ${e.toString()}');
    }
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    if (quantity < 1) return;
    
    final previousState = state;
    try {
      // Optimistically update UI
      state.whenData((currentCart) {
        final updatedItems = currentCart.cartItems.map((item) {
          if (item.productId == productId) {
            return item.copyWith(quantity: quantity);
          }
          return item;
        }).toList();

        state = AsyncValue.data(currentCart.copyWith(
          cartItems: updatedItems,
          isLoading: true,
        ));
      });

      await _cartService.updateQuantity(productId, quantity);
      
      if (!state.isLoading) {
        state = previousState;
        return;
      }

      // Force refresh to get updated cart
      await refreshCart();
    } catch (e) {
      if (!state.isLoading) return;
      state = previousState;
      if (e is CartException) rethrow;
      throw CartException('Failed to update quantity: ${e.toString()}');
    }
  }
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

  // Computed properties

  
}
