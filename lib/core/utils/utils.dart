import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../credentials.dart';
import '../impl/secure_storage_impl.dart';
import 'platform/platform.dart';

class Utils {
  /// Application initialization
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await SecureStorageImpl().initSecureStorage();
    _initErrorDisplayManagement();
    await _getVersion();
    _initDebugPrint(
      isRelease: kReleaseMode,
      version: Credential.appVersion,
      platform: getPlatform(),
    );
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

  /// Disabling print in release
  static void _initDebugPrint({
    required bool isRelease,
    required String platform,
    String? version,
  }) {
    if (isRelease) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    } else {
      debugPrint = (String? message, {int? wrapWidth}) {
        message = '[${DateTime.now()} - $version - $platform]: $message';
        debugPrintSynchronously(message, wrapWidth: wrapWidth);
      };
    }
  }

  /// Logger
  static Logger logger = Logger(
    printer: PrettyPrinter(),
  );

  /// Trace Error Log
  static Future<void> traceLogError(
    String message,
    Object? error,
    StackTrace? stacktrace,
  ) async {
    logger.e(message, error, stacktrace);
    if (!Utils.isDevEnv && error != null) {
      await Sentry.captureException(error, stackTrace: stacktrace);
    }
  }

  /// Error display management
  static void _initErrorDisplayManagement() {
    FlutterError.onError = (errorDetails) async {
      await Utils.traceLogError(
        'error',
        errorDetails.exception,
        errorDetails.stack,
      );
    };
  }
}
