import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../credentials.dart';
import '../impl/logger/logger_provider.dart';
import '../impl/secure_storage/secure_storage_provider.dart';
import '../providers/locale_provider.dart';
import '../providers/privacy_provider.dart';
import '../providers/theme_provider.dart';
import 'platform/platform.dart';

class Utils {
  /// Application initialization
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    final container = ProviderContainer();
    // Logger initialization
    final logger = container.read(loggerImplProvider);
    await logger.initErrorDisplayManagement();
    logger.initDebugPrint(
      isRelease: kReleaseMode,
      version: Credential.appVersion,
      platform: Credential.platform,
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

  /// Application version retrieval
  static Future<void> _getVersion() async {
    await PackageInfo.fromPlatform().then((packageInfo) {
      Credential.appVersion = packageInfo.version;
      Credential.buildNumber = packageInfo.buildNumber;
    });
    debugPrint('app version [${Credential.appVersion}]');
  }

  /// Get platform
  static String getPlatform() {
    final platformBase = Platform();
    var platform = 'autre';
    if (platformBase.isWeb) {
      platform = 'web';
    } else if (platformBase.isAndroid) {
      platform = 'android';
    } else if (platformBase.isIOS) {
      platform = 'ios';
    } else if (platformBase.isMacOS) {
      platform = 'macos';
    } else if (platformBase.isWindows) {
      platform = 'windows';
    } else if (platformBase.isLinux) {
      platform = 'linux';
    }
    debugPrint('platform [$platform]');
    return platform;
  }
}
