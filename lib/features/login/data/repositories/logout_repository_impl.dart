import 'package:dartz/dartz.dart';

import '../../../../core/utils/errors/exceptions.dart';
import '../../../../core/utils/errors/failures.dart';
import '../../domain/repositories/logout_repository.dart';
import '../datasources/user_local_data_source.dart';

class LogoutRepositoryImpl implements LogoutRepository {
  LogoutRepositoryImpl({
    required this.localDataSource,
  });
  final UserLocalDataSource localDataSource;

  @override
  Future<Either<Failure, bool>>? logoutUser() async {
    try {
      await localDataSource.removeUser();
      return const Right(true);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
