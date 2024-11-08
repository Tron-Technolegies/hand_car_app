import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/controller/model/cart/cart_model.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  Future<CartModel?> build() async {
    final cart = await CartApiService.getCart();
    return cart ?? const CartModel();
  }

  void getCart() async {
    final cart = await CartApiService.getCart();
    state = AsyncValue.data(cart ?? const CartModel());
  }

  void removeFromCart(String itemId) {
    final updatedItems =
        state.value!.cartItems.where((item) => item.id != itemId).toList();
    state = AsyncValue.data(state.value!.copyWith(
        cartItems: updatedItems, totalPrice: _calculateTotal(updatedItems)));
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity <= 0) {
      removeFromCart(itemId);
      return;
    }

    final updatedItems = state.value!.cartItems.map((item) {
      if (item.id == itemId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();

    state = AsyncValue.data(state.value!.copyWith(
        cartItems: updatedItems, totalPrice: _calculateTotal(updatedItems)));
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  void clearCart() {
    state = AsyncValue.data(const CartModel() );
  }
}
