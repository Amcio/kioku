import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _materialColor = Colors.red;
  late final SharedPreferences _prefs;

  ThemeMode get themeMode => _themeMode;
  Color get materialColor => _materialColor;

  ThemeProvider(this._prefs) {
    _loadPreferences();
  }

  void setTheme(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      await _prefs.setInt('theme_mode', mode.index);
    }
  }

  void setCustomColor(Color color) async {
    if (_materialColor != color) {
      _materialColor = color;
      notifyListeners();

      await _prefs.setInt('material_color_value', color.toARGB32());
    }
  }

  void _loadPreferences() async {
    // Load ThemeMode
    final int? savedTheme = _prefs.getInt('theme_mode');
    if (savedTheme != null &&
        savedTheme >= 0 &&
        savedTheme < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[savedTheme];
    }

    // Load Material Color
    final int? savedColor = _prefs.getInt('material_color_value');
    if (savedColor != null) {
      _materialColor = Color(savedColor);
    }

    notifyListeners();
  }
}
