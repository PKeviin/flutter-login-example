import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/utils/usecases/usecase.dart';
import 'package:template/features/login/domain/repositories/logout_repository.dart';
import 'package:template/features/login/domain/usecases/logout_user.dart';

class MockLogoutRepository extends Mock implements LogoutRepository {}

void main() {
  LogoutUser? logoutUserUsecase;
  MockLogoutRepository? mockLogoutRepository;

  setUp(() {
    mockLogoutRepository = MockLogoutRepository();
    logoutUserUsecase = LogoutUser(mockLogoutRepository!);
  });

  test('should logout user from the repository', () async {
    const tResult = true;

    // arrange
    when(() => mockLogoutRepository!.logoutUser())
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await logoutUserUsecase!(NoParams());
    // assert
    expect(result, const Right(tResult));
    verify(() => mockLogoutRepository!.logoutUser());
    verifyNoMoreInteractions(mockLogoutRepository);
  });

  test('should not logout user from the repository', () async {
    const tResult = false;

    // arrange
    when(() => mockLogoutRepository!.logoutUser())
        .thenAnswer((_) async => const Right(tResult));
    // act
    final result = await logoutUserUsecase!(NoParams());
    // assert
    expect(result, const Right(tResult));
    verify(() => mockLogoutRepository!.logoutUser());
    verifyNoMoreInteractions(mockLogoutRepository);
  });
}
