import 'package:book_tracker/entities/book.dart';
import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';

class BooksState extends ChangeNotifier {
  bool isLoading = true;
  final String name = "Yago";
  List<Book> books = [];
  List<Book> filteredBooks = [];

  BooksState() {
    loadBooks();
  }

  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      books = await bookService.getAllBooks();
      applyFilters();
    } catch (e) {
      books = [];
      filteredBooks = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void applyFilters() {
    filteredBooks =
        books.where((book) {
          return book.totalPages > 0 &&
              book.lastPageRead > 0 &&
              book.lastPageRead < book.totalPages;
        }).toList()..sort((a, b) {
          final double pa = a.totalPages > 0
              ? a.lastPageRead / a.totalPages
              : a.lastPageRead.toDouble();
          final double pb = b.totalPages > 0
              ? b.lastPageRead / b.totalPages
              : b.lastPageRead.toDouble();

          final cmp = pb.compareTo(pa); 
          if (cmp != 0) return cmp;

          return b.lastPageRead.compareTo(a.lastPageRead);
        });
  }
}
