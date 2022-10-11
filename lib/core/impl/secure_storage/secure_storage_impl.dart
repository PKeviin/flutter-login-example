import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'secure_storage_repository.dart';

const _iOptions = IOSOptions(accessibility: IOSAccessibility.first_unlock);
const AndroidOptions _androidOptions =
    AndroidOptions(encryptedSharedPreferences: true);

class SecureStorageImpl implements SecureStorageRepository {
  SecureStorageImpl({
    required this.secureStorage,
    required this.sharePreference,
  });
  FlutterSecureStorage secureStorage;
  Future<SharedPreferences> sharePreference;

  /// Phone storage initialization
  /// IOS Keychain does not delete data when uninstalling the application
  Future initSecureStorage() async {
    final prefs = await sharePreference;
    if (prefs.getBool('first_run') ?? true) {
      await secureStorage.deleteAll(
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );
      await prefs.setBool('first_run', false);
    }
  }

  /// Adding a record
  @override
  Future addItem(String key, String? value) async => secureStorage.write(
        key: key,
        value: value,
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );

  /// Retrieving a recording
  @override
  Future<String?> getItem(String key) async => secureStorage.read(
        key: key,
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );

  /// Deleting a recording
  @override
  Future removeItem(String key) async => secureStorage.delete(
        key: key,
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );

  /// Delete all records
  @override
  Future removeAll() async => secureStorage.deleteAll(
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );
}
