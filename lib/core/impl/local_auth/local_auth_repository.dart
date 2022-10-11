import 'package:local_auth/local_auth.dart';

abstract class LocalAuthRepository {
  Future<bool> get hasBiometrics;
  Future<List<BiometricType>> get availableBiometrics;
  Future<bool> get hasLocalAuthenticate;
}
