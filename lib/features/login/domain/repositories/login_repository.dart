import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';
import '../entities/user.dart';

abstract class LoginRepository {
  Future<Either<Failure, User?>> loginUser();
  Future<Either<Failure, User?>> loginLocalUser();
  Future<Either<Failure, bool>> checkUserHasAlreadyLoggedIn();
}
