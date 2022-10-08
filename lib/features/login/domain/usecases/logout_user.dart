import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/errors/failures.dart';
import '../repositories/logout_repository.dart';

class LogoutUser {
  LogoutUser(this.repository);
  final LogoutRepository repository;

  Future<Either<Failure, bool>?> logoutUser(
    NoParams params,
  ) async =>
      await repository.logoutUser();
}
