import 'package:flutter/material.dart';

class AppColorSchemes {
  static const Color primary = Color(0xFF2196F3);
  static const Color primaryDark = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF64B5F6);

  static const Color secondary = Color(0xFF03A9F4);
  static const Color accent = Color(0xFF00BCD4);

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFE53935);
  static const Color info = Color(0xFF2196F3);

  static const Color highRisk = Color(0xFFE53935);
  static const Color moderateRisk = Color(0xFFFF9800);
  static const Color vusRisk = Color(0xFF9C27B0);
  static const Color lowRisk = Color(0xFF4CAF50);

  static const Color lightBackground = Color(0xFFF5F7FA);
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  static const ColorScheme lightColorScheme = ColorScheme.light(
    primary: primary,
    secondary: secondary,
    error: error,
    surface: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: textPrimary,
  );

  static const ColorScheme darkColorScheme = ColorScheme.dark(
    primary: primary,
    secondary: secondary,
    error: error,
    surface: darkSurface,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
  );
}
