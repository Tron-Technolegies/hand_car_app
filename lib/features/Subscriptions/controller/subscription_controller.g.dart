// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$planNotifierHash() => r'483102e15deea45339aeeefe11a8a8b89b21bb30';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PlanNotifier
    extends BuildlessAutoDisposeAsyncNotifier<List<PlanModel>> {
  late final String serviceType;

  FutureOr<List<PlanModel>> build(
    String serviceType,
  );
}

/// See also [PlanNotifier].
@ProviderFor(PlanNotifier)
const planNotifierProvider = PlanNotifierFamily();

/// See also [PlanNotifier].
class PlanNotifierFamily extends Family<AsyncValue<List<PlanModel>>> {
  /// See also [PlanNotifier].
  const PlanNotifierFamily();

  /// See also [PlanNotifier].
  PlanNotifierProvider call(
    String serviceType,
  ) {
    return PlanNotifierProvider(
      serviceType,
    );
  }

  @override
  PlanNotifierProvider getProviderOverride(
    covariant PlanNotifierProvider provider,
  ) {
    return call(
      provider.serviceType,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'planNotifierProvider';
}

/// See also [PlanNotifier].
class PlanNotifierProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PlanNotifier, List<PlanModel>> {
  /// See also [PlanNotifier].
  PlanNotifierProvider(
    String serviceType,
  ) : this._internal(
          () => PlanNotifier()..serviceType = serviceType,
          from: planNotifierProvider,
          name: r'planNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$planNotifierHash,
          dependencies: PlanNotifierFamily._dependencies,
          allTransitiveDependencies:
              PlanNotifierFamily._allTransitiveDependencies,
          serviceType: serviceType,
        );

  PlanNotifierProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceType,
  }) : super.internal();

  final String serviceType;

  @override
  FutureOr<List<PlanModel>> runNotifierBuild(
    covariant PlanNotifier notifier,
  ) {
    return notifier.build(
      serviceType,
    );
  }

  @override
  Override overrideWith(PlanNotifier Function() create) {
    return ProviderOverride(
      origin: this,
      override: PlanNotifierProvider._internal(
        () => create()..serviceType = serviceType,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceType: serviceType,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PlanNotifier, List<PlanModel>>
      createElement() {
    return _PlanNotifierProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanNotifierProvider && other.serviceType == serviceType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceType.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PlanNotifierRef on AutoDisposeAsyncNotifierProviderRef<List<PlanModel>> {
  /// The parameter `serviceType` of this provider.
  String get serviceType;
}

class _PlanNotifierProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PlanNotifier,
        List<PlanModel>> with PlanNotifierRef {
  _PlanNotifierProviderElement(super.provider);

  @override
  String get serviceType => (origin as PlanNotifierProvider).serviceType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
