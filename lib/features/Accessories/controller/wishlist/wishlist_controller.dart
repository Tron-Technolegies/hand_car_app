
import 'dart:developer';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';
import 'package:hand_car/features/Accessories/services/wishlist_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_controller.g.dart';

@riverpod
class WishlistNotifier extends _$WishlistNotifier {
  @override
  FutureOr<Map<String, WishlistResponse>> build() async {
    if (!TokenStorage().hasValidTokens) {
      return {};
    }

    try {
      final service = ref.read(wishlistServicesProvider);
      final response = await service.getWishlist();

      final Map<String, WishlistResponse> wishlistMap = {};
      for (var item in response.values) {
        wishlistMap[item.id.toString()] = item; // Use id
      }
      return wishlistMap;
    } catch (error) {
      log('Error fetching wishlist: $error');
      return {};
    }
  }

  Future<void> fetchWishlist() async {
    if (!TokenStorage().hasValidTokens) {
      state = const AsyncValue.data({});
      return;
    }

    state = const AsyncValue.loading();
    try {
      final service = ref.read(wishlistServicesProvider);
      final response = await service.getWishlist();

      final Map<String, WishlistResponse> wishlistMap = {};
      for (var item in response.values) {
        wishlistMap[item.id.toString()] = item; // Use id
      }
      state = AsyncValue.data(wishlistMap);
      log('Wishlist fetched: $wishlistMap');
    } catch (error, stackTrace) {
      log('Error fetching wishlist: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addToWishlist(int productId) async {
    if (!TokenStorage().hasValidTokens) {
      throw Exception('Please login to continue');
    }

    final previousState = state.value ?? {};
    state = const AsyncValue.loading();
    
    try {
      log('Adding product to wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final response = await service.addToWishlist(productId);

      if (response == null) {
        log('No new wishlist item added (possibly already in wishlist)');
        state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
        return;
      }

      final currentItems = Map<String, WishlistResponse>.from(previousState);
      final itemKey = response.id.toString(); // Use id
      currentItems[itemKey] = response;
      
      state = AsyncValue.data(currentItems);
      log('Product added to wishlist successfully: ID ${response.id}');
      
    } catch (error, stackTrace) {
      log('Error adding to wishlist: $error');
      state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (!TokenStorage().hasValidTokens) {
      throw Exception('Please login to continue');
    }

    final previousState = state.value ?? {};
    state = const AsyncValue.loading();
    
    try {
      log('Removing product from wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final success = await service.removeFromWishlist(productId);

      if (success) {
        final currentItems = Map<String, WishlistResponse>.from(previousState);
        currentItems.remove(productId);
        state = AsyncValue.data(currentItems);
        log('Product removed from wishlist successfully');
      } else {
        state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
        throw Exception('Failed to remove from wishlist');
      }
    } catch (error, stackTrace) {
      log('Error removing from wishlist: $error');
      state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
      if (error.toString().contains('Product not found in wishlist')) {
        log('Product not in wishlist, treated as successful removal');
        final currentItems = Map<String, WishlistResponse>.from(previousState);
        currentItems.remove(productId);
        state = AsyncValue.data(currentItems);
      } else {
        state = AsyncValue.error(error, stackTrace);
        rethrow;
      }
    }
  }

  bool isInWishlist(String productId) {
    return state.value?.containsKey(productId) ?? false;
  }

  bool isInWishlistById(int productId) {
    return isInWishlist(productId.toString());
  }
}

@riverpod
WishlistServices wishlistServices(ref) {
  return WishlistServices();
}
