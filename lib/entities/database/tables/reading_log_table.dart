class ReadingLogTable {
  /// The "id" field
  static const String columnID = 'id';

  /// The "date" field — formato "AAAA-MM-DD", uma linha por dia lido
  static const String columnDate = 'date';

  static String createReadingLogTable() {
    return '''
    CREATE TABLE IF NOT EXISTS reading_log (
  $columnID INTEGER PRIMARY KEY AUTOINCREMENT,
  $columnDate TEXT NOT NULL UNIQUE
)
    ''';
  }
}