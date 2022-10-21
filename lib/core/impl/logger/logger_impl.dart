import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'logger_repository.dart';

class LoggerImpl implements LoggerRepository {
  LoggerImpl({
    required this.logger,
  });
  Logger logger;

  /// Info log
  @override
  void traceLogInfo(String message) => logger.i(message);

  /// Warning log
  @override
  void traceLogWarning(String message) => logger.w(message);

  /// Debug log
  @override
  void traceLogDebug(String message) => logger.d(message);

  /// Verbose log
  @override
  void traceLogVerbose(String message) => logger.v(message);

  /// Error log
  @override
  Future<void> traceLogError({
    required String message,
    required bool isDev,
    Object? error,
    StackTrace? stacktrace,
  }) async {
    logger.e(message, error, stacktrace);
    if (!isDev && error != null) {
      await Sentry.captureException(error, stackTrace: stacktrace);
    }
  }

  /// Error display management
  Future<void> initErrorDisplayManagement({
    required String message,
    required bool isDev,
  }) async {
    FlutterError.onError = (errorDetails) async {
      await traceLogError(
        message: message,
        isDev: isDev,
        error: errorDetails.exception,
        stacktrace: errorDetails.stack,
      );
    };
  }

  /// Disabling print in release
  void initDebugPrint({
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
}
