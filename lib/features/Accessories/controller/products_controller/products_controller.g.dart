// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'products_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$productsApiServiceHash() =>
    r'a34190d35eab80d6d4e64befe22744a9f7c71cc4';

/// See also [productsApiService].
@ProviderFor(productsApiService)
final productsApiServiceProvider =
    AutoDisposeProvider<ProductsApiServices>.internal(
  productsApiService,
  name: r'productsApiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsApiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProductsApiServiceRef = AutoDisposeProviderRef<ProductsApiServices>;
String _$productsControllerHash() =>
    r'347d429fc327a283d8a997eeb58a98867aa40a8b';

/// See also [ProductsController].
@ProviderFor(ProductsController)
final productsControllerProvider = AutoDisposeAsyncNotifierProvider<
    ProductsController, List<ProductsModel>>.internal(
  ProductsController.new,
  name: r'productsControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$productsControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProductsController = AutoDisposeAsyncNotifier<List<ProductsModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
