import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_impl.dart';

/// SecureStorage provider
final secureStorageProvider =
    Provider<FlutterSecureStorage>((ref) => const FlutterSecureStorage());

/// sharedPreferences without provider
final sharedPreferences = SharedPreferences.getInstance();

/// SecureStorageImpl provider
final secureStorageImplProvider = Provider<SecureStorageImpl>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return SecureStorageImpl(
    secureStorage: secureStorage,
    sharePreference: sharedPreferences,
    iOptions: const IOSOptions(accessibility: IOSAccessibility.first_unlock),
    aOptions: const AndroidOptions(encryptedSharedPreferences: true),
  );
});
