import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:wiredash/wiredash.dart';

import 'core/credentials.dart';
import 'core/impl/package_info/package_info_provider.dart';
import 'core/locales/generated/l10n.dart';
import 'core/router/router.dart';
import 'core/utils/errors/failures.dart';
import 'core/utils/platform/platform.dart';
import 'core/utils/utils_ui.dart';
import 'features/commons/providers/failure_provider.dart';
import 'features/commons/providers/loader_provider.dart';
import 'features/commons/providers/locale_provider.dart';
import 'features/commons/providers/theme_provider.dart';
import 'features/login/presentation/providers/user_provider.dart';
import 'ui/widgets/circular_indicator.dart';
import 'ui/widgets/dismiss_keyboard.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _listenFailureSnackbar(ref);
    _listenLoaderOverlay(ref, context);
    final router = ref.watch(routerProvider);
    final theme = ref.watch(themeModeProvider.notifier);
    return Wiredash(
      projectId: Credential.wiredashId,
      secret: Credential.wiredashKey,
      options: WiredashOptionsData(
        locale: ref.watch(localeProvider),
      ),
      feedbackOptions: WiredashFeedbackOptions(
        collectMetaData: (metaData) => metaData
          ..buildVersion = versionApp
          ..buildNumber = buildNumberApp
          ..userId = ref.watch(userProvider)?.id.toString() ?? 'Not connected'
          ..custom['Environment'] = Credential.env
          ..custom['Operating system'] = Platform().operatingSystem
          ..custom['Theme'] = ref.watch(themeModeProvider).name
          ..custom['Route'] = ref.watch(routerProvider).location,
      ),
      child: DismissKeyboard(
        child: GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayWidget: const Center(child: CircularIndicator()),
          child: MaterialApp.router(
            title: 'Template App',
            debugShowCheckedModeBanner: Credential.isDev,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            locale: ref.watch(localeProvider),
            supportedLocales: S.delegate.supportedLocales,
            theme: theme.getThemeData(isLightTheme: true),
            darkTheme: theme.getThemeData(isLightTheme: false),
            themeMode: ref.watch(themeModeProvider),
          ),
        ),
      ),
    );
  }

  /// Added a displayable snack throughout the application
  /// Listening failure provider
  /// [ref] ref
  void _listenFailureSnackbar(WidgetRef ref) {
    ref.listen<Failure?>(failureProvider, (oldFailure, newFailure) async {
      if (newFailure != null && navigatorKey.currentContext != null) {
        await UtilsUI.showErrorSnackBar(
          context: navigatorKey.currentContext!,
          message: newFailure.message,
        );
      }
    });
  }

  /// Added a loader overlay throughout the application
  /// Listening loader provider
  /// [ref] ref
  /// [context] context
  void _listenLoaderOverlay(WidgetRef ref, BuildContext context) {
    ref.listen<bool>(loaderProvider, (oldLoader, newLoader) {
      if (newLoader) {
        context.loaderOverlay.show();
      } else {
        context.loaderOverlay.hide();
      }
    });
  }
}
