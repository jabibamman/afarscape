import 'package:flutter/material.dart';
import 'colors.dart';

class DjiboutiTheme {
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    error: AppColors.error,
    onError: AppColors.onError,
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    scaffoldBackgroundColor: lightColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: lightColorScheme.primary,
      foregroundColor: lightColorScheme.onPrimary,
    ),
    cardTheme: CardTheme(
      color: lightColorScheme.surface,
      shadowColor: Colors.grey.withOpacity(0.2),
      elevation: 3,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: lightColorScheme.onSurface,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: lightColorScheme.onSurface,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        color: lightColorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );

  static ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: AppColors.darkColorScheme,
    scaffoldBackgroundColor: AppColors.darkColorScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColorScheme.primary,
      foregroundColor: AppColors.darkColorScheme.onPrimary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkColorScheme.primary,
      foregroundColor: AppColors.darkColorScheme.onPrimary,
    ),
    cardTheme: CardTheme(
      color: AppColors.darkColorScheme.surface,
      shadowColor: Colors.black.withOpacity(0.5),
      elevation: 3,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.darkColorScheme.onSurface,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkColorScheme.onSurface,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        color: AppColors.darkColorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}
