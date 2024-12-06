import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6CAEDD); // bleu clair
  static const Color secondary = Color(0xFFA4D65E); // vert clair
  static const Color error = Color(0xFFD84436); // rouge vif

  static const Color surface = Color(0xFFFFFFFF); // blanc pour les cartes
  static const Color background = Color(0xFFF4E4C1); // sable

  static const Color onPrimary = Colors.white; // texte sur bleu clair
  static const Color onSecondary = Colors.white; // texte sur vert clair
  static const Color onSurface = Color(0xFF333333); // texte principal
  static const Color onBackground = Color(0xFF333333); // texte secondaire
  static const Color onError = Colors.white; // texte sur fond rouge

  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF3B82CC),
    onPrimary: Colors.black,
    secondary: Color(0xFF8DBF4F),
    onSecondary: Colors.black,
    surface: Color(0xFF2C2C2C),
    onSurface: Colors.white,
    error: Color(0xFFCF6679),
    onError: Colors.black,
  );
}