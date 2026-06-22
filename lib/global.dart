import 'package:book_tracker/services/impl/book_service.dart';

/// Global instance for book service
late final BookService bookService;
/// Initialize the services for the application
void initialize() {
  bookService=BookService();
}