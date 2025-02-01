// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userNameHash() => r'767e427eb18feb8a388a6d49228adcd8ec817c3e';

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
String _$userDataProviderHash() => r'f07d9116494cb2d74de1772a246381f2f6164e65';

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
