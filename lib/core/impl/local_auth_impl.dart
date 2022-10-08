import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

/// LocalAuth provider
final localAuthProvider = Provider<LocalAuthImpl>((ref) => LocalAuthImpl());

abstract class LocalAuth {
  Future<bool>? get hasBiometrics;
  Future<List<BiometricType>>? get availableBiometrics;
  Future<bool>? get hasLocalAuthenticate;
}

class LocalAuthImpl implements LocalAuth {
  LocalAuthImpl();

  /// Checks if biometric authentication is available
  @override
  Future<bool> get hasBiometrics async {
    try {
      return await LocalAuthentication().canCheckBiometrics &&
          await LocalAuthentication().isDeviceSupported();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return false;
    }
  }

  /// Authentication recovery available
  @override
  Future<List<BiometricType>> get availableBiometrics async {
    try {
      return await LocalAuthentication().getAvailableBiometrics();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return <BiometricType>[];
    }
  }

  /// User authentication
  @override
  Future<bool> get hasLocalAuthenticate async {
    if (await hasBiometrics) {
      try {
        return await LocalAuthentication().authenticate(
          localizedReason: 'Scan to Authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
      } on PlatformException catch (e) {
        if (kDebugMode) {
          print(e.message);
        }
        return false;
      }
    } else {
      return false;
    }
  }
}
