import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/commons/pages/errors/error_page.dart';
import '../credentials.dart';
import 'router_notifier.dart';
import 'router_observer.dart';
import 'routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

/// Caches and Exposes a [GoRouter]
final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);

  return GoRouter(
    debugLogDiagnostics: Credential.isDev,
    // Global key for snacback
    navigatorKey: navigatorKey,
    // Initial location
    initialLocation: AppRoutes.splash.routePath,
    // Observer
    observers: <NavigatorObserver>[NavObserver(ref)],
    // This notifiies `GoRouter` for refresh events
    refreshListenable: router,
    // All the logic is centralized here
    redirect: router.redirectLogic,
    // All the routes can be found there
    routes: router.routes,
    // Redirect error page
    errorBuilder: (context, state) => ErrorPage(state.error),
    // Disables history on browser to prevent weird behaviours
    // routerNeglect: true,
  );
});
