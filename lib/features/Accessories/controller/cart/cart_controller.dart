import 'package:hand_car/features/Accessories/services/cart_api_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hand_car/features/Accessories/controller/model/cart/cart_model.dart';

part 'cart_controller.g.dart';

@riverpod
class CartController extends _$CartController {
  @override
  Future<CartModel> build() async {
    final cartResponse = await CartApiService().getCart();
    return cartResponse ?? const CartModel();
  }

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

  // Updated total calculation
  double get cartTotal {
    return state.whenOrNull(
      data: (cart) => cart.totalAmount,
    ) ?? 0.0;
  }
  //remove item
  
}