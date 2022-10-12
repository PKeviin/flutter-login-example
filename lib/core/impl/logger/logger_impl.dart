import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../utils/utils.dart';
import 'logger_repository.dart';

class LoggerImpl implements LoggerRepository {
  LoggerImpl({
    required this.logger,
  });
  Logger logger;

  /// Error display management
  @override
  Future<void> initErrorDisplayManagement() async {
    FlutterError.onError = (errorDetails) async {
      await traceLogError(
        message: 'error',
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

  /// Error log
  @override
  Future<void> traceLogError({
    required String message,
    Object? error,
    StackTrace? stacktrace,
  }) async {
    logger.e(message, error, stacktrace);
    if (!Utils.isDevEnv && error != null) {
      await Sentry.captureException(error, stackTrace: stacktrace);
    }
  }
}
