import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// SecureStorage provider
final secureStorageProvider =
    Provider<SecureStorageImpl>((ref) => SecureStorageImpl());

const _iOptions = IOSOptions(accessibility: IOSAccessibility.first_unlock);
const AndroidOptions _androidOptions =
    AndroidOptions(encryptedSharedPreferences: true);

abstract class SecureStorage {
  Future addItem(String key, String value);
  Future<String?> getItem(String key);
  Future removeItem(String key);
  Future removeAll();
}

class SecureStorageImpl implements SecureStorage {
  SecureStorageImpl();

  /// Phone storage initialization
  /// IOS Keychain does not delete data when uninstalling the application
  Future initSecureStorage() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      await const FlutterSecureStorage().deleteAll(
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );
      await prefs.setBool('first_run', false);
    }
  }

  /// Adding a record
  @override
  Future addItem(String key, String? value) async =>
      const FlutterSecureStorage().write(
        key: key,
        value: value,
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );

  /// Retrieving a recording
  @override
  Future<String?> getItem(String key) async =>
      const FlutterSecureStorage().read(
        key: key,
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );

  /// Deleting a recording
  @override
  Future removeItem(String key) async => const FlutterSecureStorage().delete(
        key: key,
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );

  /// Delete all records
  @override
  Future removeAll() async => const FlutterSecureStorage().deleteAll(
        iOptions: _iOptions,
        aOptions: _androidOptions,
      );
}
