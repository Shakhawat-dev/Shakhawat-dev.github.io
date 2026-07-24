import 'package:flutter/material.dart';

/// Drives the light/dark toggle in the nav bar. Defaults to dark, which
/// suits the accent palette best, but the visitor's system preference is
/// respected on first load.
class AppThemeProvider extends ChangeNotifier {
  AppThemeProvider({ThemeMode initial = ThemeMode.dark}) : _mode = initial;

  ThemeMode _mode;
  ThemeMode get mode => _mode;

  bool get isDark => _mode == ThemeMode.dark;

  void toggle() {
    _mode = isDark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
