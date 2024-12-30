import 'dart:developer';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';
import 'package:hand_car/features/Accessories/services/wishlist_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_controller.g.dart';

// Add provider for WishlistServices
@riverpod
WishlistServices wishlistServices(ref) {
  return WishlistServices();
}

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  @override
  FutureOr<Map<String, WishlistResponse>> build() async {
    // Check authentication
    if (!TokenStorage().hasTokens) {
      return {};
    }

    try {
      final service = ref.read(wishlistServicesProvider);
      final response = await service.getWishlist();

      // Convert response data to Map<String, WishlistResponse>
      final Map<String, WishlistResponse> wishlistMap = {};
      for (var item in response.values) {
        wishlistMap[item.id.toString()] = item;
      }
      return wishlistMap;
    } catch (error) {
      log('Error fetching wishlist: $error');
      return {};
    }
  }

  Future<void> fetchWishlist() async {
    if (!TokenStorage().hasTokens) {
      state = const AsyncValue.data({});
      return;
    }

    state = const AsyncValue.loading();
    try {
      final service = ref.read(wishlistServicesProvider);
      final response = await service.getWishlist();

      final Map<String, WishlistResponse> wishlistMap = {};
      for (var item in response.values) {
        wishlistMap[item.id.toString()] = item;
      }
      state = AsyncValue.data(wishlistMap);
    } catch (error, stackTrace) {
      log('Error fetching wishlist: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addToWishlist(int productId) async {
    if (!TokenStorage().hasTokens) {
      throw Exception('Please login to continue');
    }

    state = const AsyncValue.loading();
    try {
      log('Adding product to wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final response = await service.addToWishlist(productId);

      final currentItems =
          Map<String, WishlistResponse>.from(state.value ?? {});
      currentItems[productId.toString()] = response;
      state = AsyncValue.data(currentItems);

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
      final service = ref.read(wishlistServicesProvider); // Fixed this line
      final success = await service.removeFromWishlist(productId);

      if (success) {
        final currentItems =
            Map<String, WishlistResponse>.from(state.value ?? {});
        currentItems.remove(productId);
        state = AsyncValue.data(currentItems);
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
