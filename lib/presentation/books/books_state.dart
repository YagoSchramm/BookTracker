import 'package:book_tracker/entities/book.dart';
import 'package:book_tracker/entities/user.dart';
import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';

class BooksState extends ChangeNotifier {
  bool isLoading = true;
  User? user;
  List<Book> books = [];
  List<Book> filteredBooks = [];
  List<bool> weekDaysRead = List<bool>.filled(7, false);

  BooksState() {
    loadBooks();
  }

  String get name => user?.username ?? 'Reader';
  int get pageGoal => user?.pageGoal ?? 0;
  int get pagesRead => user?.pagesRead ?? 0;
  int get totalBooks => books.length;

  Future<void> loadBooks() async {
    isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        bookService.getAllBooks(),
        userService.getUser(),
        userService.getReadingDates(days: 7),
      ]);

      books = results[0] as List<Book>;
      user = results[1] as User?;
      final dates = results[2] as List<String>;
      weekDaysRead = _buildWeekDaysRead(dates);

      final pagesReadFromBooks =
          books.fold<int>(0, (sum, book) => sum + book.lastPageRead);

      if (user != null && user!.pagesRead != pagesReadFromBooks) {
        await userService.updatePagesRead(pagesReadFromBooks);
        user = user!.copyWith(pagesRead: pagesReadFromBooks);
      }

      applyFilters();
    } catch (e) {
      books = [];
      filteredBooks = [];
      user = null;
      weekDaysRead = List<bool>.filled(7, false);
    }

    isLoading = false;
    notifyListeners();
  }

  List<bool> _buildWeekDaysRead(List<String> dates) {
    final dateSet = dates.toSet();
    final today = DateTime.now();
    return List<bool>.generate(7, (index) {
      final date = today.subtract(Duration(days: 6 - index));
      final key = date.toIso8601String().substring(0, 10);
      return dateSet.contains(key);
    });
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
