// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userNameHash() => r'4c4d9cd8f176e4c64905b4b2fd4273374dde0ea1';

/// See also [userName].
@ProviderFor(userName)
final userNameProvider = AutoDisposeProvider<String?>.internal(
  userName,
  name: r'userNameProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userNameHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserNameRef = AutoDisposeProviderRef<String?>;
String _$userHash() => r'ae66bd71017b32a89e47aeab16b1b0e0d5147630';

/// See also [user].
@ProviderFor(user)
final userProvider = AutoDisposeProvider<UserModel?>.internal(
  user,
  name: r'userProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserRef = AutoDisposeProviderRef<UserModel?>;
String _$userDataProviderHash() => r'cb66d97518cfbdd8ca16a65c7332f7148b157e2a';

/// See also [UserDataProvider].
@ProviderFor(UserDataProvider)
final userDataProviderProvider =
    AutoDisposeAsyncNotifierProvider<UserDataProvider, UserModel?>.internal(
  UserDataProvider.new,
  name: r'userDataProviderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userDataProviderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserDataProvider = AutoDisposeAsyncNotifier<UserModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
