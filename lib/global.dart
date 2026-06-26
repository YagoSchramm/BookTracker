import 'package:book_tracker/services/file.dart';
import 'package:book_tracker/services/impl/book_service.dart';
import 'package:book_tracker/services/impl/file_service.dart';
import 'package:book_tracker/services/impl/pdf_service.dart';
import 'package:book_tracker/services/impl/user_service.dart';
import 'package:book_tracker/services/pdf.dart';
import 'package:book_tracker/services/user.dart';

/// Global instance for book service
late final BookService bookService;
/// Global instance for file service
late final FileService fileService;
/// Global instance for pdf service
late final PdfService pdfService;
/// Global instance for user service
late final UserService userService;
/// Initialize the services for the application
void initialize() {
  bookService=BookService();
  fileService=newFileService();
  pdfService=newPdfService();
  userService=newUserService();
}