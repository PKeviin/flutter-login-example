abstract class SecureStorageRepository {
  Future addItem(String key, String? value);
  Future<String?> getItem(String key);
  Future removeItem(String key);
  Future removeAll();
}
