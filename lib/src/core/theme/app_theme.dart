import 'package:flutter/material.dart';

import '../constants/constants.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = _themeData(_lightColorScheme);

  /// The app was designed in a light theme mode so, there's no dark theme data
  /// for now
  // static final _darkTheme = ThemeData();

  static _themeData(ColorScheme colorScheme) => ThemeData(
      textTheme: _textTheme(colorScheme),
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        color: AppColors.primary,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: AppColors.secondary,
          minimumSize: const Size(160, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36),
          ),
        ),
      ),
      tabBarTheme: const TabBarTheme());

  static final ColorScheme _lightColorScheme =
      const ColorScheme.light().copyWith(
    primary: AppColors.primary,
    onPrimary: AppColors.white,
  );

  static TextTheme _textTheme(ColorScheme colorScheme) => TextTheme(
        headline5: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: colorScheme.onPrimary,
        ),
        bodyText1: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.black,
        ),
        bodyText2: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
        subtitle2: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        button: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.onPrimary,
        ),
      );
}
