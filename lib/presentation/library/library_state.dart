import 'package:book_tracker/entities/book.dart';
import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';

class LibraryState extends ChangeNotifier {
  bool isLoading = true;

  List<Book> books = [];

  List<Book> filteredBooks = [];

  String search = "";

  String selectedFilter = "all";

  LibraryState() {
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

  void updateSearch(String value) {
    search = value;
    applyFilters();
    notifyListeners();
  }

  void updateFilter(String value) {
    selectedFilter = value;
    applyFilters();
    notifyListeners();
  }

  void applyFilters() {
    final q = search.trim().toLowerCase();

    filteredBooks = books.where((book) {
      final title = book.title.toLowerCase();
      final matchesSearch = q.isEmpty || title.contains(q);

      bool matchesFilter = true;

      if (selectedFilter == "reading") {
        matchesFilter =
            book.totalPages > 0 &&
            book.lastPageRead > 0 &&
            book.lastPageRead < book.totalPages;
      } else if (selectedFilter == "finished") {
        matchesFilter =
            book.totalPages > 0 && book.lastPageRead >= book.totalPages;
      }

      return matchesSearch && matchesFilter;
    }).toList()
      ..sort((a, b) {
        final double pa = a.totalPages > 0
            ? a.lastPageRead / a.totalPages
            : a.lastPageRead.toDouble();
        final double pb = b.totalPages > 0
            ? b.lastPageRead / b.totalPages
            : b.lastPageRead.toDouble();

        final cmp = pb.compareTo(pa); // descending by progress
        if (cmp != 0) return cmp;

        final cmp2 = b.lastPageRead.compareTo(a.lastPageRead);
        if (cmp2 != 0) return cmp2;

        return (b.addedAt ?? '').compareTo(a.addedAt ?? '');
      });
  }
}
