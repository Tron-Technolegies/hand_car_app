import 'dart:developer';
import 'package:hand_car/core/exception/cart/cart_exception.dart';
import 'package:hand_car/features/Accessories/model/coupon/coupon_model.dart';
import 'package:hand_car/features/Accessories/model/cart/cart_model.dart';
import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  late final CartApiService _cartService;

  @override
  Future<CartModel> build() async {
    _cartService = CartApiService();
    if (!TokenStorage().hasValidTokens) {
      throw const CartException('Please login to view your cart');
    }
    return _fetchCart();
  }

  Future<void> addToCart(int productId) async {
    final previousState = state;
    try {
      if (!TokenStorage().hasValidTokens) {
        throw const CartException('Please login to continue');
      }
      log('Adding product to cart: $productId');
      final response = await _cartService.addToCart(productId.toString());
      log('Product added with quantity: ${response.cartQuantity}');
      if (response.isSuccess) {
        await refreshCart();
      } else {
        throw CartException(response.error ?? 'Failed to add item to cart');
      }
    } catch (e) {
      log('Error adding to cart: $e');
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
      throw CartException('Failed to fetch cart: $e');
    }
  }

  Future<void> refreshCart() async {
    state = const AsyncValue.loading();
    try {
      if (!TokenStorage().hasValidTokens) {
        throw const CartException('Please login to view your cart');
      }
      final cartResponse = await _fetchCart();
      state = AsyncValue.data(cartResponse);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
Future<void> removeFromCart(int cartItemId) async {
  final previousState = state;
  try {
    state.whenData((currentCart) {
      final updatedItems = currentCart.cartItems
          .where((item) => item.id != cartItemId) 
          .toList();
      state = AsyncValue.data(currentCart.copyWith(
        cartItems: updatedItems,
        isLoading: true,
      ));
    });
    await _cartService.removeFromCart(cartItemId);
    await refreshCart();
  } catch (e) {
    state = previousState;
    log('Error removing from cart: $e');
    if (e is CartException) rethrow;
    throw CartException('Failed to remove item: $e');
  }
}
 Future<void> updateQuantity(int cartItemId, int newQuantity) async {
  if (cartItemId <= 0) {
    throw CartException('Invalid cart item ID');
  }
  if (newQuantity < 1) {
    throw CartException('Quantity must be at least 1');
  }

  final previousState = state;
  try {
    state.whenData((currentCart) {
      final updatedItems = currentCart.cartItems.map((item) {
        if (item.id == cartItemId) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();
      state = AsyncValue.data(currentCart.copyWith(
        cartItems: updatedItems,
        isLoading: true,
      ));
    });
    await _cartService.updateQuantity(cartItemId, newQuantity);
    await refreshCart();
  } catch (e) {
    state = previousState;
    log('Error updating quantity: $e');
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

  // Update placeOrder to accept addressId
Future<String> placeOrder(String addressId) async {
  final previousState = state;
  try {
    if (!TokenStorage().hasValidTokens) {
      throw const CartException('Please login to place an order');
    }
    
    state = AsyncValue.loading();
    final whatsappUrl = await _cartService.placeOrder(addressId); // Pass addressId
    
    // Fetch updated empty cart from server
    await refreshCart();
    
    return whatsappUrl;
  } catch (e) {
    state = previousState;
    log('Error placing order: $e');
    if (e is CartException) rethrow;
    throw CartException('Failed to place order: $e');
  }
}
  double get cartTotal {
    return state.whenOrNull(
      data: (cart) => cart.discountedTotal,
    ) ?? 0.0;
  }
}