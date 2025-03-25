// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cities.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchCityByIdHash() => r'f2a8742fac3a6646c043769df3c6db48a475dd41';

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

/// See also [fetchCityById].
@ProviderFor(fetchCityById)
const fetchCityByIdProvider = FetchCityByIdFamily();

/// See also [fetchCityById].
class FetchCityByIdFamily extends Family<AsyncValue<City>> {
  /// See also [fetchCityById].
  const FetchCityByIdFamily();

  /// See also [fetchCityById].
  FetchCityByIdProvider call(String cityId) {
    return FetchCityByIdProvider(cityId);
  }

  @override
  FetchCityByIdProvider getProviderOverride(
    covariant FetchCityByIdProvider provider,
  ) {
    return call(provider.cityId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchCityByIdProvider';
}

/// See also [fetchCityById].
class FetchCityByIdProvider extends AutoDisposeFutureProvider<City> {
  /// See also [fetchCityById].
  FetchCityByIdProvider(String cityId)
    : this._internal(
        (ref) => fetchCityById(ref as FetchCityByIdRef, cityId),
        from: fetchCityByIdProvider,
        name: r'fetchCityByIdProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchCityByIdHash,
        dependencies: FetchCityByIdFamily._dependencies,
        allTransitiveDependencies:
            FetchCityByIdFamily._allTransitiveDependencies,
        cityId: cityId,
      );

  FetchCityByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.cityId,
  }) : super.internal();

  final String cityId;

  @override
  Override overrideWith(
    FutureOr<City> Function(FetchCityByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchCityByIdProvider._internal(
        (ref) => create(ref as FetchCityByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        cityId: cityId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<City> createElement() {
    return _FetchCityByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCityByIdProvider && other.cityId == cityId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, cityId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchCityByIdRef on AutoDisposeFutureProviderRef<City> {
  /// The parameter `cityId` of this provider.
  String get cityId;
}

class _FetchCityByIdProviderElement
    extends AutoDisposeFutureProviderElement<City>
    with FetchCityByIdRef {
  _FetchCityByIdProviderElement(super.provider);

  @override
  String get cityId => (origin as FetchCityByIdProvider).cityId;
}

String _$citiesListHash() => r'3f7c950e48ba1d8cab91bf0456b4326cb04ed883';

/// See also [CitiesList].
@ProviderFor(CitiesList)
final citiesListProvider =
    AutoDisposeAsyncNotifierProvider<CitiesList, List<City>>.internal(
      CitiesList.new,
      name: r'citiesListProvider',
      debugGetCreateSourceHash:
          const bool.fromEnvironment('dart.vm.product')
              ? null
              : _$citiesListHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$CitiesList = AutoDisposeAsyncNotifier<List<City>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
