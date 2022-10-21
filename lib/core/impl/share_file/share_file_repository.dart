import 'package:cross_file/cross_file.dart';
import 'package:share_plus/share_plus.dart';

abstract class ShareFileRepository {
  Future<ShareResult> shareXFiles({
    required List<XFile> files,
    String? text,
    String? subject,
  });
}
