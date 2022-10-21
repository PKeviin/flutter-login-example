import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/commons/providers/locale_provider.dart';
import '../../features/commons/providers/privacy_provider.dart';
import '../../features/commons/providers/theme_provider.dart';
import '../credentials.dart';
import '../impl/logger/logger_provider.dart';
import '../impl/package_info/package_info_provider.dart';
import '../impl/secure_storage/secure_storage_provider.dart';
import '../utils/platform/platform.dart';

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
    await pacakgeInfo.initPackageInfo(Platform());

    // Logger initialization
    final logger = container.read(loggerImplProvider);
    await logger.initErrorDisplayManagement(
      message: 'Error',
      isDev: Credential.isDev,
    );
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
}
