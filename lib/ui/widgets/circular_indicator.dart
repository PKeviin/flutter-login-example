import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/commons/providers/theme_provider.dart';
import '../colors/app_colors.dart';

/// Display of the indicator according to the platform
class CircularIndicator extends ConsumerWidget {
  const CircularIndicator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return Theme(
      data: ThemeData(
        cupertinoOverrideTheme: CupertinoThemeData(
          brightness:
              theme == ThemeMode.light ? Brightness.light : Brightness.dark,
        ),
      ),
      child: const CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondary),
      ),
    );
  }
}
