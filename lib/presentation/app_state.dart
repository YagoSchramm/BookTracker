import 'package:book_tracker/global.dart';
import 'package:book_tracker/services/local.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  AppState({LocalStorageService? storageService}) {
    _storageService = storageService ?? localStorageService;
    _loadTheme();
  }

  late final LocalStorageService _storageService;
  ThemeMode themeMode = ThemeMode.system;

  Future<void> _loadTheme() async {
    final savedTheme = await _storageService.getTheme();
    if (savedTheme != null) {
      themeMode = savedTheme ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (themeMode == mode) {
      return;
    }

    themeMode = mode;
    notifyListeners();
    await _storageService.saveTheme(mode == ThemeMode.dark);
  }
}
