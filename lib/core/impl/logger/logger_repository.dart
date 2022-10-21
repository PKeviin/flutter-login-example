abstract class LoggerRepository {
  void traceLogInfo(String message);
  void traceLogWarning(String message);
  void traceLogDebug(String message);
  void traceLogVerbose(String message);
  Future<void> traceLogError({
    required String message,
    required bool isDev,
    Object? error,
    StackTrace? stacktrace,
  });
}
