// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$wishlistServicesHash() => r'6038022ad4f0a0d7ec6e9826dd3e49efa6f87590';

/// See also [wishlistServices].
@ProviderFor(wishlistServices)
final wishlistServicesProvider = AutoDisposeProvider<WishlistServices>.internal(
  wishlistServices,
  name: r'wishlistServicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistServicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WishlistServicesRef = AutoDisposeProviderRef<WishlistServices>;
String _$wishlistNotifierHash() => r'854316e03d6cd6b2e327fcf934c1d1b7886e8e4d';

/// See also [WishlistNotifier].
@ProviderFor(WishlistNotifier)
final wishlistNotifierProvider = AutoDisposeAsyncNotifierProvider<
    WishlistNotifier, Map<String, WishlistResponse>>.internal(
  WishlistNotifier.new,
  name: r'wishlistNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$wishlistNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$WishlistNotifier
    = AutoDisposeAsyncNotifier<Map<String, WishlistResponse>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
