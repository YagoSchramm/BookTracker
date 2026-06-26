import 'package:book_tracker/entities/book.dart';
import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerState extends ChangeNotifier {
  final Book book;
  late final PdfController pdfController;
  int initialPage = 1;
  bool _hasRegisteredReadingToday = false;

  PdfViewerState({required this.book}) {
    initialPage = book.lastPageRead == 0 ? 1 : book.lastPageRead;

    pdfController = PdfController(
      document: PdfDocument.openFile(book.filePath),
      initialPage: initialPage,
    );
    pdfController.pageListenable.addListener(_onPageChanged);
  }

  void _saveProgress() {
    final currentPage = pdfController.page;
    if (currentPage != initialPage) {
      bookService.updateLastPageRead(book.id, currentPage);
      initialPage = currentPage;
    }
    if (!_hasRegisteredReadingToday) {
      _hasRegisteredReadingToday = true;
      userService.registerReadingToday();
    }
  }

  void _onPageChanged() {
    _saveProgress();
  }

  void previousPage() {
    pdfController.previousPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  void nextPage() {
    pdfController.nextPage(
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }
}
