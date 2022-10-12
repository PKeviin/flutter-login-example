import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../credentials.dart';
import '../impl/logger/logger_provider.dart';
import '../impl/platform_info/package_info_provider.dart';
import '../impl/secure_storage/secure_storage_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/privacy_provider.dart';
import '../providers/theme_provider.dart';

class Utils {
  /// Application initialization
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final container = ProviderContainer();

    // Package info initialization
    final pacakgeInfo = container.read(packageInfoImplProvider);
    await pacakgeInfo.initPackageInfo();

    // Logger initialization
    final logger = container.read(loggerImplProvider);
    await logger.initErrorDisplayManagement();
    logger.initDebugPrint(
      isRelease: kReleaseMode,
      version: versionApp,
      platform: platformApp,
    );

    // Storage initialization
    final secureStorage = container.read(secureStorageImplProvider);
    await secureStorage.initSecureStorage();

    // Locale initialization
    final locale = container.read(localeProvider.notifier);
    await locale.initLocale();

    // Theme initialization
    final theme = container.read(themeModeProvider.notifier);
    await theme.initTheme();

    // Privacy initialization
    final privacy = container.read(privacyProvider.notifier);
    await privacy.initStatusPrivacy();
  }

  /// Checks if the production environment is active
  static bool get isProductionEnv => Credential.isProduction;

  /// Checks if the preprod environment is active
  static bool get isPreprodEnv => Credential.isPreprod;

  /// Checks if the dev environment is active
  static bool get isDevEnv => Credential.isDev;
}
