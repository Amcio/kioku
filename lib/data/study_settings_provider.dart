import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StudySettingsProvider extends ChangeNotifier {
  late final SharedPreferencesWithCache _prefs;

  bool _writeMode = false;
  bool _flipAllCards = false;

  bool get writeMode => _writeMode;
  bool get flipAllCards => _flipAllCards;

  StudySettingsProvider(this._prefs) {
    _loadPreferences();
  }

  void setWriteMode(bool newMode) async {
    if (_writeMode != newMode) {
      _writeMode = newMode;
      notifyListeners();
      await _prefs.setBool('write_mode', newMode);
    }
  }

  void setFlipCards(bool newMode) async {
    if (_flipAllCards != newMode) {
      _flipAllCards = newMode;
      notifyListeners();
      await _prefs.setBool('flip_all_cards', newMode);
    }
  }

  void _loadPreferences() async {
    final bool? lastWriteMode = _prefs.getBool('write_mode');
    if (lastWriteMode != null) {
      _writeMode = lastWriteMode;
    }

    final bool? lastFlipCards = _prefs.getBool('flip_all_cards');
    if (lastFlipCards != null) {
      _flipAllCards = lastFlipCards;
    }
    notifyListeners();
  }
}
