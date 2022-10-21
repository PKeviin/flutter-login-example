import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/secure_storage_constant.dart';
import '../../../core/impl/secure_storage/secure_storage_provider.dart';
import '../../../core/impl/secure_storage/secure_storage_repository.dart';
import '../../../ui/layout/app_breakpoints.dart';
import '../../../ui/themes/app_theme.dart';

final themeModeProvider = StateNotifierProvider<ThemeState, ThemeMode>((ref) {
  final secureStorage = ref.watch(secureStorageImplProvider);
  return ThemeState(
    secureStorage: secureStorage,
  );
});

class ThemeState extends StateNotifier<ThemeMode> {
  ThemeState({
    required this.secureStorage,
  }) : super(ThemeMode.light) {
    initTheme();
  }
  SecureStorageRepository secureStorage;

  /// Recovery of the theme used
  Future initTheme() async {
    final theme = await secureStorage.getItem(keyThemeMode);
    if (theme != null) {
      switch (theme) {
        case 'light':
          state = ThemeMode.light;
          break;
        case 'dark':
          state = ThemeMode.dark;
          break;
        case 'system':
          state = ThemeMode.system;
          break;
        default:
          state = ThemeMode.system;
          break;
      }
    } else {
      state = ThemeMode.light;
    }
    debugPrint('theme [${state.name}]');
  }

  /// Get theme
  ThemeMode get getTheme => state;

  /// Changing the theme
  Future<void> setTheme(ThemeMode theme) async {
    state = theme;
    await secureStorage.addItem(keyThemeMode, state.name);
    debugPrint('theme [${state.name}]');
  }

  /// Get theme data
  ThemeData getThemeData({required bool isLightTheme}) {
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
}
