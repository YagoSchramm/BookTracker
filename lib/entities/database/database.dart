import 'package:book_tracker/entities/database/tables/book_table.dart';
import 'package:book_tracker/entities/database/tables/reading_log_table.dart';
import 'package:book_tracker/entities/database/tables/user_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// The current version of the database schema.
///
/// Increment this value whenever a migration is required
/// (e.g. adding or removing tables/columns).
const _databaseVersion = 1;

/// Responsible for initializing and managing the application's database.
///
/// Implements the Singleton pattern to ensure that only one instance
/// of the database is created during the application's lifecycle.
class BookTrackerDatabase {
  /// Private internal constructor used by the Singleton pattern.
  BookTrackerDatabase._internal();

  /// The single static instance of this class.
  static final BookTrackerDatabase _instance = BookTrackerDatabase._internal();

  /// Factory constructor that always returns the same [_instance].
  factory BookTrackerDatabase() => _instance;

  /// The SQLite database instance. Will be `null` until first initialization.
  static Database? _database;

  /// Returns the database instance, initializing it if necessary.
  ///
  /// If the database has not been created yet, calls [_initDatabase].
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the database by creating the file at the device's default path.
  ///
  /// The file is saved as `boot_tracker.db` in the operating system's
  /// default databases directory.
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'boot_tracker.db');

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
      onOpen: _onOpen,
    );
  }

  /// Callback executed when the database is opened.
  ///
  /// Used to ensure all required tables and columns exist even if the
  /// database file was created before new columns were added.
  Future<void> _onOpen(Database db) async {
    await db.execute(BookTable.createBookTable());
    await db.execute(ReadingLogTable.createReadingLogTable());
    await db.execute(UserTable.createUserTable());

    final tableInfo = await db.rawQuery('PRAGMA table_info(user)');
    final existingColumns = tableInfo
        .map((row) => row['name'] as String)
        .toSet();

    if (!existingColumns.contains(UserTable.columnPagesRead)) {
      await db.execute(
        'ALTER TABLE user ADD COLUMN ${UserTable.columnPagesRead} INTEGER NOT NULL DEFAULT 0',
      );
    }
  }

  /// Callback executed when the database is created for the first time.
  ///
  /// Responsible for creating all tables required by the application.
  /// Automatically called by SQLite only on the first database open.
  ///
  /// - [db]: the newly created database instance.
  /// - [version]: the database version defined in [_initDatabase].
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(BookTable.createBookTable());
    await db.execute(ReadingLogTable.createReadingLogTable());
    await db.execute(UserTable.createUserTable());
  }
}