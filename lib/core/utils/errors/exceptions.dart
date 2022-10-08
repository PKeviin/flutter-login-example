import 'dart:async';

import '../utils.dart';

abstract class ExceptionCustom implements Exception {
  ExceptionCustom({
    required this.message,
    required this.messageEn,
    this.error,
    this.stacktrace,
  }) {
    unawaited(Utils.traceLogError(messageEn, error, stacktrace));
  }
  final String message;
  final String messageEn;
  final Object? error;
  final StackTrace? stacktrace;

  @override
  String toString() => message;
}

class ServerException extends ExceptionCustom {
  ServerException({
    required this.statutCode,
    required super.message,
    required super.messageEn,
    super.error,
    super.stacktrace,
  });
  final int statutCode;

  @override
  String toString() => '$statutCode : $message';
}

class CacheException extends ExceptionCustom {
  CacheException({
    required super.message,
    required super.messageEn,
    super.error,
    super.stacktrace,
  });
}

class ParseDataException extends ExceptionCustom {
  ParseDataException({
    required super.message,
    required super.messageEn,
    super.error,
    super.stacktrace,
  });
}

class CertificatException extends ExceptionCustom {
  CertificatException({
    required super.message,
    required super.messageEn,
    super.error,
    super.stacktrace,
  });
}

class UnknownException extends ExceptionCustom {
  UnknownException({
    required super.message,
    required super.messageEn,
    super.error,
    super.stacktrace,
  });
}

class TokenException extends ExceptionCustom {
  TokenException({
    required super.message,
    required super.messageEn,
    super.error,
    super.stacktrace,
  });
}
