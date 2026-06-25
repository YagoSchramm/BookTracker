class BookTable {
  /// The "id" field
  static const String columnID = 'id';

  /// The "title" field
  static const String columnTitle = 'title';

  /// The "file_path" field
  static const String columnFilePath = 'file_path';

  /// The "cover_path" field
  static const String columnCoverPath = 'cover_path';

  /// The "last_page_read" field
  static const String columnLastPageRead = 'last_page_read';

  /// The "total_pages" field
  static const String columnTotalPages = 'total_pages';

  /// The "added_at" field
  static const String columnAddedAt = 'added_at';

  static String createBookTable() {
    return '''
    CREATE TABLE books (
  $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnTitle TEXT NOT NULL,
  $columnFilePath TEXT NOT NULL,
  $columnCoverPath TEXT NOT NULL,
  $columnLastPageRead INTEGER DEFAULT 0,
  $columnTotalPages INTEGER,
  $columnAddedAt TEXT
)
    ''';
  }
}
