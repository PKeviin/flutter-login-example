import 'package:flutter/widgets.dart';

import '../colors/app_colors.dart';
import 'app_font_weight.dart';

class AppTextStyle {
  // TODO(PKeviin): Using the theme text set 2021 instead of 2018
  // displayLarge, displayMedium, displaySmall
  // headlineMedium, headlineSmall
  // titleLarge, titleMedium, titleSmall
  // bodyLarge, bodyMedium, bodySmall
  // labelLarge, labelSmall

  static const _baseTextStyle = TextStyle(
    // To use a font family defined in a package,
    // the package argument must be provided.
    // For instance, suppose the font declaration above is in the pubspec.yaml
    // of a package named my_package which the app depends on.
    package: 'template',
    fontFamily: 'OpenSans',
    color: AppColors.black,
    fontWeight: AppFontWeight.regular,
  );

  /// Headline 1 Text Style
  static TextStyle get headline1 => _baseTextStyle.copyWith(
        fontSize: 56,
        fontWeight: AppFontWeight.medium,
      );

  /// Headline 2 Text Style
  static TextStyle get headline2 => _baseTextStyle.copyWith(
        fontSize: 30,
        fontWeight: AppFontWeight.regular,
      );

  /// Headline 3 Text Style
  static TextStyle get headline3 => _baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: AppFontWeight.regular,
      );

  /// Headline 4 Text Style
  static TextStyle get headline4 => _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
      );

  /// Headline 5 Text Style
  static TextStyle get headline5 => _baseTextStyle.copyWith(
        fontSize: 20,
        fontWeight: AppFontWeight.medium,
      );

  /// Headline 6 Text Style
  static TextStyle get headline6 => _baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: AppFontWeight.bold,
      );

  /// Subtitle 1 Text Style
  static TextStyle get subtitle1 => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.bold,
      );

  /// Subtitle 2 Text Style
  static TextStyle get subtitle2 => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.bold,
      );

  /// Body Text 1 Text Style
  static TextStyle get bodyText1 => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: AppFontWeight.medium,
      );

  /// Body Text 2 Text Style (the default)
  static TextStyle get bodyText2 => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      );

  /// Caption Text Style
  static TextStyle get caption => _baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: AppFontWeight.regular,
      );

  /// Overline Text Style
  static TextStyle get overline => _baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: AppFontWeight.regular,
      );

  /// Button Text Style
  static TextStyle get button => _baseTextStyle.copyWith(
        fontSize: 18,
        fontWeight: AppFontWeight.medium,
      );
}
