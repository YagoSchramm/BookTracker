import 'package:book_tracker/services/file.dart';
import 'package:book_tracker/services/impl/book_service.dart';
import 'package:book_tracker/services/impl/file_service.dart';
import 'package:book_tracker/services/impl/pdf_service.dart';
import 'package:book_tracker/services/pdf.dart';

/// Global instance for book service
late final BookService bookService;
/// Global instance for file service
late final FileService fileService;
/// Global instance for pdf service
late final PdfService pdfService;
/// Initialize the services for the application
void initialize() {
  bookService=BookService();
  fileService=newFileService();
  pdfService=newPdfService();
}