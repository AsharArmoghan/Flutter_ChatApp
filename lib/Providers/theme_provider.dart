import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { system, light, dark }

class ThemeNotifier extends StateNotifier<AppThemeMode> {
  static const _themeModeKey = 'theme_mode';

  ThemeNotifier() : super(AppThemeMode.system);

  // Change theme mode (light/dark/system)
  Future<void> setThemeMode(AppThemeMode mode) async {
    if (state == mode) return;

    state = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, mode.toString().split('.').last);
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, AppThemeMode>(
    (ref) => ThemeNotifier());

extension AppThemeModeExtension on AppThemeMode {
  ThemeMode get flutterMode {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
  }
}
