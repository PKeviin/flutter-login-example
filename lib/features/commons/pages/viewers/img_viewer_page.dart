import 'dart:io';

import 'package:flutter/material.dart';
import '../../../../core/enums/file_format_enum.dart';
import '../../../../core/locales/generated/l10n.dart';
import '../../../../core/utils/utils_file.dart';
import '../../../../ui/colors/app_colors.dart';
import '../../../../ui/icons/app_icons.dart';
import '../../../../ui/spacing/app_spacing.dart';
import '../../../../ui/widgets/circular_indicator.dart';

class ImgViewerPage extends StatelessWidget {
  const ImgViewerPage({
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
        body: _getBody(),
        floatingActionButton: showShare && localPath != null
            ? FloatingActionButton(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                onPressed: () async => UtilsFile.shareFile(
                  [localPath!],
                  name,
                  [],
                ),
                child: Icon(
                  AppIcons.shareOutlined,
                  color: AppColors.white,
                ),
              )
            : const SizedBox.shrink(),
      );

  /// Image display
  Widget _getBody() => SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.s10),
            child: fileFormat == FileFormatEnum.network
                ? Image.network(
                    networkUrl!,
                    loadingBuilder: (context, child, progress) =>
                        progress == null
                            ? InteractiveViewer(
                                minScale: 0.1,
                                maxScale: 4,
                                child: child,
                              )
                            : const Center(child: CircularIndicator()),
                    errorBuilder: (context, ex, stacktrace) => Center(
                      child: Text(S.current.errorSomethingWentWrong),
                    ),
                  )
                : fileFormat == FileFormatEnum.file
                    ? InteractiveViewer(
                        minScale: 0.1,
                        maxScale: 4,
                        child: Image.file(File(localPath!)),
                      )
                    : const SizedBox.shrink(),
          ),
        ),
      );
}
