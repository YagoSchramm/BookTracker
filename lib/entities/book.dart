import 'package:book_tracker/entities/database/tables/book_table.dart';

class Book {
  final int id;
  final String title;
  final String filePath;
  final String coverPath;
  final int lastPageRead;
  final int totalPages;
  final String? addedAt;

  Book({
    required this.id,
    required this.title,
    required this.filePath,
    required this.coverPath,
    required this.lastPageRead,
    required this.totalPages,
    this.addedAt,
  });

  factory Book.fromMap(Map<String, dynamic> map) {
    return Book(
      id: map[BookTable.columnID] as int,
      title: map[BookTable.columnTitle] as String,
      filePath: map[BookTable.columnFilePath] as String,
      coverPath: map[BookTable.columnCoverPath] as String,
      lastPageRead: (map[BookTable.columnLastPageRead] as int?) ?? 0,
      totalPages: (map[BookTable.columnTotalPages] as int?) ?? 0,
      addedAt: map[BookTable.columnAddedAt] as String?,
    );
  }
}
