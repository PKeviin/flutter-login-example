import 'package:dartz/dartz.dart';

import '../../../../core/constants/errors_en_message_constant.dart';
import '../../../../core/impl/local_auth/local_auth_repository.dart';
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
    required this.localAuth,
    this.remoteDataSource,
    this.networkInfo,
  });

  final LoginLocalDataSourceRepository localDataSource;
  final LocalAuthRepository localAuth;
  NetworkInfoRepository? networkInfo;
  LoginRemoteDataSourceRepository? remoteDataSource;

  @override
  Future<Either<Failure, User?>> loginUser() async {
    if (remoteDataSource != null &&
        networkInfo != null &&
        await networkInfo!.isConnected) {
      try {
        final user = await remoteDataSource!.login();
        await localDataSource.cacheUser(user);
        return Right(user);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(message: e.toString(), statusCode: e.statusCode),
        );
      } on ParseDataException catch (e) {
        return Left(ParseDataFailure(message: e.toString()));
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.toString()));
      } catch (e) {
        return Left(ServerFailure(message: e.toString(), statusCode: -1));
      }
    } else {
      try {
        final localUser = await localDataSource.getUser();
        return Right(localUser);
      } on TokenException catch (e) {
        return Left(TokenFailure(message: e.toString()));
      } catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, User?>> loginLocalUser() async {
    try {
      final localUser = await localDataSource.getUser();
      final hasBiometrics = await localAuth.hasBiometrics;
      if (hasBiometrics && await localAuth.hasLocalAuthenticate) {
        return Right(localUser);
      } else {
        return Left(LocalAuthFailure(message: kErrorBiometrics));
      }
    } on TokenException catch (e) {
      return Left(TokenFailure(message: e.toString()));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> checkUserHasAlreadyLoggedIn() async {
    try {
      if (await localAuth.hasBiometrics) {
        await localDataSource.getUser();
        return const Right(true);
      } else {
        return const Right(false);
      }
    } on TokenException catch (e) {
      return Left(TokenFailure(message: e.toString()));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
