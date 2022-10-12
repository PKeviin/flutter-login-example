abstract class LoggerRepository {
  Future<void> traceLogError({
    required String message,
    Object? error,
    StackTrace? stacktrace,
  });
  Future<void> initErrorDisplayManagement();
}
