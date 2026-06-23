import 'package:book_tracker/presentation/books/books_screen.dart';
import 'package:flutter/material.dart';

class HomeState extends ChangeNotifier {
  HomeState();
  int currentIndex = 0;
  void changeIndex(int index, BuildContext context) {
    currentIndex = index;
    notifyListeners();
  }

  final List<Widget> screens = [
    const BooksScreen(),
    const Center(child: Text("BIBLIOTECA")),
    const Center(child: Text("Configurações")),
  ];
}
