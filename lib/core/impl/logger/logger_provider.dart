import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'logger_impl.dart';

/// Logger provider
final loggerProvider = Provider<Logger>(
  (ref) => Logger(
    printer: PrettyPrinter(),
  ),
);

/// LoggerImpl provider
final loggerImplProvider = Provider<LoggerImpl>((ref) {
  final logger = ref.watch(loggerProvider);
  return LoggerImpl(logger: logger);
});
