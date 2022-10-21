import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/secure_storage/secure_storage_impl.dart';
import 'package:template/core/locales/generated/l10n.dart';
import 'package:template/core/utils/errors/exceptions.dart';
import 'package:template/features/login/data/datasources/login_local_data_source/login_local_data_source_impl.dart';
import 'package:template/features/login/data/models/user_model.dart';

import '../../../../fixtures/fixure_reader.dart';

class MockSecureStorageImpl extends Mock implements SecureStorageImpl {}

Future<void> main() async {
  const locale = 'en';
  TestWidgetsFlutterBinding.ensureInitialized();
  await S.load(const Locale.fromSubtags(languageCode: locale));

  LoginLocalDataSourceImpl? localDataSourceImpl;
  MockSecureStorageImpl? mockSecureStorageImpl;

  setUp(() {
    mockSecureStorageImpl = MockSecureStorageImpl();
    localDataSourceImpl =
        LoginLocalDataSourceImpl(secureStorage: mockSecureStorageImpl!);
  });

  final tUser = UserModel(
    id: 1,
    name: 'Name test',
    lastName: 'Last Name test',
    email: 'Email test',
    token: 'Token test',
    mobile: 'Mobile test',
  );

  group('locale user', () {
    group('get user from cache', () {
      test('should throw a TokenException when the token format is invalid',
          () async {
        final tUserJson = fixture('user.json');
        // arrange
        when(() => mockSecureStorageImpl!.getItem(any()))
            .thenAnswer((_) async => Future.value(tUserJson));
        // act
        final call = localDataSourceImpl!.getUser();
        // assert
        expect(() => call, throwsA(isA<TokenException>()));
      });

      test('should throw a TokenException when the token is expired', () async {
        // arrange
        final tUserJson = fixture('user_token_expired.json');
        when(() => mockSecureStorageImpl!.getItem(any()))
            .thenAnswer((_) async => Future.value(tUserJson));
        // act
        final call = localDataSourceImpl!.getUser();
        // assert
        expect(() => call, throwsA(isA<TokenException>()));
      });

      test('should throw a CacheException when the json string is null',
          () async {
        // arrange
        when(() => mockSecureStorageImpl!.getItem(any()))
            .thenAnswer((_) async => null);
        // act
        final call = localDataSourceImpl!.getUser();
        // assert
        expect(() => call, throwsA(isA<CacheException>()));
      });

      test('should throw a CacheException when get user from cache', () async {
        // arrange
        final tException =
            CacheException(message: 'message', messageEn: 'messageEn');
        when(() => mockSecureStorageImpl!.getItem(any())).thenThrow(tException);
        // act
        final call = localDataSourceImpl!.getUser();
        // assert
        expect(() => call, throwsA(isA<CacheException>()));
      });
    });

    group('cache user', () {
      test('should call SecureStorageImpl to cache the user data', () async {
        // arrange
        when(() => mockSecureStorageImpl!.addItem(any(), any()))
            .thenAnswer((_) async => Future.value());
        // act
        await localDataSourceImpl!.cacheUser(tUser);
        // assert
        verify(() => mockSecureStorageImpl!.addItem(any(), any()));
      });

      test('should throw a CacheException when saved user is null', () async {
        // act
        final call = localDataSourceImpl!.cacheUser(null);
        // assert
        expect(() => call, throwsA(isA<CacheException>()));
      });

      test('should throw a CacheException when save is user fails', () async {
        // arrange
        final tException =
            CacheException(message: 'message', messageEn: 'messageEn');
        when(() => mockSecureStorageImpl!.addItem(any(), any()))
            .thenThrow(tException);
        // act
        final call = localDataSourceImpl!.cacheUser(tUser);
        // assert
        expect(() => call, throwsA(isA<CacheException>()));
      });
    });

    group('remove user from cache', () {
      test('should call SecureStorageImpl to remove the user data', () async {
        // arrange
        when(() => mockSecureStorageImpl!.removeItem(any()))
            .thenAnswer((_) async => Future.value());
        // act
        await localDataSourceImpl!.removeUser();
        // assert
        verify(() => mockSecureStorageImpl!.removeItem(any()));
      });

      test('should throw a CacheException when remove user from cache fails',
          () async {
        // arrange
        final tException =
            CacheException(message: 'message', messageEn: 'messageEn');
        when(() => mockSecureStorageImpl!.removeItem(any()))
            .thenThrow(tException);
        // act
        final call = localDataSourceImpl!.removeUser();
        // assert
        expect(() => call, throwsA(isA<CacheException>()));
      });
    });
  });
}
