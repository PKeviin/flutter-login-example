import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';
import '../../../../core/utils/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/login_repository.dart';

class LoginUser implements UseCase<User?, NoParams> {
  LoginUser(this.repository);
  final LoginRepository repository;

  @override
  Future<Either<Failure, User?>> call(
    NoParams params,
  ) async =>
      repository.loginUser();
}
