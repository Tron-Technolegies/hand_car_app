
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

  Future<void> addToWishlist(int productId) async {
    if (!TokenStorage().hasValidTokens) {
      state = AsyncValue.error('Please login to continue', StackTrace.current);
      return;
    }

    final previousState = state.value ?? {};
    state = const AsyncValue.loading();

    try {
      log('WishlistNotifier: Adding product to wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final response = await service.addToWishlist(productId);

      final currentItems = Map<String, WishlistResponse>.from(previousState);
      final itemKey = response.id.toString();
      currentItems[itemKey] = response;

      state = AsyncValue.data(currentItems);
      log('WishlistNotifier: Product added to wishlist: ID ${response.id}');
    } catch (error, stackTrace) {
      log('WishlistNotifier: Error adding to wishlist: $error\n$stackTrace');
      state = AsyncValue.data(Map<String, WishlistResponse>.from(previousState));
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }

  Future<void> removeFromWishlist(String productId) async {
    if (!TokenStorage().hasValidTokens) {
      state = AsyncValue.error('Please login to continue', StackTrace.current);
      return;
    }

    final previousState = state.value ?? {};
    state = const AsyncValue.loading();

    try {
      log('WishlistNotifier: Removing product from wishlist: $productId');
      final service = ref.read(wishlistServicesProvider);
      final success = await service.removeFromWishlist(productId);

      final currentItems = Map<String, WishlistResponse>.from(previousState);
      if (success) {
        currentItems.remove(productId);
        state = AsyncValue.data(currentItems);
        log('WishlistNotifier: Product removed from wishlist: $productId');
      } else {
        state = AsyncValue.data(currentItems);
        throw Exception('Failed to remove from wishlist');
      }
    } catch (error, stackTrace) {
      log('WishlistNotifier: Error removing from wishlist: $error\n$stackTrace');
      final currentItems = Map<String, WishlistResponse>.from(previousState);
      if (error.toString().contains('Product not found in wishlist')) {
        log('WishlistNotifier: Product not in wishlist, treated as removed');
        currentItems.remove(productId);
        state = AsyncValue.data(currentItems);
      } else {
        state = AsyncValue.data(currentItems);
        state = AsyncValue.error(error, stackTrace);
        throw error;
      }
    }
  }

  Future<void> toggleWishlist(int productId) async {
    final productIdStr = productId.toString();
    final wasInWishlist = isInWishlist(productIdStr);
    if (wasInWishlist) {
      await removeFromWishlist(productIdStr);
    } else {
      await addToWishlist(productId);
    }
    log('WishlistNotifier: Toggled wishlist for product ID: $productId, isInWishlist: ${isInWishlist(productIdStr)}');
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
