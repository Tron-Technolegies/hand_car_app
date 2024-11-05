import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/controller/model/cart/cart_model.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  CartModel build() {
    return const CartModel();
  }

  void getCart() async {
    final cart = await CartApiService.getCart();
    state = cart ?? const CartModel();
  }

  void removeFromCart(String itemId) {
    final updatedItems = state.cartItems.where((item) => item.id != itemId).toList();
    state = state.copyWith(
      cartItems: updatedItems,
      totalPrice: _calculateTotal(updatedItems)
    );
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }

    final updatedItems = state.cartItems.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = state.copyWith(
      cartItems: updatedItems,
      totalPrice: _calculateTotal(updatedItems)
    );
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  void clearCart() {
    state = const CartModel();
  }
}
