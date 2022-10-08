import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../core/enums/file_format_enum.dart';
import '../../../../core/utils/utils_convertor.dart';
import '../../../../core/utils/utils_file.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/icons/app_icons.dart';

class PdfViewerPage extends StatelessWidget {
  const PdfViewerPage({
    required this.name,
    super.key,
    this.fileFormat = FileFormatEnum.file,
    this.networkUrl,
    this.localPath,
    this.showDownload = false,
    this.showShare = false,
  });
  final String name;
  final FileFormatEnum fileFormat;
  final String? networkUrl;
  final String? localPath;
  final bool showDownload;
  final bool showShare;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(name)),
        floatingActionButton: showShare
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: share,
                child: Icon(AppIcons.shareOutlined, color: AppColors.white),
              )
            : const SizedBox.shrink(),
        body: _getBody(),
      );

  /// Viewing page content
  Widget _getBody() {
    switch (fileFormat) {
      case FileFormatEnum.network:
        return SfPdfViewer.network(networkUrl!);
      case FileFormatEnum.file:
        return SfPdfViewer.file(File(localPath!));
      case FileFormatEnum.base64:
    }
    return const SizedBox.shrink();
  }

  /// Share pdf
  Future<void> share() async {
    var filePath = localPath ?? '';
    if (filePath == '' && fileFormat == FileFormatEnum.network) {
      filePath = await UtilsConvertor.convertUrlToPdf(networkUrl!);
    }
    return UtilsFile.shareFile(
      [filePath],
      name,
      ['application/pdf'],
    );
  }
}
