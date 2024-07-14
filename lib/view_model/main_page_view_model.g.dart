// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_page_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mainPageViewModelHash() => r'b042fa615180b616f4ed3351a55686c8e1fb4e03';

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

abstract class _$MainPageViewModel
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final TickerProvider vsync;

  FutureOr<void> build(
    TickerProvider vsync,
  );
}

/// See also [MainPageViewModel].
@ProviderFor(MainPageViewModel)
const mainPageViewModelProvider = MainPageViewModelFamily();

/// See also [MainPageViewModel].
class MainPageViewModelFamily extends Family<AsyncValue<void>> {
  /// See also [MainPageViewModel].
  const MainPageViewModelFamily();

  /// See also [MainPageViewModel].
  MainPageViewModelProvider call(
    TickerProvider vsync,
  ) {
    return MainPageViewModelProvider(
      vsync,
    );
  }

  @override
  MainPageViewModelProvider getProviderOverride(
    covariant MainPageViewModelProvider provider,
  ) {
    return call(
      provider.vsync,
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
  String? get name => r'mainPageViewModelProvider';
}

/// See also [MainPageViewModel].
class MainPageViewModelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MainPageViewModel, void> {
  /// See also [MainPageViewModel].
  MainPageViewModelProvider(
    TickerProvider vsync,
  ) : this._internal(
          () => MainPageViewModel()..vsync = vsync,
          from: mainPageViewModelProvider,
          name: r'mainPageViewModelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$mainPageViewModelHash,
          dependencies: MainPageViewModelFamily._dependencies,
          allTransitiveDependencies:
              MainPageViewModelFamily._allTransitiveDependencies,
          vsync: vsync,
        );

  MainPageViewModelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.vsync,
  }) : super.internal();

  final TickerProvider vsync;

  @override
  FutureOr<void> runNotifierBuild(
    covariant MainPageViewModel notifier,
  ) {
    return notifier.build(
      vsync,
    );
  }

  @override
  Override overrideWith(MainPageViewModel Function() create) {
    return ProviderOverride(
      origin: this,
      override: MainPageViewModelProvider._internal(
        () => create()..vsync = vsync,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        vsync: vsync,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MainPageViewModel, void>
      createElement() {
    return _MainPageViewModelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MainPageViewModelProvider && other.vsync == vsync;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, vsync.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin MainPageViewModelRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `vsync` of this provider.
  TickerProvider get vsync;
}

class _MainPageViewModelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MainPageViewModel, void>
    with MainPageViewModelRef {
  _MainPageViewModelProviderElement(super.provider);

  @override
  TickerProvider get vsync => (origin as MainPageViewModelProvider).vsync;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
