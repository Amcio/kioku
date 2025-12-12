import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  Color _materialColor = Colors.red;

  ThemeMode get themeMode => _themeMode;
  Color get materialColor => _materialColor;

  ThemeProvider() {
    _loadPreferences();
  }

  void setTheme(ThemeMode mode) async {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('theme_mode', mode.index);
    }
  }

  void setCustomColor(Color color) async {
    if (_materialColor != color) {
      _materialColor = color;
      notifyListeners();
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('material_color_value', color.value);
    }
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load ThemeMode
    final int? savedTheme = prefs.getInt('theme_mode');
    if (savedTheme != null && savedTheme >= 0 && savedTheme < ThemeMode.values.length) {
      _themeMode = ThemeMode.values[savedTheme];
    }

    // Load Material Color
    final int? savedColor = prefs.getInt('material_color_value');
    if (savedColor != null) {
      _materialColor = Color(savedColor);
    }
    
    notifyListeners();
  }
}
