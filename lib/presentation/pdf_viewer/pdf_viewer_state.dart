import 'package:book_tracker/entities/book.dart';
import 'package:book_tracker/global.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class PdfViewerState extends ChangeNotifier {
  final Book book;
  late final PdfController pdfController;
  int initialPage = 1;
  PdfViewerState({required this.book}) {
    initialPage = book.lastPageRead == 0 ? 1 : book.lastPageRead;

    pdfController = PdfController(
      document: PdfDocument.openFile(book.filePath),
      initialPage: initialPage,
    );
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
    final bool pageChanged = pdfController.page != initialPage;
    if (pageChanged){
      
    }
    bookService.updateLastPageRead(book.id, pdfController.page);
    pdfController.dispose();
    super.dispose();
  }
}
