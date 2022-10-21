import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/login/domain/entities/user.dart';
import '../../features/login/presentation/providers/user_provider.dart';
import 'routes.dart';

/// My favorite approach: ofc there's room for improvement, but it works fine.
/// What I like about this is that `RouterNotifier` centralizes all the logic.
/// The reason we use `ChangeNotifier` is because it's a `Listenable` object,
/// as required by `GoRouter`'s `refreshListenable` parameter.
/// Unluckily, it is not possible to use a `StateNotifier` here, since it's
/// not a `Listenable`. Recall that `StateNotifier` is to be preferred over
/// `ChangeNotifier`, see https://riverpod.dev/docs/concepts/providers/#different-types-of-providers
class RouterNotifier extends ChangeNotifier {
  /// This implementation exploits `ref.listen()` to add a simple callback that
  /// calls `notifyListeners()` whenever there's change onto a desider provider.
  RouterNotifier(this._ref) {
    _ref.listen<User?>(
      userProvider, // In our case, we're interested in the log in / log out events.
      (_, __) => notifyListeners(), // Obviously more logic can be added here
    );
  }
  final Ref _ref;

  /// IMPORTANT: conceptually, we want to use `ref.read` to read providers,here.
  /// GoRouter is already aware of state changes through `refreshListenable`
  /// We don't want to trigger a rebuild of the surrounding provider.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final user = _ref.read(userProvider.notifier);

    final errorPage = state.location == '';
    // Page not found
    if (errorPage) {
      return null;
    }

    final areWeLoggingIn = state.location == AppRoutes.login.routePath;
    final noNeedToLogin = state.location == AppRoutes.signup.routePath ||
        state.location == AppRoutes.forgetPassword.routePath ||
        state.location == AppRoutes.splash.routePath;

    if (noNeedToLogin) {
      return null;
    }

    if (!user.isConnected) {
      // We're not logged in
      // So, IF we aren't in the login page, go there.
      return areWeLoggingIn ? null : AppRoutes.login.routePath;
    }
    // We're logged in

    // At this point, IF we're in the login page, go to the home page
    if (areWeLoggingIn) {
      return AppRoutes.home.routePath;
    }

    // There's no need for a redirect at this point.
    return null;
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: AppRoutes.home.routePath,
          name: AppRoutes.home.routeName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: AppRoutes.home.routeView,
            name: AppRoutes.home.routePath,
          ),
        ),
        GoRoute(
          path: AppRoutes.login.routePath,
          name: AppRoutes.login.routeName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: AppRoutes.login.routeView,
            name: AppRoutes.login.routePath,
          ),
        ),
        GoRoute(
          path: AppRoutes.signup.routePath,
          name: AppRoutes.signup.routeName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: AppRoutes.signup.routeView,
            name: AppRoutes.signup.routePath,
          ),
        ),
        GoRoute(
          path: AppRoutes.forgetPassword.routePath,
          name: AppRoutes.forgetPassword.routeName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: AppRoutes.forgetPassword.routeView,
            name: AppRoutes.forgetPassword.routePath,
          ),
        ),
        GoRoute(
          path: AppRoutes.errorConnection.routePath,
          name: AppRoutes.errorConnection.routeName,
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            child: AppRoutes.errorConnection.routeView,
            name: AppRoutes.errorConnection.routePath,
          ),
        ),
        GoRoute(
          path: AppRoutes.splash.routePath,
          name: AppRoutes.splash.routeName,
          pageBuilder: (context, state) => CustomTransitionPage<void>(
            key: state.pageKey,
            child: AppRoutes.splash.routeView,
            name: AppRoutes.splash.routePath,
            transitionsBuilder: (context, animation, animation2, child) =>
                FadeTransition(opacity: animation, child: child),
          ),
        ),
      ];
}
