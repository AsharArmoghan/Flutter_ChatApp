import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appleIOSDarkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF0A84FF),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color(0xFF0A84FF),
    brightness: Brightness.dark,
    primary: Color(0xFF0A84FF),
    primaryContainer: Color(0xFF409CFF),
    secondary: Color(0xFF32D74B),
    secondaryContainer: Color(0xFF1E4A28),
    surface: Color(0xFF1C1C1E),
    surfaceContainerHighest: Color(0xFF2C2C2E),
    error: Color(0xFFFF453A),
    onPrimary: Color(0xFFFFFFFF),
    onSecondary: Color(0xFFFFFFFF),
    onSurface: Color(0xFFFFFFFF),
    onError: Color(0xFFFFFFFF),
    outline: Color(0xFF38383A),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF1C1C1E),
    foregroundColor: Color(0xFFFFFFFF),
    elevation: 0,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0A84FF),
      foregroundColor: const Color(0xFFFFFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: const Color(0xFFFFFFFF),
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: 60,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFFFF),
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: 48,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFFFF),
    ),
    headlineMedium: GoogleFonts.inter(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        color: Color(0xFF007AFF),
        letterSpacing: 1.4),
    headlineSmall: GoogleFonts.inter(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFFFF),
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: const Color(0xFFFFFFFF),
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Color(0xFF8E8E93),
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: Color(0xFF8E8E93),
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: const Color(0xFFFFFFFF),
    ),
  ),
);
