import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/utils/usecases/usecase.dart';
import 'package:template/features/login/domain/entities/user.dart';
import 'package:template/features/login/domain/repositories/login_repository.dart';
import 'package:template/features/login/domain/usecases/login_user.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  LoginUser? loginUserUsecase;
  MockLoginRepository? mockLoginRepository;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    loginUserUsecase = LoginUser(mockLoginRepository!);
  });

  const tUser = User(
    name: 'name',
    lastName: 'lastName',
    email: 'email@gmail.com',
  );

  test('should login user from the repository', () async {
    // arrange
    when(() => mockLoginRepository!.loginUser())
        .thenAnswer((_) async => const Right(tUser));
    // act
    final result = await loginUserUsecase!(NoParams());
    // assert
    expect(result, const Right(tUser));
    verify(() => mockLoginRepository!.loginUser());
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
