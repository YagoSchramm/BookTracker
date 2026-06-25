import 'package:book_tracker/entities/book.dart';
import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';

class BooksState extends ChangeNotifier {
  bool isLoading = true;
  final String name = "Yago";
  List<Book> books = [];

  BooksState() {
    loadBooks();
  }

  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      books = await bookService.getAllBooks();
    } catch (e) {
      books = [];
    }

    isLoading = false;
    notifyListeners();
  }
}