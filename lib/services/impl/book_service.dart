import 'package:book_tracker/entities/database/database.dart';
import 'package:book_tracker/entities/database/tables/book_table.dart';

class BookService {
  final BookTrackerDatabase _database = BookTrackerDatabase();

  Future<int> insertBook(String title, String filePath, String coverPath) async {
    final db = await _database.database;
    return await db.insert('books', {
      BookTable.columnTitle: title,
      BookTable.columnFilePath: filePath,
      BookTable.columnCoverPath: coverPath,
      BookTable.columnLastPageRead: 0,
      BookTable.columnAddedAt: DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateLastPageRead(int bookId, int newPage) async{
      final db = await _database.database;
      await db.update("books",{
        BookTable.columnLastPageRead:newPage,
      },
      where: "${BookTable.columnID} = ?",
      whereArgs: [bookId]
       );
  }
  
  Future<Map<String, dynamic>?> getBookById(int bookId) async {
  final db = await _database.database;
  final result = await db.query(
    'books',
    where: '${BookTable.columnID} = ?',
    whereArgs: [bookId],
  );
  return result.isNotEmpty ? result.first : null;
}
}