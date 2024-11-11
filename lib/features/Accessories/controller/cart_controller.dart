import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/controller/model/cart/cart_model.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  Future<CartModel> build() async {
    final cartResponse = await CartApiService.getCart();
    if (cartResponse['success'] == true) {
      return CartModel(
        cartItems: (cartResponse['cart'] as List)
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList(),
        totalPrice: (cartResponse['total'] as num).toDouble(),
      );
    } else {
      // Return an empty cart model in case of an error
      return CartModel(cartItems: [], totalPrice: 0.0);
    }
  }

  // Method to refresh the cart items
  Future<void> getCart() async {
    final cartResponse = await CartApiService.getCart();
    if (cartResponse['success'] == true) {
      final cartModel = CartModel(
        cartItems: (cartResponse['cart'] as List)
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList(),
        totalPrice: (cartResponse['total'] as num).toDouble(),
      );
      state = AsyncValue.data(cartModel);
    } else {
      state = AsyncValue.error('Failed to fetch cart data', StackTrace.current);
    }
  }

  // Method to remove an item from the cart
  void removeFromCart(String productName) {
    final updatedItems = state.value?.cartItems
            .where((item) => item.productName != productName)
            .toList() ??
        [];
    state = AsyncValue.data(
      state.value!.copyWith(
        cartItems: updatedItems,
        totalPrice: _calculateTotal(updatedItems),
      ),
    );
  }

  // Method to update the quantity of a cart item
  void updateQuantity(String productName, int quantity) {
    if (quantity <= 0) {
      removeFromCart(productName);
      return;
    }

    final updatedItems = state.value?.cartItems.map((item) {
      if (item.productName == productName) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    if (updatedItems != null) {
      state = AsyncValue.data(
        state.value!.copyWith(
          cartItems: updatedItems,
          totalPrice: _calculateTotal(updatedItems),
        ),
      );
    }
  }

  // Method to calculate the total price of items in the cart
  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (total, item) => total + (item.productPrice * item.quantity));
  }

  // Method to clear the cart
  void clearCart() {
    state = AsyncValue.data(CartModel(cartItems: [], totalPrice: 0.0));
  }
}