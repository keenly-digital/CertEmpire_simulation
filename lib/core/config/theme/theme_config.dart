import 'package:flutter/material.dart';

import '../../utils/breakpoints_config.dart';
import 'app_colors.dart';
import 'font_manager.dart';

class ThemeConfig {
  // Define custom font family
  static const String fontFamily = 'Montserrat';
  // static const String fontFamily = 'Nasalization';

  // Font size scaling
  static double _responsiveFontSize(double baseSize) {
    if (BreakpointConfig().isDesktop) {
      return baseSize * 1.1;
    } else if (BreakpointConfig().isTablet) {
      return baseSize * 1.05;
    } else {
      return baseSize;
    }
  }

  /// Generate a responsive TextTheme
  static TextTheme responsiveTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(57),
        fontWeight: FontManager.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(45),
        fontWeight: FontManager.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(36),
        fontWeight: FontManager.bold,
      ),
      headlineLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(32),
        fontWeight: FontManager.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(28),
        fontWeight: FontManager.semiBold,
      ),
      headlineSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(24),
        fontWeight: FontManager.semiBold,
      ),
      titleLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(18),
        fontWeight: FontManager.medium,
      ),
      titleMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(16),
        fontWeight: FontManager.medium,
      ),
      titleSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(14),
        fontWeight: FontManager.medium,
      ),
      bodyLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(15),
        fontWeight: FontManager.regular,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(14),
        fontWeight: FontManager.regular,
      ),
      bodySmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(12),
        fontWeight: FontManager.regular,
      ),
      labelLarge: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(14),
        fontWeight: FontManager.medium,
      ),
      labelMedium: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(12),
        fontWeight: FontManager.medium,
      ),
      labelSmall: TextStyle(
        fontFamily: fontFamily,
        fontSize: _responsiveFontSize(10),
        fontWeight: FontManager.light,
      ),
    );
  }

  static ThemeData lightTheme() {
    final textTheme = responsiveTextTheme();
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: AppColors.purple,
        onPrimary: AppColors.lightOnPrimary,
        secondary: AppColors.lightSecondary,
        surface: AppColors.lightSurface,
        error: AppColors.lightError,
        onError: AppColors.lightOnError,
        onSurface: AppColors.lightOnSurface,
      ),
      useMaterial3: true,
      textTheme: responsiveTextTheme(),
      inputDecorationTheme: _inputDecorationTheme(textTheme),
      elevatedButtonTheme: _elevatedButtonTheme(textTheme),
      outlinedButtonTheme: _outlinedButtonTheme(textTheme),
      textButtonTheme: _textButtonTheme(textTheme),
    );
  }

  static ThemeData darkTheme() {
    final textTheme = responsiveTextTheme();

    return ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkOnPrimary,
        secondary: AppColors.darkSecondary,
        surface: AppColors.darkSurface,
        error: AppColors.darkError,
        onError: AppColors.darkOnError,
        onSurface: AppColors.darkOnSurface,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.lightBackground,
      textTheme: responsiveTextTheme(),
      inputDecorationTheme: _inputDecorationTheme(textTheme),
      elevatedButtonTheme: _elevatedButtonTheme(textTheme),
      outlinedButtonTheme: _outlinedButtonTheme(textTheme),
      textButtonTheme: _textButtonTheme(textTheme),
      cardTheme: CardThemeData(
        color: AppColors.lightSurface,
        elevation: 2,
        shadowColor: Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static InputDecorationTheme _inputDecorationTheme(TextTheme textTheme) {
    return InputDecorationTheme(
      fillColor: AppColors.grey, // Light grey fill color
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 10.0,
      ),
      hintStyle: textTheme.bodySmall?.copyWith(color: AppColors.hint),
      labelStyle: textTheme.titleMedium?.copyWith(
        color: AppColors.lightPrimary,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: AppColors.lightBackground,
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: AppColors.lightPrimary, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: AppColors.lightBackground,
          width: 1.0,
        ),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(TextTheme textTheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.lightBackground,
        backgroundColor: AppColors.lightPrimary,
        textStyle: textTheme.labelMedium, // Use labelLarge for buttons
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(TextTheme textTheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: textTheme.labelLarge, // Use labelLarge for buttons
        side: const BorderSide(color: AppColors.lightPrimary, width: 1.5),
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(TextTheme textTheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Makes the border rectangular
        ),
        textStyle: textTheme.labelLarge!.copyWith(
          color: AppColors.lightPrimary,
        ), // Use labelLarge for buttons
      ),
    );
  }
}
