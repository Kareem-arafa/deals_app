import 'package:flutter/material.dart';

enum ThemeName { DARK, LIGHT }

class AppTheme {
  static final AppTheme _singleton = new AppTheme._internal();
  static ThemeName _themeName = ThemeName.LIGHT;

  factory AppTheme() {
    return _singleton;
  }

  AppTheme._internal();

  static void configure(ThemeName themeName) {
    _themeName = themeName;
  }

  ThemeData get appTheme {
    switch (_themeName) {
      case ThemeName.DARK:
        return _buildDarkTheme();
      default: // Flavor.PRO:
        return _buildLightTheme();
    }
  }

  TextTheme _buildTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.bodyText1?.copyWith(
        fontFamily: 'Almarai',
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    const Color primaryColor = const Color(0xFF3B3B48);
    final ThemeData base = new ThemeData.dark();
    return base.copyWith(
      primaryColor: primaryColor,
      indicatorColor: const Color(0xFF3F3F4C),
      hintColor: Colors.blueAccent,
      canvasColor: const Color(0xFF2B2B2B),
      scaffoldBackgroundColor: const Color(0xFF2E2E3B),
      errorColor: const Color(0xFFB00020),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      colorScheme: ColorScheme(
        background: const Color(0xFF2E2E3B),
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: primaryColor,
        secondary: Colors.blueAccent,
        onSecondary: Colors.blueAccent,
        error: const Color(0xFFB00020),
        onError: const Color(0xFFB00020),
        onBackground: const Color(0xFF2E2E3B),
        surface: primaryColor,
        onSurface: primaryColor,
      ),
    );
  }

  ThemeData _buildLightTheme() {
    const Color primaryColor = Color.fromRGBO(149, 42, 22, 1.0);
    final ThemeData base = new ThemeData(fontFamily: 'Almarai');
    return base.copyWith(
      primaryColor: primaryColor,
      indicatorColor: const Color(0xFF3F3F4C),
      hintColor: Colors.blueAccent,
      canvasColor: const Color(0xFF2B2B2B),
      scaffoldBackgroundColor: const Color(0xFF2E2E3B),
      errorColor: const Color(0xFFB00020),
      buttonTheme: const ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
      ),
      textTheme: _buildTextTheme(base.textTheme),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
      colorScheme: ColorScheme(
        background: const Color(0xFF2E2E3B),
        brightness: Brightness.light,
        primary: primaryColor,
        onPrimary: primaryColor,
        secondary: Colors.blueAccent,
        onSecondary: Colors.blueAccent,
        error: const Color(0xFFB00020),
        onError: const Color(0xFFB00020),
        onBackground: const Color(0xFF2E2E3B),
        surface: primaryColor,
        onSurface: primaryColor,
      ),
    );
  }
}
