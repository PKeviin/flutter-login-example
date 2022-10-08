import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/secure_storage_constant.dart';
import '../impl/secure_storage_impl.dart';

final themeModeProvider = StateNotifierProvider<ThemeState, ThemeMode>((ref) {
  final secureStorage = ref.watch(secureStorageProvider);
  return ThemeState(
    secureStorageImpl: secureStorage,
  );
});

abstract class ThemeRepository {
  ThemeMode get getTheme;
  void setTheme(ThemeMode theme);
}

class ThemeState extends StateNotifier<ThemeMode> implements ThemeRepository {
  ThemeState({
    required this.secureStorageImpl,
  }) : super(ThemeMode.light) {
    unawaited(_initTheme());
  }
  SecureStorageImpl secureStorageImpl;

  /// Recovery of the theme used
  Future _initTheme() async {
    final theme = await secureStorageImpl.getItem(keyThemeMode);
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
  @override
  ThemeMode get getTheme => state;

  /// Changing the theme
  @override
  Future<void> setTheme(ThemeMode theme) async {
    state = theme;
    await secureStorageImpl.addItem(keyThemeMode, state.name);
    debugPrint('theme [${state.name}]');
  }
}
