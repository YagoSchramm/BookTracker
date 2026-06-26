import 'package:book_tracker/presentation/books/books_screen.dart';
import 'package:book_tracker/presentation/library/library_screen.dart';
import 'package:book_tracker/presentation/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  HomeState();
  int currentIndex = 0;
  void changeIndex(int index, BuildContext context) {
    currentIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    BooksScreen(),
    LibraryScreen(),
    const SettingsScreen(),
  ];
}
