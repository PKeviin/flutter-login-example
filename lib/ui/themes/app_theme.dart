import 'package:flutter/material.dart';

import 'dark_theme.dart';
import 'light_theme.dart';

abstract class AppTheme {
  // Light
  static ThemeData smallLight = AppThemeDataLight.smallLight;
  static ThemeData mediumLight = AppThemeDataLight.mediumLight;
  static ThemeData largeLight = AppThemeDataLight.largeLight;
  // Dark
  static ThemeData smallDark = AppThemeDataDark.smallLight;
  static ThemeData mediumDark = AppThemeDataDark.mediumLight;
  static ThemeData largeDark = AppThemeDataDark.largeLight;
}
