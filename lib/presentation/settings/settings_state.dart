import 'package:book_tracker/entities/user.dart';
import 'package:book_tracker/global.dart';
import 'package:book_tracker/presentation/app_state.dart';
import 'package:flutter/material.dart';

class SettingsState extends ChangeNotifier {
  SettingsState({required this.appState}) {
    appState.addListener(_handleAppStateChanged);
    loadUser();
  }

  final AppState appState;
  bool isLoading = true;
  bool isSaving = false;
  User? user;
  String username = '';
  int pageGoal = 0;

  void _handleAppStateChanged() {
    notifyListeners();
  }

  @override
  void dispose() {
    appState.removeListener(_handleAppStateChanged);
    super.dispose();
  }

  Future<void> loadUser() async {
    isLoading = true;
    notifyListeners();

    user = await userService.getUser();
    if (user != null) {
      username = user!.username;
      pageGoal = user!.pageGoal;
    }

    isLoading = false;
    notifyListeners();
  }

  void updateUsernameInput(String value) {
    username = value;
    notifyListeners();
  }

  void updatePageGoalInput(int value) {
    pageGoal = value;
    notifyListeners();
  }

  Future<void> saveUsername() async {
    if (user == null) return;

    isSaving = true;
    notifyListeners();

    await userService.updateUsername(username);
    user = user!.copyWith(username: username);

    isSaving = false;
    notifyListeners();
  }

  Future<void> savePageGoal() async {
    if (user == null) return;

    isSaving = true;
    notifyListeners();

    await userService.updatePageGoal(pageGoal);
    user = user!.copyWith(pageGoal: pageGoal);

    isSaving = false;
    notifyListeners();
  }
}
