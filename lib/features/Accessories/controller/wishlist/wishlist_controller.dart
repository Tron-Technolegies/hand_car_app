import 'dart:developer';

import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_response_model.dart';
import 'package:hand_car/features/Accessories/services/wishlist_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_controller.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
   @override
  FutureOr<Map<String, WishlistResponse>> build() async {
    // Check authentication
    if (!TokenStorage().hasTokens) {
      return {};
    }
    return {};
  }

  Future<void> addToWishlist(int productId) async {
    if (!TokenStorage().hasTokens) {
      throw Exception('Please login to continue');
    }

    state = const AsyncValue.loading();
    try {
      log('Adding product to wishlist: $productId');
      final response = await WishlistServices.addToWishlist(productId);
      
      // Update state with new wishlist item
      state = AsyncValue.data({
        ...state.value ?? {},
        productId.toString(): response,
      });

      log('Product added to wishlist successfully');
    } catch (error, stackTrace) {
      log('Error adding to wishlist: $error');
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (!TokenStorage().hasTokens) {
      throw Exception('Please login to continue');
    }

    state = const AsyncValue.loading();
    try {
      log('Removing product from wishlist: $productId');
      final success = await WishlistServices.removeFromWishlist(productId);
      
      if (success) {
        final currentState = Map<String, WishlistResponse>.from(state.value ?? {});
        currentState.remove(productId);
        state = AsyncValue.data(currentState);
        log('Product removed from wishlist successfully');
      } else {
        throw Exception('Failed to remove from wishlist');
      }
    } catch (error, stackTrace) {
      log('Error removing from wishlist: $error');
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  bool isInWishlist(String productId) {
    return state.value?.containsKey(productId) ?? false;
  }
}