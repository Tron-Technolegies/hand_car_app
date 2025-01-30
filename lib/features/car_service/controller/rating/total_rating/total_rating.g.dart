// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'total_rating.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceRatingAsyncHash() =>
    r'459026240934374929fdd32d02645627f814119b';

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

/// See also [serviceRatingAsync].
@ProviderFor(serviceRatingAsync)
const serviceRatingAsyncProvider = ServiceRatingAsyncFamily();

/// See also [serviceRatingAsync].
class ServiceRatingAsyncFamily extends Family<AsyncValue<double>> {
  /// See also [serviceRatingAsync].
  const ServiceRatingAsyncFamily();

  /// See also [serviceRatingAsync].
  ServiceRatingAsyncProvider call(
    int serviceId,
  ) {
    return ServiceRatingAsyncProvider(
      serviceId,
    );
  }

  @override
  ServiceRatingAsyncProvider getProviderOverride(
    covariant ServiceRatingAsyncProvider provider,
  ) {
    return call(
      provider.serviceId,
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
  String? get name => r'serviceRatingAsyncProvider';
}

/// See also [serviceRatingAsync].
class ServiceRatingAsyncProvider
    extends AutoDisposeProvider<AsyncValue<double>> {
  /// See also [serviceRatingAsync].
  ServiceRatingAsyncProvider(
    int serviceId,
  ) : this._internal(
          (ref) => serviceRatingAsync(
            ref as ServiceRatingAsyncRef,
            serviceId,
          ),
          from: serviceRatingAsyncProvider,
          name: r'serviceRatingAsyncProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serviceRatingAsyncHash,
          dependencies: ServiceRatingAsyncFamily._dependencies,
          allTransitiveDependencies:
              ServiceRatingAsyncFamily._allTransitiveDependencies,
          serviceId: serviceId,
        );

  ServiceRatingAsyncProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceId,
  }) : super.internal();

  final int serviceId;

  @override
  Override overrideWith(
    AsyncValue<double> Function(ServiceRatingAsyncRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ServiceRatingAsyncProvider._internal(
        (ref) => create(ref as ServiceRatingAsyncRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceId: serviceId,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<AsyncValue<double>> createElement() {
    return _ServiceRatingAsyncProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceRatingAsyncProvider && other.serviceId == serviceId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ServiceRatingAsyncRef on AutoDisposeProviderRef<AsyncValue<double>> {
  /// The parameter `serviceId` of this provider.
  int get serviceId;
}

class _ServiceRatingAsyncProviderElement
    extends AutoDisposeProviderElement<AsyncValue<double>>
    with ServiceRatingAsyncRef {
  _ServiceRatingAsyncProviderElement(super.provider);

  @override
  int get serviceId => (origin as ServiceRatingAsyncProvider).serviceId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
