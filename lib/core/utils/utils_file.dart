import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:share_plus/share_plus.dart';

class UtilsFile {
  UtilsFile._();

  /// Sharing the pdf file
  static Future<void> shareFile(
    List<String> localPaths,
    String name,
    List<String> mimeTypes,
  ) async {
    // TODO(PKeviin): use shareXFiles
    await Share.shareFiles(
      localPaths,
      text: name,
      subject: name,
      mimeTypes: mimeTypes,
    );
  }

  /// Retrieve one or more attachments
  /// [allowedExtensions] extensions allowed
  static Future<List<File>> selectFiles({
    required List<String> allowedExtensions,
    required bool allowMultiple,
  }) async {
    var files = <File>[];
    final result = await FilePicker.platform.pickFiles(
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
