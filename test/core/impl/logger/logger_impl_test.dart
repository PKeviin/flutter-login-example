import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/logger/logger_impl.dart';

class MockLogger extends Mock implements Logger {}

void main() {
  MockLogger? mockLogger;
  LoggerImpl? loggerImpl;

  setUp(() {
    mockLogger = MockLogger();
    loggerImpl = LoggerImpl(logger: mockLogger!);
  });

  group('logger package', () {
    test('should display info logs', () async {
      // arrange
      const tMessage = 'info';
      // act
      loggerImpl!.traceLogInfo(tMessage);
      loggerImpl!.traceLogInfo(tMessage);
      // assert
      verify(() => mockLogger!.i(tMessage)).called(2);
      verifyNever(() => mockLogger!.w(tMessage));
      verifyNever(() => mockLogger!.d(tMessage));
      verifyNever(() => mockLogger!.v(tMessage));
      verifyNever(() => mockLogger!.e(tMessage));
    });

    test('should display warning logs', () {
      // arrange
      const tMessage = 'warning';
      // act
      loggerImpl!.traceLogWarning(tMessage);
      loggerImpl!.traceLogWarning(tMessage);
      // assert
      verify(() => mockLogger!.w(tMessage)).called(2);
      verifyNever(() => mockLogger!.i(tMessage));
      verifyNever(() => mockLogger!.d(tMessage));
      verifyNever(() => mockLogger!.v(tMessage));
      verifyNever(() => mockLogger!.e(tMessage));
    });

    test('should display debug logs', () {
      // arrange
      const tMessage = 'debug';
      // act
      loggerImpl!.traceLogDebug(tMessage);
      loggerImpl!.traceLogDebug(tMessage);
      // assert
      verify(() => mockLogger!.d(tMessage)).called(2);
      verifyNever(() => mockLogger!.i(tMessage));
      verifyNever(() => mockLogger!.w(tMessage));
      verifyNever(() => mockLogger!.v(tMessage));
      verifyNever(() => mockLogger!.e(tMessage));
    });

    test('should display verbose logs', () {
      // arrange
      const tMessage = 'verbose';
      // act
      loggerImpl!.traceLogVerbose(tMessage);
      loggerImpl!.traceLogVerbose(tMessage);
      // assert
      verify(() => mockLogger!.v(tMessage)).called(2);
      verifyNever(() => mockLogger!.i(tMessage));
      verifyNever(() => mockLogger!.w(tMessage));
      verifyNever(() => mockLogger!.d(tMessage));
      verifyNever(() => mockLogger!.e(tMessage));
    });

    test('should display error logs in dev without sentry', () async {
      // arrange
      const tIsDev = true;
      const tMessage = 'error';
      // act
      await loggerImpl!.traceLogError(message: tMessage, isDev: tIsDev);
      await loggerImpl!.traceLogError(message: tMessage, isDev: tIsDev);
      // assert
      verify(() => mockLogger!.e(tMessage)).called(2);
      verifyNever(() => mockLogger!.i(tMessage));
      verifyNever(() => mockLogger!.w(tMessage));
      verifyNever(() => mockLogger!.d(tMessage));
      verifyNever(() => mockLogger!.v(tMessage));
    });

    test('should display error logs in preprod/prod mode with sentry',
        () async {
      // arrange
      const tIsDev = false;
      const tMessage = 'error';
      final tError = Exception('test error logger (logger_impl_test.dart)');
      const tStackTrace = StackTrace.empty;
      // act
      await loggerImpl!.traceLogError(
        message: tMessage,
        isDev: tIsDev,
        error: tError,
        stacktrace: tStackTrace,
      );
      await loggerImpl!.traceLogError(
        message: tMessage,
        isDev: tIsDev,
        error: tError,
        stacktrace: tStackTrace,
      );
      // assert
      verify(() => mockLogger!.e(tMessage, tError, tStackTrace)).called(2);
      verifyNever(() => mockLogger!.i(tMessage));
      verifyNever(() => mockLogger!.w(tMessage));
      verifyNever(() => mockLogger!.d(tMessage));
      verifyNever(() => mockLogger!.v(tMessage));
      // TODO(pkeviin): find a way to test Sentry.captureException()
    });
  });

  group('debug print console logger', () {
    test('should not show logs in console in release mode', () {
      // arrange
      const tIsRelease = true;
      const tPlatform = 'iOS';
      const tVersion = '8.0';
      const tMessage = 'test production';
      // act
      loggerImpl!.initDebugPrint(
        isRelease: tIsRelease,
        platform: tPlatform,
        version: tVersion,
      );
      // assert
      debugPrint(tMessage);
      // TODO(pkeviin): find a way to test debugPrint result
    });

    test('should show logs in console in dev/preprod mode', () {
      // arrange
      const tIsRelease = false;
      const tPlatform = 'android';
      const tVersion = '9.0';
      const tMessage = 'test dev/preprod';
      // act
      loggerImpl!.initDebugPrint(
        isRelease: tIsRelease,
        platform: tPlatform,
        version: tVersion,
      );
      // assert
      debugPrint(tMessage);
      // TODO(pkeviin): find a way to test debugPrint result
    });
  });

  group('flutter print logger', () {
    test('should show logs on flutter error', () async {
      // arrange
      const tMessage = 'test';
      const tIsDev = true;
      // act
      await loggerImpl!
          .initErrorDisplayManagement(message: tMessage, isDev: tIsDev);
      // assert
      // TODO(pkeviin): find a way to test FlutterError.onError
    });
  });
}
