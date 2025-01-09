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
      final response = await _cartService.addToCart(productId.toString());
      
      log('Product added successfully with quantity: ${response.cartQuantity}');

      // Only refresh cart if the addition was successful
      if (response.isSuccess) {
        await refreshCart();
      } else {
        throw CartException(response.error ?? 'Failed to add item to cart');
      }

    } catch (e) {
      log('Error adding to cart: $e');
      // Restore previous state on error
      state = previousState;
      rethrow;
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
Future<void> updateQuantity(int productId, int newQuantity) async {
  if (productId <= 0) {
    throw CartException('Invalid product ID');
  }
  
  if (newQuantity < 1) {
    throw CartException('Quantity must be at least 1');
  }

  final previousState = state;
  try {
    state.whenData((currentCart) {
      final currentItem = currentCart.cartItems.firstWhere(
        (item) => item.productId == productId,
        orElse: () => throw CartException('Product not found in cart'),
      );

      // Calculate quantity difference
      final quantityDiff = newQuantity - currentItem.quantity;
      
      if (quantityDiff == 0) return; // No change needed
      
      // Optimistically update UI
      final updatedItems = currentCart.cartItems.map((item) {
        if (item.productId == productId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();

      state = AsyncValue.data(currentCart.copyWith(
        cartItems: updatedItems,
        isLoading: true,
      ));

      // If quantity increased, we need to add more items
      if (quantityDiff > 0) {
        for (var i = 0; i < quantityDiff; i++) {
          _cartService.addToCart(productId.toString());
        }
      }
      // If quantity decreased, we need to remove items
      else {
        
        // For now, just refresh the cart to sync with server
      }
    });

    // Refresh cart to get updated state from server
    await refreshCart();
  } catch (e) {
    log('Error updating quantity: $e');
    state = previousState;
    rethrow;
  }
}

    void applyCoupon(CouponModel coupon) {
    if (state.value != null) {
      final currentCart = state.value!;
      state = AsyncValue.data(
        CartModel(
          cartItems: currentCart.cartItems,
         
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
