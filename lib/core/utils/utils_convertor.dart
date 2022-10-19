import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class UtilsConvertor {
  UtilsConvertor._();

  /// Document recovery in base64 format
  /// [url] file url
  static Future<String> networkFileToBase64(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return base64Encode(bytes);
  }

  /// Converting a base64 to a temporary file
  /// [base64] file base64
  /// [tmpName] temporary file name
  static Future<String> base64ToFileTmp(String base64, String tmpName) async {
    final tempDir = await getTemporaryDirectory();
    final decodedBytes = base64Decode(base64);
    final file = File('${tempDir.path}/$tmpName');
    await file.writeAsBytes(decodedBytes);
    return '${tempDir.path}/$tmpName';
  }

  /// Converting a file to base 64
  /// [file] file
  static String fileToBase64(File file) {
    final bytes = file.readAsBytesSync();
    return base64Encode(bytes);
  }

  /// Convert bytes to file
  /// [bytes] bytes
  /// [name] file name
  static Future<File> bytesToFile(Uint8List bytes, String name) async {
    final tempDir = await getTemporaryDirectory();
    final formattedDate = DateFormat('MM_dd_hh').format(DateTime.now());
    final file =
        await File('${tempDir.path}/${formattedDate}_$name.png').create();
    file.writeAsBytesSync(bytes);
    return file;
  }

  /// Converting a url to a temporary pdf file
  /// [networkUrl] file url
  static Future<String> convertUrlToPdf(String networkUrl) async {
    final base64 = await networkFileToBase64(networkUrl);
    final path = await base64ToFileTmp(
      base64,
      'tmpfile-${DateTime.now().millisecondsSinceEpoch}.pdf',
    );
    return path;
  }
}
