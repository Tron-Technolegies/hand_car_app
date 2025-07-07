import 'dart:developer';
import 'package:hand_car/core/router/user_validation.dart';
import 'package:hand_car/features/Accessories/model/wishlist/wishlist_model.dart';
import 'package:hand_car/features/Accessories/services/wishlist_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'wishlist_controller.g.dart';

@Riverpod(keepAlive: true)
class WishlistNotifier extends _$WishlistNotifier {
  @override
  FutureOr<Map<String, WishlistResponse>> build() async {
    if (!TokenStorage().hasValidTokens) {
      log('WishlistNotifier: No valid tokens, returning empty wishlist');
      return {};
    }

    try {
      final service = ref.read(wishlistServicesProvider);
      final response = await service.getWishlist();

      final Map<String, WishlistResponse> wishlistMap = {};
      for (var item in response.values) {
        wishlistMap[item.id.toString()] = item;
      }
      log('WishlistNotifier: Initialized with ${wishlistMap.length} items');
      return wishlistMap;
    } catch (error, stackTrace) {
      log('WishlistNotifier: Error fetching wishlist: $error\n$stackTrace');
      return {};
    }
  }

  Future<void> fetchWishlist() async {
    if (!TokenStorage().hasValidTokens) {
      state = const AsyncValue.data({});
      log('WishlistNotifier: No valid tokens, cleared wishlist');
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
      log('WishlistNotifier: Fetched wishlist: ${wishlistMap.length} items');
    } catch (error, stackTrace) {
      log('WishlistNotifier: Error fetching wishlist: $error\n$stackTrace');
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> addToWishlist(int productId, {String? productName}) async {
    if (!TokenStorage().hasValidTokens) {
      throw Exception('Please login to continue');
    }

    final previousState = state.value ?? {};
    
    // Optimistic update: temporarily add to wishlist
    final optimisticState = Map<String, WishlistResponse>.from(previousState);
    final tempWishlistItem = WishlistResponse(
      id: productId,
      productName: productName ?? 'Unknown Product',
      productPrice: 0.0,
      productImage: null,
      productDescription: null,
    );
    optimisticState[productId.toString()] = tempWishlistItem;
    state = AsyncValue.data(optimisticState);

    try {
      log('WishlistNotifier: Adding product to wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final response = await service.addToWishlist(productId, productName: productName);

      // Update with actual response
      final currentItems = Map<String, WishlistResponse>.from(previousState);
      currentItems[response.id.toString()] = response;
      state = AsyncValue.data(currentItems);

      log('WishlistNotifier: Product added to wishlist: ID ${response.id}, Name: ${response.productName}');
    } catch (error, stackTrace) {
      log('WishlistNotifier: Error adding to wishlist: $error\n$stackTrace');
      // Revert to previous state on error
      state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
      rethrow;
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (!TokenStorage().hasValidTokens) {
      throw Exception('Please login to continue');
    }

    final previousState = state.value ?? {};
    
    // Optimistic update: temporarily remove from wishlist
    final optimisticState = Map<String, WishlistResponse>.from(previousState);
    optimisticState.remove(productId);
    state = AsyncValue.data(optimisticState);

    try {
      log('WishlistNotifier: Removing product from wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final success = await service.removeFromWishlist(productId);

      if (success) {
        // Keep the optimistic state since it was successful
        log('WishlistNotifier: Product removed from wishlist: $productId');
      } else {
        // Revert to previous state if removal failed
        state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
        throw Exception('Failed to remove from wishlist');
      }
    } catch (error, stackTrace) {
      log('WishlistNotifier: Error removing from wishlist: $error\n$stackTrace');
      
      if (error.toString().contains('Product not found in wishlist')) {
        // If product wasn't in wishlist, keep it removed
        log('WishlistNotifier: Product not in wishlist, treated as removed');
      } else {
        // Revert to previous state on other errors
        state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
        rethrow;
      }
    }
  }

  Future<void> toggleWishlist(int productId, {String? productName}) async {
    final productIdStr = productId.toString();
    final wasInWishlist = isInWishlist(productIdStr);
    
    if (wasInWishlist) {
      await removeFromWishlist(productIdStr);
    } else {
      await addToWishlist(productId, productName: productName);
    }
    
    log('WishlistNotifier: Toggled wishlist for product ID: $productId, wasInWishlist: $wasInWishlist, nowInWishlist: ${isInWishlist(productIdStr)}');
  }

  bool isInWishlist(String productId) {
    return state.value?.containsKey(productId) ?? false;
  }

  bool isInWishlistById(int productId) {
    return isInWishlist(productId.toString());
  }

  // Method to clear wishlist (useful for logout)
  void clearWishlist() {
    state = const AsyncValue.data({});
    log('WishlistNotifier: Wishlist cleared');
  }

  // Method to invalidate and refetch wishlist
  Future<void> refresh() async {
    await fetchWishlist();
  }
}

@riverpod
WishlistServices wishlistServices(ref) {
  return WishlistServices();
}