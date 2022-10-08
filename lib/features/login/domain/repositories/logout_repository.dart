import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';

//ignore: one_member_abstracts
abstract class LogoutRepository {
  Future<Either<Failure, bool>>? logoutUser();
}
