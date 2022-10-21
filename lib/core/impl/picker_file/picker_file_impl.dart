import 'dart:io';

import 'package:file_picker/file_picker.dart';

import 'picker_file_repository.dart';

class PickerFileImpl implements PickerFileRepository {
  PickerFileImpl({
    required this.filePicker,
  });
  final FilePicker filePicker;

  /// Retrieve one or more attachments
  /// [allowedExtensions] extensions allowed
  @override
  Future<List<File>> pickerFiles({
    required List<String> allowedExtensions,
    required bool allowMultiple,
  }) async {
    var files = <File>[];
    final result = await filePicker.pickFiles(
      allowMultiple: allowMultiple,
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );
    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();
    }
    return files;
  }
}
