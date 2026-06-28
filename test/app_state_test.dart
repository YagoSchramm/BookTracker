import 'package:book_tracker/presentation/app_state.dart';
import 'package:book_tracker/services/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeLocalStorageService implements LocalStorageService {
  bool? savedTheme;

  @override
  Future<bool> getTheme() async => savedTheme ?? false;

  @override
  Future<void> saveTheme(bool darkMode) async {
    savedTheme = darkMode;
  }
}

void main() {
  test('loads the persisted theme mode from storage', () async {
    final storage = FakeLocalStorageService()..savedTheme = true;
    final appState = AppState(storageService: storage);

    await Future<void>.delayed(Duration.zero);

    expect(appState.themeMode, ThemeMode.dark);
  });

  test('persists the selected theme mode', () async {
    final storage = FakeLocalStorageService();
    final appState = AppState(storageService: storage);

    await appState.setThemeMode(ThemeMode.dark);

    expect(storage.savedTheme, isTrue);
  });
}
