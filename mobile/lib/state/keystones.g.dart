// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keystones.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchKeystonesHash() => r'7e44827548842df0abd2c9dc5e9c55f37b48407c';

/// See also [fetchKeystones].
@ProviderFor(fetchKeystones)
final fetchKeystonesProvider =
    AutoDisposeFutureProvider<List<Keystone>>.internal(
      fetchKeystones,
      name: r'fetchKeystonesProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$fetchKeystonesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchKeystonesRef = AutoDisposeFutureProviderRef<List<Keystone>>;
String _$fetchKeystoneByIdHash() => r'c687bef6ec9fe96cd1604b167fb416bc4e1afd10';

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

/// See also [fetchKeystoneById].
@ProviderFor(fetchKeystoneById)
const fetchKeystoneByIdProvider = FetchKeystoneByIdFamily();

/// See also [fetchKeystoneById].
class FetchKeystoneByIdFamily extends Family<AsyncValue<Keystone>> {
  /// See also [fetchKeystoneById].
  const FetchKeystoneByIdFamily();

  /// See also [fetchKeystoneById].
  FetchKeystoneByIdProvider call(String keystoneId) {
    return FetchKeystoneByIdProvider(keystoneId);
  }

  @override
  FetchKeystoneByIdProvider getProviderOverride(
    covariant FetchKeystoneByIdProvider provider,
  ) {
    return call(provider.keystoneId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchKeystoneByIdProvider';
}

/// See also [fetchKeystoneById].
class FetchKeystoneByIdProvider extends AutoDisposeFutureProvider<Keystone> {
  /// See also [fetchKeystoneById].
  FetchKeystoneByIdProvider(String keystoneId)
    : this._internal(
        (ref) => fetchKeystoneById(ref as FetchKeystoneByIdRef, keystoneId),
        from: fetchKeystoneByIdProvider,
        name: r'fetchKeystoneByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchKeystoneByIdHash,
        dependencies: FetchKeystoneByIdFamily._dependencies,
        allTransitiveDependencies:
            FetchKeystoneByIdFamily._allTransitiveDependencies,
        keystoneId: keystoneId,
      );

  FetchKeystoneByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.keystoneId,
  }) : super.internal();

  final String keystoneId;

  @override
  Override overrideWith(
    FutureOr<Keystone> Function(FetchKeystoneByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchKeystoneByIdProvider._internal(
        (ref) => create(ref as FetchKeystoneByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        keystoneId: keystoneId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Keystone> createElement() {
    return _FetchKeystoneByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchKeystoneByIdProvider && other.keystoneId == keystoneId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, keystoneId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchKeystoneByIdRef on AutoDisposeFutureProviderRef<Keystone> {
  /// The parameter `keystoneId` of this provider.
  String get keystoneId;
}

class _FetchKeystoneByIdProviderElement
    extends AutoDisposeFutureProviderElement<Keystone>
    with FetchKeystoneByIdRef {
  _FetchKeystoneByIdProviderElement(super.provider);

  @override
  String get keystoneId => (origin as FetchKeystoneByIdProvider).keystoneId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
