import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

import 'local_auth_impl.dart';

/// LocalAuth provider
final localAuthProvider =
    Provider<LocalAuthentication>((ref) => LocalAuthentication());

/// LocalAuthImpl provider
final localAuthImplProvider = Provider<LocalAuthImpl>((ref) {
  final localAuthentication = ref.watch(localAuthProvider);
  return LocalAuthImpl(localAuthentication: localAuthentication);
});
