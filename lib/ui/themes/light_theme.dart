import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../spacing/app_spacing.dart';
import '../typography/app_text_styles.dart';

const _smallTextScaleFactor = 0.90;
const _largeTextScaleFactor = 1.20;

/// Namespace for the App [ThemeData].
class AppThemeDataLight {
  /// Standard `ThemeData` for App UI.
  static ThemeData get _standardLight => ThemeData(
        brightness: Brightness.light,
        backgroundColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.white,
        hintColor: AppColors.black25,
        primaryColor: AppColors.primary,
        errorColor: AppColors.red,
        colorScheme: const ColorScheme.light().copyWith(
          brightness: Brightness.light,
          primary: AppColors.secondary,
          secondary: AppColors.secondary,
          secondaryContainer: AppColors.secondary,
        ),
        appBarTheme: _appBarTheme,
        elevatedButtonTheme: _elevatedButtonTheme,
        outlinedButtonTheme: _outlinedButtonTheme,
        textTheme: _textTheme,
        dialogBackgroundColor: AppColors.whiteBackground,
        dialogTheme: _dialogTheme,
        tooltipTheme: _tooltipTheme,
        bottomSheetTheme: _bottomSheetTheme,
        tabBarTheme: _tabBarTheme,
        dividerTheme: _dividerTheme,
      );

  /// `ThemeData` for App UI for small screens.
  static ThemeData get smallLight =>
      _standardLight.copyWith(textTheme: _smallTextTheme);

  /// `ThemeData` for App UI for medium screens.
  static ThemeData get mediumLight =>
      _standardLight.copyWith(textTheme: _smallTextTheme);

  /// `ThemeData` for App UI for large screens.
  static ThemeData get largeLight =>
      _standardLight.copyWith(textTheme: _largeTextTheme);

  static TextTheme get _textTheme => TextTheme(
        headline1: AppTextStyle.headline1,
        headline2: AppTextStyle.headline2,
        headline3: AppTextStyle.headline3,
        headline4: AppTextStyle.headline4,
        headline5: AppTextStyle.headline5,
        headline6: AppTextStyle.headline6,
        subtitle1: AppTextStyle.subtitle1,
        subtitle2: AppTextStyle.subtitle2,
        bodyText1: AppTextStyle.bodyText1,
        bodyText2: AppTextStyle.bodyText2,
        caption: AppTextStyle.caption,
        overline: AppTextStyle.overline,
        button: AppTextStyle.button,
      );

  static TextTheme get _smallTextTheme => TextTheme(
        headline1: AppTextStyle.headline1.copyWith(
          fontSize: _textTheme.headline1!.fontSize! * _smallTextScaleFactor,
        ),
        headline2: AppTextStyle.headline2.copyWith(
          fontSize: _textTheme.headline2!.fontSize! * _smallTextScaleFactor,
        ),
        headline3: AppTextStyle.headline3.copyWith(
          fontSize: _textTheme.headline3!.fontSize! * _smallTextScaleFactor,
        ),
        headline4: AppTextStyle.headline4.copyWith(
          fontSize: _textTheme.headline4!.fontSize! * _smallTextScaleFactor,
        ),
        headline5: AppTextStyle.headline5.copyWith(
          fontSize: _textTheme.headline5!.fontSize! * _smallTextScaleFactor,
        ),
        headline6: AppTextStyle.headline6.copyWith(
          fontSize: _textTheme.headline6!.fontSize! * _smallTextScaleFactor,
        ),
        subtitle1: AppTextStyle.subtitle1.copyWith(
          fontSize: _textTheme.subtitle1!.fontSize! * _smallTextScaleFactor,
        ),
        subtitle2: AppTextStyle.subtitle2.copyWith(
          fontSize: _textTheme.subtitle2!.fontSize! * _smallTextScaleFactor,
        ),
        bodyText1: AppTextStyle.bodyText1.copyWith(
          fontSize: _textTheme.bodyText1!.fontSize! * _smallTextScaleFactor,
        ),
        bodyText2: AppTextStyle.bodyText2.copyWith(
          fontSize: _textTheme.bodyText2!.fontSize! * _smallTextScaleFactor,
        ),
        caption: AppTextStyle.caption.copyWith(
          fontSize: _textTheme.caption!.fontSize! * _smallTextScaleFactor,
          color: AppColors.black54,
        ),
        overline: AppTextStyle.overline.copyWith(
          fontSize: _textTheme.overline!.fontSize! * _smallTextScaleFactor,
        ),
        button: AppTextStyle.button.copyWith(
          fontSize: _textTheme.button!.fontSize! * _smallTextScaleFactor,
        ),
      );

