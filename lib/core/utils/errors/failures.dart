abstract class Failure {
  const Failure({required this.message, this.statusCode});
  final String message;
  final int? statusCode;
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required int super.statusCode});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class LocalAuthFailure extends Failure {
  LocalAuthFailure({required super.message});
}

class TokenFailure extends Failure {
  TokenFailure({required super.message});
}

class ParseDataFailure extends Failure {
  ParseDataFailure({required super.message});
}
