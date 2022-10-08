import 'package:dartz/dartz.dart';

import '../../../../core/impl/network_info_impl.dart';
import '../../../../core/utils/errors/exceptions.dart';
import '../../../../core/utils/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_remote_data_source.dart';
import '../datasources/user_local_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  LoginRepositoryImpl.locale({
    required this.localDataSource,
  });
  final UserLocalDataSource localDataSource;
  LoginRemoteDataSource? remoteDataSource;
  NetworkInfo? networkInfo;

  @override
  Future<Either<Failure, UserEntity?>> loginUser() async {
    if (await networkInfo!.isConnected!) {
      try {
        final user = await remoteDataSource!.login();
        await localDataSource.saveUser(user);
        return Right(user?.toEntity());
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.toString(), statusCode: e.statutCode),
        );
      } on ParseDataException catch (e) {
        return Left(ParseDataFailure(message: e.toString()));
      } on Exception catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    } else {
      try {
        final localUser = await localDataSource.getUser();
        return Right(localUser?.toEntity());
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.toString()));
      } on Exception catch (e) {
        return Left(UnknownFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> loginLocaleUser() async {
    try {
      final localUser = await localDataSource.getUser();
      return Right(localUser?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.toString()));
    } on Exception catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