  static TextTheme get _largeTextTheme => TextTheme(
        headline1: AppTextStyle.headline1.copyWith(
          fontSize: _textTheme.headline1!.fontSize! * _largeTextScaleFactor,
        ),
        headline2: AppTextStyle.headline2.copyWith(
          fontSize: _textTheme.headline2!.fontSize! * _largeTextScaleFactor,
        ),
        headline3: AppTextStyle.headline3.copyWith(
          fontSize: _textTheme.headline3!.fontSize! * _largeTextScaleFactor,
        ),
        headline4: AppTextStyle.headline4.copyWith(
          fontSize: _textTheme.headline4!.fontSize! * _largeTextScaleFactor,
        ),
        headline5: AppTextStyle.headline5.copyWith(
          fontSize: _textTheme.headline5!.fontSize! * _largeTextScaleFactor,
        ),
        headline6: AppTextStyle.headline6.copyWith(
          fontSize: _textTheme.headline6!.fontSize! * _largeTextScaleFactor,
        ),
        subtitle1: AppTextStyle.subtitle1.copyWith(
          fontSize: _textTheme.subtitle1!.fontSize! * _largeTextScaleFactor,
        ),
        subtitle2: AppTextStyle.subtitle2.copyWith(
          fontSize: _textTheme.subtitle2!.fontSize! * _largeTextScaleFactor,
        ),
        bodyText1: AppTextStyle.bodyText1.copyWith(
          fontSize: _textTheme.bodyText1!.fontSize! * _largeTextScaleFactor,
        ),
        bodyText2: AppTextStyle.bodyText2.copyWith(
          fontSize: _textTheme.bodyText2!.fontSize! * _largeTextScaleFactor,
        ),
        caption: AppTextStyle.caption.copyWith(
          fontSize: _textTheme.caption!.fontSize! * _largeTextScaleFactor,
          color: AppColors.black54,
        ),
        overline: AppTextStyle.overline.copyWith(
          fontSize: _textTheme.overline!.fontSize! * _largeTextScaleFactor,
        ),
        button: AppTextStyle.button.copyWith(
          fontSize: _textTheme.button!.fontSize! * _largeTextScaleFactor,
        ),
      );

  static AppBarTheme get _appBarTheme =>
      const AppBarTheme(color: AppColors.primary);

  static ElevatedButtonThemeData get _elevatedButtonTheme =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.primary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          fixedSize: const Size(208, 54),
        ),
      );

  static OutlinedButtonThemeData get _outlinedButtonTheme =>
      OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
          side: const BorderSide(color: AppColors.white, width: 2),
          fixedSize: const Size(208, 54),
        ),
      );

  static TooltipThemeData get _tooltipTheme => const TooltipThemeData(
        decoration: BoxDecoration(
          color: AppColors.charcoal,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        padding: EdgeInsets.all(AppSpacing.s10),
        textStyle: TextStyle(color: AppColors.white),
      );

  static DialogTheme get _dialogTheme => DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      );

  static BottomSheetThemeData get _bottomSheetTheme =>
      const BottomSheetThemeData(
        backgroundColor: AppColors.whiteBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
      );

  static TabBarTheme get _tabBarTheme => const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            width: 2,
            color: AppColors.primary,
          ),
        ),
        labelColor: AppColors.primary,
        unselectedLabelColor: AppColors.black25,
        indicatorSize: TabBarIndicatorSize.tab,
      );

  static DividerThemeData get _dividerTheme => const DividerThemeData(
        space: 0,
        thickness: 1,
        color: AppColors.black25,
      );
}
