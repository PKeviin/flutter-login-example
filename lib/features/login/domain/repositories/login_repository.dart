import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, UserEntity?>>? loginUser();
  Future<Either<Failure, UserEntity?>>? loginLocaleUser();
}
