import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../credentials.dart';
import '../impl/logger/logger_provider.dart';
import '../impl/package_info/package_info_provider.dart';
import '../impl/secure_storage/secure_storage_provider.dart';
import '../utils/platform/platform.dart';

class Utils {
  /// Application initialization
  static Future<void> initBeforeRunApp() async {
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
      isDev: Credential.isDevelopment,
    );
    logger.initDebugPrint(
      isRelease: kReleaseMode,
      version: versionApp,
      platform: platformApp,
    );

    // Storage initialization
    final secureStorage = container.read(secureStorageImplProvider);
    await secureStorage.initSecureStorage();
  }
}
