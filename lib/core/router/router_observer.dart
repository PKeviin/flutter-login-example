import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/login/presentation/providers/user_provider.dart';

/// The Navigator observer.
class NavObserver extends NavigatorObserver {
  /// Creates a [NavObserver].
  NavObserver(this._ref);
  final Ref _ref;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      saveRoute(route.settings.name, previousRoute?.settings.name);

  /// Inversion between current route and previous route
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      saveRoute(previousRoute?.settings.name, route.settings.name);

  // TODO(PKeviin): Test
  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      saveRoute(route.settings.name, previousRoute?.settings.name);

  // TODO(PKeviin): Test
  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) =>
      saveRoute(newRoute?.settings.name, oldRoute?.settings.name);

  // TODO(PKeviin): Test
  @override
  void didStartUserGesture(
    Route<dynamic> route,
    Route<dynamic>? previousRoute,
  ) =>
      saveRoute(route.settings.name, previousRoute?.settings.name);

  /// Save route
  void saveRoute(String? currentRoute, String? previousRoute) {
    _ref.read(userProvider.notifier).setCurrentLocation(currentRoute);
    _ref.read(userProvider.notifier).setPreviousLocation(previousRoute);
  }
}
