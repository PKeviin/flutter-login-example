import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../repositories/login_repository.dart';

class CheckUserHasAlreadyLoggedIn implements UseCase<bool, NoParams> {
  CheckUserHasAlreadyLoggedIn(this.repository);
  final LoginRepository repository;

  @override
  Future<Either<Failure, bool>> call(
    NoParams params,
  ) async =>
      repository.checkUserHasAlreadyLoggedIn();
}
