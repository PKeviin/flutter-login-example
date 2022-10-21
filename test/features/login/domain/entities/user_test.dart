import 'package:flutter_test/flutter_test.dart';
import 'package:template/features/login/domain/entities/session.dart';
import 'package:template/features/login/domain/entities/user.dart';

void main() {
  const tUser = User(
    name: 'Name test',
    lastName: 'Last Name test',
    email: 'Email test',
    session: Session(token: 'Token test'),
    id: 1,
  );
  const tUserCopy = User(
    name: 'Name test copy',
    lastName: 'Last Name test copy',
    email: 'Email test copy',
    session: Session(token: 'Token test copy'),
    id: 2,
  );

  test('should return a valid copy object', () async {
    // act
    final result = tUser.copyWith(
      name: tUserCopy.name,
      lastName: tUserCopy.lastName,
      email: tUserCopy.email,
      session: tUserCopy.session,
      id: tUserCopy.id,
    );
    // assert
    expect(result, tUserCopy);
  });
}
