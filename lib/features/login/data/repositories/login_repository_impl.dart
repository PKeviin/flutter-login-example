import 'package:dartz/dartz.dart';

import '../../../../core/impl/network_info/network_info_repository.dart';
import '../../../../core/utils/errors/exceptions.dart';
import '../../../../core/utils/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_local_data_source/login_local_data_source_repository.dart';
import '../datasources/login_remote_data_source/login_remote_data_source_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  LoginRepositoryImpl.locale({
    required this.localDataSource,
  });
  final LoginLocalDataSourceRepository localDataSource;
  LoginRemoteDataSourceRepository? remoteDataSource;
  NetworkInfoRepository? networkInfo;

  @override
  Future<Either<Failure, User?>> loginUser() async {
    if (networkInfo != null && await networkInfo!.isConnected) {
      try {
        final user = await remoteDataSource!.login();
        await localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.toString(), statusCode: e.statutCode),
        );
      } on ParseDataException catch (e) {
        return Left(ParseDataFailure(message: e.toString()));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      try {
        final localUser = await localDataSource.getUser();
        return Right(localUser);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.toString()));
      } catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, User?>> loginLocalUser() async {
    try {
      final localUser = await localDataSource.getUser();
      return Right(localUser);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserHasAlreadyLoggedIn() async {
    try {
      final localUser = await localDataSource.getUser();
      return Right(localUser != null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
