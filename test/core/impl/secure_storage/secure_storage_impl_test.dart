import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template/core/constants/secure_storage_constant.dart';
import 'package:template/core/impl/secure_storage/secure_storage_impl.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SecureStorageImpl? secureStorageImpl;
  MockFlutterSecureStorage? mockFlutterSecureStorage;
  Future<SharedPreferences>? mockSharedPreference;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    mockSharedPreference = SharedPreferences.getInstance();
    mockFlutterSecureStorage = MockFlutterSecureStorage();
    secureStorageImpl = SecureStorageImpl(
      secureStorage: mockFlutterSecureStorage!,
      sharePreference: mockSharedPreference!,
    );
  });

  const tKey = 'counter';
  const tValue = '42';

  group('init FlutterSecureStorage', () {
    test(
        "should delete app data (FlutterSecureStorage) if it's the first launch (first_run)",
        () async {
      // arrange
      const tResult = false;
      final prefs = await mockSharedPreference;
      when(() => mockFlutterSecureStorage!.deleteAll())
          .thenAnswer((_) async => {});
      // act
      await secureStorageImpl!.initSecureStorage();
      // assert
      verify(() => mockFlutterSecureStorage!.deleteAll());
      expect(prefs!.getBool(keyFirstRun), tResult);
    });

    test(
        "should delete app data (FlutterSecureStorage) if it's the first launch (not first_run)",
        () async {
      // arrange
      const tResult = false;
      final prefs = await mockSharedPreference;
      await prefs!.setBool(keyFirstRun, false);
      when(() => mockFlutterSecureStorage!.deleteAll())
          .thenAnswer((_) async => {});
      // act
      await secureStorageImpl!.initSecureStorage();
      // assert
      verifyNever(() => mockFlutterSecureStorage!.deleteAll());
      expect(prefs.getBool(keyFirstRun), tResult);
    });
  });

  group('FlutterSecureStorage', () {
    test('should store a value', () async {
      // arrange
      when(() => mockFlutterSecureStorage!.write(key: tKey, value: tValue))
          .thenAnswer((_) async => {});
      // act
      await secureStorageImpl!.addItem(tKey, tValue);
      // assert
      verify(() => mockFlutterSecureStorage!.write(key: tKey, value: tValue));
    });

    test('should save and then retrieve the saved value', () async {
      // arrange
      when(() => mockFlutterSecureStorage!.write(key: tKey, value: tValue))
          .thenAnswer((_) async => {});
      when(() => mockFlutterSecureStorage!.read(key: tKey))
          .thenAnswer((_) async => Future.value(tValue));
      // act
      final result = await secureStorageImpl!.getItem(tKey);
      // assert
      verify(() => mockFlutterSecureStorage!.read(key: tKey));
      expect(result, tValue);
    });

    test('should save and then delete the saved value', () async {
      // arrange
      when(() => mockFlutterSecureStorage!.write(key: tKey, value: tValue))
          .thenAnswer((_) async => {});
      when(() => mockFlutterSecureStorage!.delete(key: tKey))
          .thenAnswer((_) async => {});
      // act
      await secureStorageImpl!.removeItem(tKey);
      // assert
      verify(() => mockFlutterSecureStorage!.delete(key: tKey));
    });

    test('should save multiple values and delete them', () async {
      // arrange
      const tKey2 = 'counter2';
      const tValue2 = '10';
      // act
      when(() => mockFlutterSecureStorage!.write(key: tKey, value: tValue))
          .thenAnswer((_) async => {});
      when(() => mockFlutterSecureStorage!.write(key: tKey2, value: tValue2))
          .thenAnswer((_) async => {});
      when(() => mockFlutterSecureStorage!.deleteAll())
          .thenAnswer((_) async => {});
      // act
      await secureStorageImpl!.removeAll();
      // assert
      verify(() => mockFlutterSecureStorage!.deleteAll());
    });
  });
}
