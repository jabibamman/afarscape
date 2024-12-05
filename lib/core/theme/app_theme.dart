import 'package:flutter/material.dart';
import 'colors.dart';

class DjiboutiTheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.onPrimary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    background: AppColors.background,
    onBackground: AppColors.onBackground,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    error: AppColors.error,
    onError: AppColors.onError,
  );

  static ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
    ),
    cardTheme: CardTheme(
      color: colorScheme.surface,
      shadowColor: Colors.grey.withOpacity(0.2),
      elevation: 3,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        color: colorScheme.onSurface,
        fontSize: 16,
      ),
      titleLarge: TextStyle(
        color: colorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}