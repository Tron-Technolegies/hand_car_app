// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_interaction_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$serviceInteractionApiHash() =>
    r'f03840ee8717fbebaf01eb9c02df830dd5e5f74b';

/// See also [serviceInteractionApi].
@ProviderFor(serviceInteractionApi)
final serviceInteractionApiProvider =
    AutoDisposeProvider<ServiceInteractionApi>.internal(
  serviceInteractionApi,
  name: r'serviceInteractionApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$serviceInteractionApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ServiceInteractionApiRef
    = AutoDisposeProviderRef<ServiceInteractionApi>;
String _$logInteractionHash() => r'3e3788fbca2472bd100b8f4e99b0ef8f2d5770e1';

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

/// See also [logInteraction].
@ProviderFor(logInteraction)
const logInteractionProvider = LogInteractionFamily();

/// See also [logInteraction].
class LogInteractionFamily extends Family<AsyncValue<bool>> {
  /// See also [logInteraction].
  const LogInteractionFamily();

  /// See also [logInteraction].
  LogInteractionProvider call(
    String serviceId,
    String action,
  ) {
    return LogInteractionProvider(
      serviceId,
      action,
    );
  }

  @override
  LogInteractionProvider getProviderOverride(
    covariant LogInteractionProvider provider,
  ) {
    return call(
      provider.serviceId,
      provider.action,
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
  String? get name => r'logInteractionProvider';
}

/// See also [logInteraction].
class LogInteractionProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [logInteraction].
  LogInteractionProvider(
    String serviceId,
    String action,
  ) : this._internal(
          (ref) => logInteraction(
            ref as LogInteractionRef,
            serviceId,
            action,
          ),
          from: logInteractionProvider,
          name: r'logInteractionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$logInteractionHash,
          dependencies: LogInteractionFamily._dependencies,
          allTransitiveDependencies:
              LogInteractionFamily._allTransitiveDependencies,
          serviceId: serviceId,
          action: action,
        );

  LogInteractionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.serviceId,
    required this.action,
  }) : super.internal();

  final String serviceId;
  final String action;

  @override
  Override overrideWith(
    FutureOr<bool> Function(LogInteractionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: LogInteractionProvider._internal(
        (ref) => create(ref as LogInteractionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        serviceId: serviceId,
        action: action,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _LogInteractionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is LogInteractionProvider &&
        other.serviceId == serviceId &&
        other.action == action;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, serviceId.hashCode);
    hash = _SystemHash.combine(hash, action.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin LogInteractionRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `serviceId` of this provider.
  String get serviceId;

  /// The parameter `action` of this provider.
  String get action;
}

class _LogInteractionProviderElement
    extends AutoDisposeFutureProviderElement<bool> with LogInteractionRef {
  _LogInteractionProviderElement(super.provider);

  @override
  String get serviceId => (origin as LogInteractionProvider).serviceId;
  @override
  String get action => (origin as LogInteractionProvider).action;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
