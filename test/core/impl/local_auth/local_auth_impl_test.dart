import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mocktail/mocktail.dart';
import 'package:template/core/impl/local_auth/local_auth_impl.dart';

class MockLocalAuthentication extends Mock implements LocalAuthentication {}

void main() {
  LocalAuthImpl? localAuthImpl;
  MockLocalAuthentication? mockLocalAuth;

  setUp(() {
    mockLocalAuth = MockLocalAuthentication();
    localAuthImpl = LocalAuthImpl(localAuthentication: mockLocalAuth!);
  });

  group('Local Auth', () {
    group('hasBiometrics', () {
      test(
        'should forward the call to LocalAuthentication.isDeviceSupported & LocalAuthentication.canCheckBiometrics',
        () async {
          // arrange
          const tHasBiometrics = true;
          final tIsDeviceSupportedFuture = Future.value(true);
          final tCanCheckBiometricsFuture = Future.value(true);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          // act
          final result = await localAuthImpl!.hasBiometrics;
          // assert
          verify(() => mockLocalAuth!.canCheckBiometrics);
          verify(() => mockLocalAuth!.isDeviceSupported());
          verifyNever(() => localAuthImpl!.availableBiometrics);
          verifyNever(() => localAuthImpl!.hasLocalAuthenticate);
          expect(result, tHasBiometrics);
        },
      );
      test(
        'should forward the call to LocalAuthentication.isDeviceSupported',
        () async {
          // arrange
          const tHasBiometrics = false;
          final tIsDeviceSupportedFuture = Future.value(true);
          final tCanCheckBiometricsFuture = Future.value(false);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          // act
          final result = await localAuthImpl!.hasBiometrics;
          // assert
          verifyNever(() => mockLocalAuth!.isDeviceSupported());
          verify(() => mockLocalAuth!.canCheckBiometrics);
          verifyNever(() => localAuthImpl!.availableBiometrics);
          verifyNever(() => localAuthImpl!.hasLocalAuthenticate);
          expect(result, tHasBiometrics);
        },
      );
      test(
        'should forward the call to LocalAuthentication.canCheckBiometrics',
        () async {
          // arrange
          const tHasBiometrics = false;
          final tIsDeviceSupportedFuture = Future.value(false);
          final tCanCheckBiometricsFuture = Future.value(true);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          // act
          final result = await localAuthImpl!.hasBiometrics;
          // assert
          verify(() => mockLocalAuth!.canCheckBiometrics);
          verify(() => mockLocalAuth!.isDeviceSupported());
          verifyNever(() => localAuthImpl!.availableBiometrics);
          verifyNever(() => localAuthImpl!.hasLocalAuthenticate);
          expect(result, tHasBiometrics);
        },
      );
      test(
        'should return false when the call to hasBiometrics is unsuccessful',
        () async {
          // arrange
          const tHasBiometrics = false;
          final tPlatformException = PlatformException(code: '00');
          when(() => localAuthImpl!.hasBiometrics)
              .thenThrow(tPlatformException);
          // act
          final result = await localAuthImpl!.hasBiometrics;
          // assert
          expect(result, tHasBiometrics);
        },
      );
    });

    group('availableBiometrics', () {
      test(
        'should forward the call to LocalAuthentication.getAvailableBiometrics()',
        () async {
          // arrange
          final tAvailableBiometrics = [
            BiometricType.fingerprint,
            BiometricType.face
          ];
          when(() => mockLocalAuth!.getAvailableBiometrics())
              .thenAnswer((_) => Future.value(tAvailableBiometrics));
          // act
          final result = await localAuthImpl!.availableBiometrics;
          // assert
          verify(() => mockLocalAuth!.getAvailableBiometrics());
          expect(result, tAvailableBiometrics);
        },
      );
      test(
        'should return false when the call to availableBiometrics is unsuccessful',
        () async {
          // arrange
          const tBiometricsType = <BiometricType>[];
          final tPlatformException = PlatformException(code: '00');
          when(() => localAuthImpl!.availableBiometrics)
              .thenThrow(tPlatformException);
          // act
          final result = await localAuthImpl!.availableBiometrics;
          // assert
          verify(() => localAuthImpl!.availableBiometrics);
          expect(result, tBiometricsType);
        },
      );
    });

    group('hasLocalAuthenticate', () {
      test(
        'should forward the call to LocalAuthentication.authenticate succes',
        () async {
          // arrange
          const tResult = true;
          const tHasLocalAuthenticate = true;
          final tIsDeviceSupportedFuture = Future.value(true);
          final tCanCheckBiometricsFuture = Future.value(true);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          when(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          ).thenAnswer((_) => Future.value(tHasLocalAuthenticate));
          // act
          final result = await localAuthImpl!.hasLocalAuthenticate;
          // assert
          verify(() => localAuthImpl!.hasBiometrics);
          verify(() => mockLocalAuth!.isDeviceSupported());
          verify(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          );
          expect(result, tResult);
        },
      );
      test(
        'should  return false when the call to LocalAuthentication.authenticate is unsuccessful',
        () async {
          // arrange
          const tResult = false;
          const tHasLocalAuthenticate = false;
          final tIsDeviceSupportedFuture = Future.value(true);
          final tCanCheckBiometricsFuture = Future.value(true);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          when(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          ).thenAnswer((_) => Future.value(tHasLocalAuthenticate));
          // act
          final result = await localAuthImpl!.hasLocalAuthenticate;
          // assert
          verify(() => localAuthImpl!.hasBiometrics);
          verify(() => mockLocalAuth!.isDeviceSupported());
          verify(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          );
          expect(result, tResult);
        },
      );
      test(
        'should  return false when the call to LocalAuthentication.canCheckBiometrics is unsuccessful',
        () async {
          // arrange
          const tResult = false;
          const tHasLocalAuthenticate = true;
          final tIsDeviceSupportedFuture = Future.value(true);
          final tCanCheckBiometricsFuture = Future.value(false);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          when(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          ).thenAnswer((_) => Future.value(tHasLocalAuthenticate));
          // act
          final result = await localAuthImpl!.hasLocalAuthenticate;
          // assert
          verify(() => localAuthImpl!.hasBiometrics);
          verifyNever(() => mockLocalAuth!.isDeviceSupported());
          verifyNever(() => mockLocalAuth!.canCheckBiometrics);
          expect(result, tResult);
        },
      );
      test(
        'should forward the call to LocalAuthentication.isDeviceSupported() is unsuccessful',
        () async {
          // arrange
          const tResult = false;
          const tHasLocalAuthenticate = true;
          final tPlatformException = PlatformException(code: '0');
          final tCanCheckBiometricsFuture = Future.value(true);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenThrow(tPlatformException);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          when(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          ).thenAnswer((_) => Future.value(tHasLocalAuthenticate));
          // act
          final result = await localAuthImpl!.hasLocalAuthenticate;
          // assert
          verify(() => localAuthImpl!.hasBiometrics);
          verify(() => mockLocalAuth!.isDeviceSupported());
          verifyNever(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          );
          expect(result, tResult);
        },
      );
      test(
        'should return false when the call to hasLocalAuthenticate is unsuccessful',
        () async {
          // arrange
          const tHasLocalAuthenticate = false;
          final tPlatformException = PlatformException(code: '00');
          when(() => localAuthImpl!.hasLocalAuthenticate)
              .thenThrow(tPlatformException);
          // act
          final result = await localAuthImpl!.hasLocalAuthenticate;
          // assert
          verify(() => localAuthImpl!.hasLocalAuthenticate);
          expect(result, tHasLocalAuthenticate);
        },
      );
      test(
        'should return false when the call to LocalAuthentication.authenticate is unsuccessful',
        () async {
          // arrange
          const tHasLocalAuthenticate = false;
          final tPlatformException = PlatformException(code: '00');
          final tIsDeviceSupportedFuture = Future.value(true);
          final tCanCheckBiometricsFuture = Future.value(true);
          when(() => mockLocalAuth!.isDeviceSupported())
              .thenAnswer((_) => tIsDeviceSupportedFuture);
          when(() => mockLocalAuth!.canCheckBiometrics)
              .thenAnswer((_) => tCanCheckBiometricsFuture);
          when(
            () => mockLocalAuth!.authenticate(
              localizedReason: 'Scan to Authenticate',
              options: const AuthenticationOptions(
                stickyAuth: true,
              ),
            ),
          ).thenThrow(tPlatformException);
          // act
          final result = await localAuthImpl!.hasLocalAuthenticate;
          // assert
          verify(() => mockLocalAuth!.canCheckBiometrics);
          verify(() => mockLocalAuth!.isDeviceSupported());
          verifyNever(() => localAuthImpl!.hasLocalAuthenticate);
          expect(result, tHasLocalAuthenticate);
        },
      );
    });
  });
}
