import 'package:hand_car/features/Accessories/model/wishlist/wishlist_response_model.dart';
import 'package:hand_car/features/Accessories/services/wishlist_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_controller.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  @override
  FutureOr<Map<String, WishlistResponse>> build() async {
    // Initialize with empty map
    return {};
  }

  Future<void> addToWishlist(int productId) async {
    state = const AsyncValue.loading();
    
    try {
      final repository = WishlistServices.addToWishlist(productId);
     
      
      // Update state by adding new item to map
      state = AsyncValue.data({
        ...state.value ?? {},
        productId.toString(): WishlistResponse(productId: productId.toString(), message: ''),
      });
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    state = const AsyncValue.loading();
    
    try {
      final currentState = state.value ?? {};
      currentState.remove(productId);
      
      state = AsyncValue.data(currentState);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}