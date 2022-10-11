import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'local_auth_repository.dart';

class LocalAuthImpl implements LocalAuthRepository {
  LocalAuthImpl({
    required this.localAuthentication,
  });
  LocalAuthentication localAuthentication;

  /// Checks if biometric authentication is available
  @override
  Future<bool> get hasBiometrics async {
    try {
      return await localAuthentication.canCheckBiometrics &&
          await localAuthentication.isDeviceSupported();
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return false;
    }
  }

  /// Authentication recovery available
  @override
  Future<List<BiometricType>> get availableBiometrics async {
    try {
      return await localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint(e.message);
      return <BiometricType>[];
    }
  }

  /// User authentication
  @override
  Future<bool> get hasLocalAuthenticate async {
    if (await hasBiometrics) {
      try {
        return await localAuthentication.authenticate(
          localizedReason: 'Scan to Authenticate',
          options: const AuthenticationOptions(
            stickyAuth: true,
          ),
        );
      } on PlatformException catch (e) {
        debugPrint(e.message);
        return false;
      }
    } else {
      return false;
    }
  }
}
