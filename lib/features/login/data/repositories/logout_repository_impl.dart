import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/failures.dart';
import '../../domain/repositories/logout_repository.dart';
import '../datasources/login_local_data_source/login_local_data_source_repository.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  LogoutRepositoryImpl({
    required this.localDataSource,
  });
  final LoginLocalDataSourceRepository localDataSource;

  @override
  Future<Either<Failure, bool>> logoutUser() async {
    try {
      await localDataSource.removeUser();
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
