import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/local_auth/local_auth_repository.dart';
import 'package:template/core/impl/network_info/network_info_repository.dart';
import 'package:template/core/utils/errors/exceptions.dart';
import 'package:template/core/utils/errors/failures.dart';
import 'package:template/features/login/data/datasources/login_local_data_source/login_local_data_source_repository.dart';
import 'package:template/features/login/data/datasources/login_remote_data_source/login_remote_data_source_repository.dart';
import 'package:template/features/login/data/models/user_model.dart';
import 'package:template/features/login/data/repositories/login_repository_impl.dart';

class MockRemoteDataSource extends Mock
    implements LoginRemoteDataSourceRepository {}

class MockLocalDataSource extends Mock
    implements LoginLocalDataSourceRepository {}

class MockNetworkInfo extends Mock implements NetworkInfoRepository {}

class MockLocalAuth extends Mock implements LocalAuthRepository {}

void main() {
  LoginRepositoryImpl? repositoryImpl;
  MockRemoteDataSource? mockRemoteDataSource;
  MockLocalDataSource? mockLocalDataSource;
  MockNetworkInfo? mockNetworkInfo;
  MockLocalAuth? mockLocalAuth;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    mockLocalAuth = MockLocalAuth();
    repositoryImpl = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource!,
      networkInfo: mockNetworkInfo,
      localAuth: mockLocalAuth!,
    );
  });

  group('loginUser', () {
    final tUserModel = UserModel(
      name: 'name',
      lastName: 'lastName',
      email: 'email',
      token: 'token',
    );
    final tUser = tUserModel;

    test('should check if the device is online', () async {
      // arrange
      when(() => mockNetworkInfo!.isConnected).thenAnswer((_) async => true);
      // act
      await repositoryImpl!.loginUser();
      // assert
      verify(() => mockNetworkInfo!.isConnected);
    });

    group('device is online', () {
      setUp(
        () => when(() => mockNetworkInfo!.isConnected)
            .thenAnswer((_) async => true),
      );
      test(
          'should return remote data when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource!.login())
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repositoryImpl!.loginUser();
        // assert
        verify(() => mockRemoteDataSource!.login());
        expect(result, equals(Right(tUser)));
      });

      test(
          'should cache the data locally when the call to remote data source is successful',
          () async {
        // arrange
        when(() => mockRemoteDataSource!.login())
            .thenAnswer((_) async => tUserModel);
        // act
        await repositoryImpl!.loginUser();
        // assert
        verify(() => mockRemoteDataSource!.login());
        verify(() => mockLocalDataSource!.cacheUser(tUserModel));
      });

      test('should return ServerFailure when the call to api is unsuccessful',
          () async {
        // arrange
        final tServeException = ServerException(
          message: 'error',
          messageEn: 'error',
          statusCode: -1,
        );
        when(() => mockRemoteDataSource!.login()).thenThrow(tServeException);
        // act
        final result = await repositoryImpl!.loginUser();
        Failure? resultFailure;
        result.fold((failure) => resultFailure = failure, (data) {});
        // assert
        verify(() => mockRemoteDataSource!.login());
        expect(resultFailure, isInstanceOf<ServerFailure>());
      });

      test(
          'should return CacheFailure when the call to save user is unsuccessful',
          () async {
        // arrange
        final tCacheException =
            CacheException(message: 'error', messageEn: 'error');
        when(() => mockRemoteDataSource!.login())
            .thenAnswer((_) async => tUserModel);
        when(() => mockLocalDataSource!.cacheUser(tUserModel))
            .thenThrow(tCacheException);
        // act
        final result = await repositoryImpl!.loginUser();
        Failure? resultFailure;
        result.fold((failure) => resultFailure = failure, (data) {});
        // assert
        verify(() => mockRemoteDataSource!.login());
        verify(() => mockLocalDataSource!.cacheUser(tUserModel));
        expect(resultFailure, isInstanceOf<CacheFailure>());
      });

      test(
          'should return ParseDataFailure when the call to remote data source is unsuccessful because of data',
          () async {
        // arrange
        final tParseDataException =
            ParseDataException(message: 'error', messageEn: 'error');
        when(() => mockRemoteDataSource!.login())
            .thenThrow(tParseDataException);
        // act
        final result = await repositoryImpl!.loginUser();
        Failure? resultFailure;
        result.fold((failure) => resultFailure = failure, (data) {});

        // assert
        verify(() => mockRemoteDataSource!.login());
        verifyZeroInteractions(mockLocalDataSource);
        expect(resultFailure, isInstanceOf<ParseDataFailure>());
      });
    });

    group('device is offline', () {
      setUp(
        () => when(() => mockNetworkInfo!.isConnected)
            .thenAnswer((_) async => false),
      );
      test(
          'should return local data when the call to remote data source is unsuccessful',
          () async {
        // arrange
        when(() => mockLocalDataSource!.getUser())
            .thenAnswer((_) async => tUserModel);
        // act
        final result = await repositoryImpl!.loginUser();
        // assert
        verify(() => mockLocalDataSource!.getUser());
        verifyZeroInteractions(mockRemoteDataSource);
        expect(result, equals(Right(tUser)));
      });

      test(
        'should return CacheFailure when there is no cached data present',
        () async {
          // arrange
          final tCacheException =
              CacheException(message: 'error', messageEn: 'error');
          when(() => mockLocalDataSource!.getUser()).thenThrow(tCacheException);
          // act
          final result = await repositoryImpl!.loginUser();
          Failure? resultFailure;
          result.fold((failure) => resultFailure = failure, (data) {});
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource!.getUser());
          expect(resultFailure, isInstanceOf<CacheFailure>());
        },
      );

      test(
        'should return TokenFailure when the token is no longer valid',
        () async {
          // arrange
          final tTokenException =
              TokenException(message: 'error', messageEn: 'error');
          when(() => mockLocalDataSource!.getUser()).thenThrow(tTokenException);
          // act
          final result = await repositoryImpl!.loginUser();
          Failure? resultFailure;
          result.fold((failure) => resultFailure = failure, (data) {});
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource!.getUser());
          expect(resultFailure, isInstanceOf<TokenFailure>());
        },
      );

      test(
        'should return CacheFailure when there is a problem with the data format',
        () async {
          // arrange
          final tParseDataException =
              ParseDataException(message: 'error', messageEn: 'error');
          when(() => mockLocalDataSource!.getUser())
              .thenThrow(tParseDataException);
          // act
          final result = await repositoryImpl!.loginUser();
          Failure? resultFailure;
          result.fold((failure) => resultFailure = failure, (data) {});
          // assert
          verifyZeroInteractions(mockRemoteDataSource);
          verify(() => mockLocalDataSource!.getUser());
          expect(resultFailure, isInstanceOf<CacheFailure>());
        },
      );
    });
  });

  group('loginLocalUser', () {
    final tUserModel = UserModel(
      name: 'name',
      lastName: 'lastName',
      email: 'email',
      token: 'token',
    );

    test(
        'should return LocalAuthFailure when user has no biometrics and user in cache',
        () async {
      // arrange
      final tHasBiometrics = Future.value(false);
      final tHasLocalAuthenticate = Future.value(false);
      when(() => mockLocalDataSource!.getUser())
          .thenAnswer((_) async => tUserModel);
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      when(() => mockLocalAuth!.hasLocalAuthenticate)
          .thenAnswer((_) async => tHasLocalAuthenticate);
      // act
      final result = await repositoryImpl!.loginLocalUser();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalDataSource!.getUser());
      verify(() => mockLocalAuth!.hasBiometrics);
      verifyNever(() => mockLocalAuth!.hasLocalAuthenticate);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<LocalAuthFailure>());
    });

    test(
        'should return User when user has biometrics, has auth and user in cache',
        () async {
      // arrange
      final tHasBiometrics = Future.value(true);
      final tHasLocalAuthenticate = Future.value(true);
      when(() => mockLocalDataSource!.getUser())
          .thenAnswer((_) async => tUserModel);
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      when(() => mockLocalAuth!.hasLocalAuthenticate)
          .thenAnswer((_) async => tHasLocalAuthenticate);
      // act
      final result = await repositoryImpl!.loginLocalUser();
      // assert
      verify(() => mockLocalDataSource!.getUser());
      verify(() => mockLocalAuth!.hasBiometrics);
      verify(() => mockLocalAuth!.hasLocalAuthenticate);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(result, Right(tUserModel));
    });

    test(
        'should return LocalAuthFailure when user has biometrics, no biometric auth, a user in cache',
        () async {
      // arrange
      final tHasBiometrics = Future.value(true);
      final tHasLocalAuthenticate = Future.value(false);
      when(() => mockLocalDataSource!.getUser())
          .thenAnswer((_) async => tUserModel);
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      when(() => mockLocalAuth!.hasLocalAuthenticate)
          .thenAnswer((_) async => tHasLocalAuthenticate);
      // act
      final result = await repositoryImpl!.loginLocalUser();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalDataSource!.getUser());
      verify(() => mockLocalAuth!.hasBiometrics);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<LocalAuthFailure>());
    });

    test(
        'should return CacheFailure when user has biometrics but no user in cache',
        () async {
      // arrange
      final tCacheExecption =
          CacheException(message: 'error', messageEn: 'error');
      when(() => mockLocalDataSource!.getUser()).thenThrow(tCacheExecption);
      // act
      final result = await repositoryImpl!.loginLocalUser();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalDataSource!.getUser());
      verifyNever(() => mockLocalAuth!.hasLocalAuthenticate);
      verifyNever(() => mockLocalAuth!.hasBiometrics);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<CacheFailure>());
    });

    test(
        'should return CacheFailure when user has biometrics but data format error',
        () async {
      // arrange
      final tParseDataExecption =
          ParseDataException(message: 'error', messageEn: 'error');
      when(() => mockLocalDataSource!.getUser()).thenThrow(tParseDataExecption);
      // act
      final result = await repositoryImpl!.loginLocalUser();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalDataSource!.getUser());
      verifyNever(() => mockLocalAuth!.hasLocalAuthenticate);
      verifyNever(() => mockLocalAuth!.hasBiometrics);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<CacheFailure>());
    });

    test(
        'should return CacheFailure when user has biometrics token no longer valid',
        () async {
      // arrange
      final tTokenException =
          TokenException(message: 'error', messageEn: 'error');
      when(() => mockLocalDataSource!.getUser()).thenThrow(tTokenException);
      // act
      final result = await repositoryImpl!.loginLocalUser();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalDataSource!.getUser());
      verifyNever(() => mockLocalAuth!.hasLocalAuthenticate);
      verifyNever(() => mockLocalAuth!.hasBiometrics);
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<TokenFailure>());
    });
  });

  group('checkUserHasAlreadyLoggedIn', () {
    final tUserModel = UserModel(
      name: 'name',
      lastName: 'lastName',
      email: 'email',
      token: 'token',
    );

    test(
        'should return TokenFailure when the user token in the cache is no longer valid',
        () async {
      // arrange
      final tHasBiometrics = Future.value(true);
      final tTokenException =
          TokenException(message: 'error', messageEn: 'error');
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      when(() => mockLocalDataSource!.getUser()).thenThrow(tTokenException);
      // act
      final result = await repositoryImpl!.checkUserHasAlreadyLoggedIn();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalAuth!.hasBiometrics);
      verify(() => mockLocalDataSource!.getUser());
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<TokenFailure>());
    });

    test(
        'should return CacheFailure when there is a user fetch error in the cache',
        () async {
      // arrange
      final tHasBiometrics = Future.value(true);
      final tCacheException =
          CacheException(message: 'error', messageEn: 'error');
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      when(() => mockLocalDataSource!.getUser()).thenThrow(tCacheException);
      // act
      final result = await repositoryImpl!.checkUserHasAlreadyLoggedIn();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalAuth!.hasBiometrics);
      verify(() => mockLocalDataSource!.getUser());
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(resultFailure, isInstanceOf<CacheFailure>());
    });

    test('should return true when cached user is valid & biometrics', () async {
      // arrange
      final tHasBiometrics = Future.value(true);
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      when(() => mockLocalDataSource!.getUser())
          .thenAnswer((_) async => tUserModel);
      // act
      final result = await repositoryImpl!.checkUserHasAlreadyLoggedIn();
      // assert
      verify(() => mockLocalAuth!.hasBiometrics);
      verify(() => mockLocalDataSource!.getUser());
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(result, const Right(true));
    });

    test('should return false when cached user is valid but no biometric found',
        () async {
      // arrange
      final tHasBiometrics = Future.value(false);
      when(() => mockLocalAuth!.hasBiometrics)
          .thenAnswer((_) async => tHasBiometrics);
      // act
      final result = await repositoryImpl!.checkUserHasAlreadyLoggedIn();
      // assert
      verify(() => mockLocalAuth!.hasBiometrics);
      verifyNever(() => mockLocalDataSource!.getUser());
      verifyZeroInteractions(mockRemoteDataSource);
      verifyZeroInteractions(mockNetworkInfo);
      expect(result, const Right(false));
    });
  });
}
