import 'package:book_tracker/entities/database/database.dart';
import 'package:book_tracker/entities/database/tables/book_table.dart';

class BookRepository {
  final BookTrackerDatabase _dbHelper = BookTrackerDatabase();

  Future<int> insertBook(String title, String filePath) async {
    final db = await _dbHelper.database;
    return await db.insert('books', {
      BookTable.columnTitle: title,
      BookTable.columnFilePath: filePath,
      BookTable.columnLastPageRead: 0,
      BookTable.columnAddedAt: DateTime.now().toIso8601String(),
    });
  }
}