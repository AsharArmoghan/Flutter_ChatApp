import 'package:flutter/material.dart';

ThemeData appleIOSLightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF007AFF),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Color(0xFF007AFF),
    primary: Color(0xFF007AFF), // iOS system blue
    primaryContainer: Color(0xFF0056D3),
    secondary: Color(0xFF30D158), // iOS green
    secondaryContainer: Color(0xFFE5F5E8),
    surface: Color(0xFFFFFFFF),
    surfaceContainerHighest: Color(0xFFF2F2F7), // iOS light background
    error: Color(0xFFFF3B30), // iOS red
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFF000000),
    onError: Color(0xFFFFFFFF),
    outline: Color(0xFFC6C6C8), // iOS separator
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFFF2F2F7),
    foregroundColor: Color(0xFF000000),
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF007AFF),
      foregroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: Color(0xFF000000),
    ),
    displayMedium: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000),
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000),
    ),
    headlineMedium: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        color: Color(0xFF007AFF),
        letterSpacing: 1.4),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000),
    ),
    titleLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF000000),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF8E8E93), // iOS secondary label
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF8E8E93),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Color(0xFF000000),
    ),
  ),
);
