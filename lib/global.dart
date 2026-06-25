import 'package:book_tracker/services/file.dart';
import 'package:book_tracker/services/impl/book_service.dart';
import 'package:book_tracker/services/impl/file_service.dart';

/// Global instance for book service
late final BookService bookService;
/// Global instance for file service
late final FileService fileService;
/// Initialize the services for the application
void initialize() {
  bookService=BookService();
  fileService=newFileService();
}