import 'dart:convert';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/api/api_http_impl.dart';
import 'package:template/core/impl/api/models/api_response_entity.dart';
import 'package:template/core/locales/generated/l10n.dart';
import 'package:template/core/utils/errors/exceptions.dart';
import 'package:template/features/login/data/datasources/login_remote_data_source/login_remote_data_source_impl.dart';
import 'package:template/features/login/data/models/user_model.dart';

import '../../../../fixtures/fixure_reader.dart';

class MockApiHttpImpl extends Mock implements ApiHttpImpl {}

Future<void> main() async {
  const locale = 'en';
  TestWidgetsFlutterBinding.ensureInitialized();
  await S.load(const Locale.fromSubtags(languageCode: locale));

  LoginRemoteDataSourceImpl? loginRemoteDataSourceImpl;
  MockApiHttpImpl? mockApiHttpImpl;

  setUp(() {
    mockApiHttpImpl = MockApiHttpImpl();
    loginRemoteDataSourceImpl = LoginRemoteDataSourceImpl(
      api: mockApiHttpImpl!,
      username: 'username',
      password: 'password',
    );
  });

  final tUser = UserModel(
    id: 1,
    name: 'Name test',
    lastName: 'Last Name test',
    email: 'Email test',
    token: 'Token test',
    mobile: 'Mobile test',
  );

  group('login user', () {
    test('should return user model when login is successful', () async {
      // arrange
      final tResult = APIJsonResponse(
        data: json.decode(fixture('user.json')),
        statusCode: 200,
      );
      when(
        () => mockApiHttpImpl!.post(
          route: '/user/login',
          body: {
            'username': loginRemoteDataSourceImpl!.username,
            'password': loginRemoteDataSourceImpl!.password,
          },
        ),
      ).thenAnswer((_) async => tResult);
      // act
      final result = await loginRemoteDataSourceImpl!.login();
      // assert
      verify(
        () => mockApiHttpImpl!.post(
          route: '/user/login',
          body: {
            'username': loginRemoteDataSourceImpl!.username,
            'password': loginRemoteDataSourceImpl!.password,
          },
        ),
      );
      expect(result, tUser);
    });

    test(
        'should throw a ServerException when the call to server is unsuccessful',
        () async {
      // arrange
      final tException = ServerException(
        statusCode: 404,
        message: 'message',
        messageEn: 'messageEn',
      );
      when(
        () => mockApiHttpImpl!.post(
          route: '/user/login',
          body: {
            'username': loginRemoteDataSourceImpl!.username,
            'password': loginRemoteDataSourceImpl!.password,
          },
        ),
      ).thenThrow(tException);
      // act
      final call = loginRemoteDataSourceImpl!.login;
      // assert
      expect(call, throwsA(isA<ServerException>()));
    });

    test(
        'should throw a ParseDataException when the call parse data is unsuccessful',
        () async {
      // arrange
      final tResult = APIJsonResponse(
        data: json.decode('{"id": 1}'),
        statusCode: 200,
      );
      when(
        () => mockApiHttpImpl!.post(
          route: '/user/login',
          body: {
            'username': loginRemoteDataSourceImpl!.username,
            'password': loginRemoteDataSourceImpl!.password,
          },
        ),
      ).thenAnswer((_) async => tResult);
      // act
      final call = loginRemoteDataSourceImpl!.login;
      // assert
      expect(call, throwsA(isA<ParseDataException>()));
    });
  });
}
