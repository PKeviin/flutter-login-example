import 'dart:io';

abstract class PickerFileRepository {
  Future<List<File>> pickerFiles({
    required List<String> allowedExtensions,
    required bool allowMultiple,
  });
}
