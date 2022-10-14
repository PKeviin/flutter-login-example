import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';

abstract class LogoutRepository {
  Future<Either<Failure, bool>> logoutUser();
}
