import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/secure_storage_constant.dart';
import 'secure_storage_repository.dart';

class SecureStorageImpl implements SecureStorageRepository {
  SecureStorageImpl({
    required this.secureStorage,
    required this.sharePreference,
    this.iOptions,
    this.aOptions,
  });
  FlutterSecureStorage secureStorage;
  Future<SharedPreferences> sharePreference;
  IOSOptions? iOptions;
  AndroidOptions? aOptions;

  /// Phone storage initialization
  /// IOS Keychain does not delete data when uninstalling the application
  Future<void> initSecureStorage() async {
    final prefs = await sharePreference;
    if (prefs.getBool(keyFirstRun) ?? true) {
      await secureStorage.deleteAll(
        iOptions: iOptions,
        aOptions: aOptions,
      );
      await prefs.setBool(keyFirstRun, false);
    }
  }

  /// Adding a record
  @override
  Future<void> addItem(String key, String? value) async => secureStorage.write(
        key: key,
        value: value,
        iOptions: iOptions,
        aOptions: aOptions,
      );

  /// Retrieving a recording
  @override
  Future<String?> getItem(String key) async => secureStorage.read(
        key: key,
        iOptions: iOptions,
        aOptions: aOptions,
      );

  /// Deleting a recording
  @override
  Future<void> removeItem(String key) async => secureStorage.delete(
        key: key,
        iOptions: iOptions,
        aOptions: aOptions,
      );

  /// Delete all records
  @override
  Future<void> removeAll() async => secureStorage.deleteAll(
        iOptions: iOptions,
        aOptions: aOptions,
      );
}
