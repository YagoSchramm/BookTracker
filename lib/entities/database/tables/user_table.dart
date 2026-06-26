class UserTable {
  /// The "id" field
  static const String columnID = 'id';

  /// The "username" field
  static const String columnUsername = 'username';

  /// The "page_goal" field — total page goal
  static const String columnPageGoal = 'page_goal';

  /// The "total_books_registered" field — cache
  static const String columnTotalBooksRegistered = 'total_books_registered';

  /// The "total_books_read" field — cache
  static const String columnTotalBooksRead = 'total_books_read';

  /// The "pages_read" field — sum of all pages read across books
  static const String columnPagesRead = 'pages_read';

  static String createUserTable() {
    return '''
    CREATE TABLE IF NOT EXISTS user (
  $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnUsername TEXT NOT NULL,
  $columnPageGoal INTEGER NOT NULL DEFAULT 0,
  $columnTotalBooksRegistered INTEGER NOT NULL DEFAULT 0,
  $columnTotalBooksRead INTEGER NOT NULL DEFAULT 0,
  $columnPagesRead INTEGER NOT NULL DEFAULT 0
)
    ''';
  }
}