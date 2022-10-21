import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/utils/usecases/usecase.dart';
import 'package:template/features/login/domain/repositories/login_repository.dart';
import 'package:template/features/login/domain/usecases/check_user_has_already_logged_in.dart';

class MockCheckUserHasAlreadyLoggedInRepository extends Mock
    implements LoginRepository {}

void main() {
  CheckUserHasAlreadyLoggedIn? checkUserHasAlreadyLoggedInUseCase;
  MockCheckUserHasAlreadyLoggedInRepository?
      mockCheckUserHasAlreadyLoggedInRepository;

  setUp(() {
    mockCheckUserHasAlreadyLoggedInRepository =
        MockCheckUserHasAlreadyLoggedInRepository();
    checkUserHasAlreadyLoggedInUseCase =
        CheckUserHasAlreadyLoggedIn(mockCheckUserHasAlreadyLoggedInRepository!);
  });

  test('should check user has already logged in from the repository', () async {
    const tResult = true;

    // arrange
    when(
      () => mockCheckUserHasAlreadyLoggedInRepository!
          .checkUserHasAlreadyLoggedIn(),
    ).thenAnswer((_) async => const Right(tResult));
    // act
    final result = await checkUserHasAlreadyLoggedInUseCase!(NoParams());
    // assert
    expect(result, const Right(tResult));
    verify(
      () => mockCheckUserHasAlreadyLoggedInRepository!
          .checkUserHasAlreadyLoggedIn(),
    );
    verifyNoMoreInteractions(mockCheckUserHasAlreadyLoggedInRepository);
  });

  test('should check user has not logged in from the repository', () async {
    const tResult = false;

    // arrange
    when(
      () => mockCheckUserHasAlreadyLoggedInRepository!
          .checkUserHasAlreadyLoggedIn(),
    ).thenAnswer((_) async => const Right(tResult));
    // act
    final result = await checkUserHasAlreadyLoggedInUseCase!(NoParams());
    // assert
    expect(result, const Right(tResult));
    verify(
      () => mockCheckUserHasAlreadyLoggedInRepository!
          .checkUserHasAlreadyLoggedIn(),
    );
    verifyNoMoreInteractions(mockCheckUserHasAlreadyLoggedInRepository);
  });
}
