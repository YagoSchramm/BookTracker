import 'package:book_tracker/services/local.dart';
import 'package:shared_preferences/shared_preferences.dart';

LocalStorageService newLocalStorageService() => _SharedPreferencesLocalStorageService();

class _SharedPreferencesLocalStorageService implements LocalStorageService {
  static const _themeKey = 'app_theme_dark';

  @override
  Future<void> saveTheme(bool darkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, darkMode);
  }

  @override
  Future<bool?> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_themeKey)) {
      return null;
    }
    return prefs.getBool(_themeKey);
  }
}
