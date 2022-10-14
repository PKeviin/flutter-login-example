import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../repositories/logout_repository.dart';

class LogoutUser implements UseCase<bool, NoParams> {
  LogoutUser(this.repository);
  final LogoutRepository repository;

  @override
  Future<Either<Failure, bool>> call(
    NoParams params,
  ) async =>
      repository.logoutUser();
}
