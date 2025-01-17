// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_rating_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceRatingsHash() => r'3fd64b01202a8e9f59c9effded7de98f8392d1a9';

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

/// See also [serviceRatings].
@ProviderFor(serviceRatings)
const serviceRatingsProvider = ServiceRatingsFamily();

/// See also [serviceRatings].
class ServiceRatingsFamily extends Family<AsyncValue<ServiceRatingList>> {
  /// See also [serviceRatings].
  const ServiceRatingsFamily();

  /// See also [serviceRatings].
  ServiceRatingsProvider call(
    int serviceId,
  ) {
    return ServiceRatingsProvider(
      serviceId,
    );
  }

  @override
  ServiceRatingsProvider getProviderOverride(
    covariant ServiceRatingsProvider provider,
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
  String? get name => r'serviceRatingsProvider';
}

/// See also [serviceRatings].
class ServiceRatingsProvider
    extends AutoDisposeFutureProvider<ServiceRatingList> {
  /// See also [serviceRatings].
  ServiceRatingsProvider(
    int serviceId,
  ) : this._internal(
          (ref) => serviceRatings(
            ref as ServiceRatingsRef,
            serviceId,
          ),
          from: serviceRatingsProvider,
          name: r'serviceRatingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$serviceRatingsHash,
          dependencies: ServiceRatingsFamily._dependencies,
          allTransitiveDependencies:
              ServiceRatingsFamily._allTransitiveDependencies,
          serviceId: serviceId,
        );

  ServiceRatingsProvider._internal(
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
    FutureOr<ServiceRatingList> Function(ServiceRatingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ServiceRatingsProvider._internal(
        (ref) => create(ref as ServiceRatingsRef),
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
  AutoDisposeFutureProviderElement<ServiceRatingList> createElement() {
    return _ServiceRatingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ServiceRatingsProvider && other.serviceId == serviceId;
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
mixin ServiceRatingsRef on AutoDisposeFutureProviderRef<ServiceRatingList> {
  /// The parameter `serviceId` of this provider.
  int get serviceId;
}

class _ServiceRatingsProviderElement
    extends AutoDisposeFutureProviderElement<ServiceRatingList>
    with ServiceRatingsRef {
  _ServiceRatingsProviderElement(super.provider);

  @override
  int get serviceId => (origin as ServiceRatingsProvider).serviceId;
}

String _$vendorRatingsHash() => r'ac58b16bb0c94f39038691b76b82babee51925ad';

/// See also [vendorRatings].
@ProviderFor(vendorRatings)
const vendorRatingsProvider = VendorRatingsFamily();

/// See also [vendorRatings].
class VendorRatingsFamily extends Family<List<ServiceRating>> {
  /// See also [vendorRatings].
  const VendorRatingsFamily();

  /// See also [vendorRatings].
  VendorRatingsProvider call(
    String vendorName,
  ) {
    return VendorRatingsProvider(
      vendorName,
    );
  }

  @override
  VendorRatingsProvider getProviderOverride(
    covariant VendorRatingsProvider provider,
  ) {
    return call(
      provider.vendorName,
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
  String? get name => r'vendorRatingsProvider';
}

/// See also [vendorRatings].
class VendorRatingsProvider extends AutoDisposeProvider<List<ServiceRating>> {
  /// See also [vendorRatings].
  VendorRatingsProvider(
    String vendorName,
  ) : this._internal(
          (ref) => vendorRatings(
            ref as VendorRatingsRef,
            vendorName,
          ),
          from: vendorRatingsProvider,
          name: r'vendorRatingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$vendorRatingsHash,
          dependencies: VendorRatingsFamily._dependencies,
          allTransitiveDependencies:
              VendorRatingsFamily._allTransitiveDependencies,
          vendorName: vendorName,
        );

  VendorRatingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vendorName,
  }) : super.internal();

  final String vendorName;

  @override
  Override overrideWith(
    List<ServiceRating> Function(VendorRatingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VendorRatingsProvider._internal(
        (ref) => create(ref as VendorRatingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vendorName: vendorName,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<List<ServiceRating>> createElement() {
    return _VendorRatingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VendorRatingsProvider && other.vendorName == vendorName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vendorName.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VendorRatingsRef on AutoDisposeProviderRef<List<ServiceRating>> {
  /// The parameter `vendorName` of this provider.
  String get vendorName;
}

class _VendorRatingsProviderElement
    extends AutoDisposeProviderElement<List<ServiceRating>>
    with VendorRatingsRef {
  _VendorRatingsProviderElement(super.provider);

  @override
  String get vendorName => (origin as VendorRatingsProvider).vendorName;
}

String _$serviceRatingControllerHash() =>
    r'2af449e3a506e7fa92f8680f070607cd57dec37b';

/// See also [ServiceRatingController].
@ProviderFor(ServiceRatingController)
final serviceRatingControllerProvider =
    AsyncNotifierProvider<ServiceRatingController, ServiceRatingList>.internal(
  ServiceRatingController.new,
  name: r'serviceRatingControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serviceRatingControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ServiceRatingController = AsyncNotifier<ServiceRatingList>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
