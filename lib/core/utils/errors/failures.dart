abstract class Failure {
  const Failure({required this.message, this.statusCode});
  final String message;
  final int? statusCode;
}

class UnknownFailure extends Failure {
  UnknownFailure({required super.message});
}

class ServerFailure extends Failure {
  ServerFailure({required super.message, required int super.statusCode});
}

class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

class ParseDataFailure extends Failure {
  ParseDataFailure({required super.message});
}

class CertificatFailure extends Failure {
  CertificatFailure({required super.message});
}
