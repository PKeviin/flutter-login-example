import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import '../../ui/colors/app_colors.dart';
import '../../ui/icons/app_icons.dart';
import '../../ui/layout/app_breakpoints.dart';
import '../../ui/spacing/app_spacing.dart';
import '../../ui/themes/app_theme.dart';
import '../constants/params_constant.dart';

class UtilsUI {
  /// Get theme data
  static ThemeData getThemeData({
    required bool isLightTheme,
  }) {
    final width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    if (width <= AppBreakpoints.small) {
      return isLightTheme ? AppTheme.smallLight : AppTheme.smallDark;
    } else if (width <= AppBreakpoints.medium) {
      return isLightTheme ? AppTheme.mediumLight : AppTheme.mediumDark;
    } else if (width <= AppBreakpoints.large) {
      return isLightTheme ? AppTheme.largeLight : AppTheme.largeDark;
    } else {
      return isLightTheme ? AppTheme.largeLight : AppTheme.largeDark;
    }
  }

  /// Display of a sucess snackbar
  static Future<void> showSucessSnackBar({
    required BuildContext context,
    required String message,
    IconData? icon,
  }) async {
    var flush = Flushbar();
    flush = Flushbar(
      margin: const EdgeInsets.all(AppSpacing.md),
      borderRadius: BorderRadius.circular(AppSpacing.xlg),
      message: message,
      shouldIconPulse: false,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        icon ?? AppIcons.checkRounded,
        color: AppColors.green,
        size: 25,
      ),
      mainButton: IconButton(
        onPressed: () => flush.dismiss(),
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          AppIcons.close,
          color: AppColors.white,
          size: 15,
        ),
      ),
      duration: const Duration(seconds: kTimerSucessSnackbar),
    );
    await flush.show(context);
  }

  /// Showing an error snackbar
  static Future<void> showErrorSnackBar({
    required BuildContext context,
    required String message,
    IconData? icon,
  }) async {
    var flush = Flushbar();
    flush = Flushbar(
      margin: const EdgeInsets.all(AppSpacing.md),
      borderRadius: BorderRadius.circular(AppSpacing.xlg),
      message: message,
      isDismissible: false,
      shouldIconPulse: false,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        icon ?? AppIcons.errorOutline,
        color: AppColors.red,
        size: 25,
      ),
      mainButton: IconButton(
        onPressed: () => flush.dismiss(),
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          AppIcons.close,
          color: AppColors.white,
          size: 15,
        ),
      ),
      duration: const Duration(seconds: kTimerErrorSnackbar),
    );
    await flush.show(context);
  }

  /// Display of a warning snackbar
  static Future<void> showWarningSnackBar({
    required BuildContext context,
    required String message,
    IconData? icon,
  }) async {
    var flush = Flushbar();
    flush = Flushbar(
      margin: const EdgeInsets.all(AppSpacing.md),
      borderRadius: BorderRadius.circular(AppSpacing.xlg),
      message: message,
      shouldIconPulse: false,
      flushbarPosition: FlushbarPosition.TOP,
      icon: Icon(
        icon ?? AppIcons.warningAmberOutlined,
        color: AppColors.orange,
        size: 25,
      ),
      mainButton: IconButton(
        onPressed: () => flush.dismiss(),
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        icon: const Icon(
          AppIcons.close,
          color: AppColors.white,
          size: 15,
        ),
      ),
      duration: const Duration(seconds: kTimerWarningSnackbar),
    );
    await flush.show(context);
  }
}
