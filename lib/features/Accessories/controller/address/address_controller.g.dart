// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addressApiServiceHash() => r'36dfdbfba9bc6ba1fea943bb44b56b22b6f899a7';

/// See also [addressApiService].
@ProviderFor(addressApiService)
final addressApiServiceProvider =
    AutoDisposeProvider<AddressApiService>.internal(
  addressApiService,
  name: r'addressApiServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addressApiServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AddressApiServiceRef = AutoDisposeProviderRef<AddressApiService>;
String _$addressControllerHash() => r'8ed2562514c6d013d6166cd5266ea8eeeb5a6b89';

/// See also [AddressController].
@ProviderFor(AddressController)
final addressControllerProvider =
    NotifierProvider<AddressController, AddressState>.internal(
  AddressController.new,
  name: r'addressControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$addressControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AddressController = Notifier<AddressState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
