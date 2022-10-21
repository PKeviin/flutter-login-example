import 'package:cross_file/cross_file.dart';
import 'package:share_plus/share_plus.dart';

import 'share_file_repository.dart';

class ShareFileImpl implements ShareFileRepository {
  ShareFileImpl();

  /// Sharing the pdf file
  @override
  Future<ShareResult> shareXFiles({
    required List<XFile> files,
    String? text,
    String? subject,
  }) async =>
      Share.shareXFiles(
        files,
        text: text,
        subject: text,
      );
}
