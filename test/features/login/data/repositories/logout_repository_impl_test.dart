import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/utils/errors/exceptions.dart';
import 'package:template/core/utils/errors/failures.dart';
import 'package:template/features/login/data/datasources/login_local_data_source/login_local_data_source_repository.dart';
import 'package:template/features/login/data/repositories/logout_repository_impl.dart';

class MockLocalDataSource extends Mock
    implements LoginLocalDataSourceRepository {}

void main() {
  LogoutRepositoryImpl? repositoryImpl;
  MockLocalDataSource? mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockLocalDataSource();
    repositoryImpl = LogoutRepositoryImpl(
      localDataSource: mockLocalDataSource!,
    );
  });

  group('logout local user', () {
    test('should return true when user is removed from cache', () async {
      const tResult = true;
      // arrange
      when(() => mockLocalDataSource!.removeUser())
          .thenAnswer((_) => Future.value());
      // act
      final result = await repositoryImpl!.logoutUser();
      // assert
      verify(() => mockLocalDataSource!.removeUser());
      expect(result, const Right(tResult));
    });
    test(
        'should return CacheFailure when user is could not be removed from cache',
        () async {
      final tCacheException =
          CacheException(message: 'message', messageEn: 'messageEn');
      // arrange
      when(() => mockLocalDataSource!.removeUser()).thenThrow(tCacheException);
      // act
      final result = await repositoryImpl!.logoutUser();
      Failure? resultFailure;
      result.fold((failure) => resultFailure = failure, (data) {});
      // assert
      verify(() => mockLocalDataSource!.removeUser());
      expect(resultFailure, isInstanceOf<CacheFailure>());
    });
  });
}
