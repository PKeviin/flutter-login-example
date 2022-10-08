import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/login_repository.dart';

class LoginUser {
  LoginUser(this.repository);
  final LoginRepository repository;

  Future<Either<Failure, UserEntity?>?> loginUser(
    NoParams params,
  ) async =>
      await repository.loginUser();

  Future<Either<Failure, UserEntity?>?> loginLocaleUser(
    NoParams params,
  ) async =>
      await repository.loginLocaleUser();
}
