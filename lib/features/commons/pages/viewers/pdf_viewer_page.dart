import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/enums/file_format_enum.dart';
import '../../../../core/impl/share_file/share_file_provider.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/icons/app_icons.dart';

class PdfViewerPage extends ConsumerWidget {
  const PdfViewerPage({
    required this.name,
    super.key,
    this.fileFormat = FileFormatEnum.file,
    this.localPath,
    this.showDownload = false,
    this.showShare = true,
  });
  final String name;
  final FileFormatEnum fileFormat;
  final String? localPath;
  final bool showDownload;
  final bool showShare;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        appBar: AppBar(title: Text(name)),
        floatingActionButton: showShare
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: () => share(ref),
                child: Icon(AppIcons.shareOutlined, color: AppColors.white),
              )
            : const SizedBox.shrink(),
        body: _getBody(),
      );

  /// Viewing page content
  Widget _getBody() {
    switch (fileFormat) {
      case FileFormatEnum.file:
        return SfPdfViewer.file(File(localPath!));
      case FileFormatEnum.base64:
      case FileFormatEnum.network:
        break;
    }
    return const SizedBox.shrink();
  }

  /// Share pdf
  Future<void> share(WidgetRef ref) async {
    final shareProvider = ref.read(shareFileImplProvider);
    final filePath = localPath ?? '';
    await shareProvider.shareXFiles(
      files: [XFile(filePath, mimeType: 'application/pdf')],
      text: name,
    );
  }
}
