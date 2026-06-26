import 'package:book_tracker/entities/database/database.dart';
import 'package:book_tracker/entities/database/tables/reading_log_table.dart';
import 'package:book_tracker/entities/database/tables/user_table.dart';
import 'package:book_tracker/entities/user.dart';
import 'package:book_tracker/services/user.dart';
import 'package:sqflite/sqflite.dart';

UserService newUserService() => _UserService();

class _UserService implements UserService {
  final BookTrackerDatabase _database = BookTrackerDatabase();

  @override
  Future<bool> hasCompletedOnboarding() async {
    final db = await _database.database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM user');
    final count = result.first['count'] as int;
    return count > 0;
  }

  @override
  Future<int> createUser(String username, int pageGoal) async {
    final db = await _database.database;
    return await db.insert('user', {
      UserTable.columnUsername: username,
      UserTable.columnPageGoal: pageGoal,
      UserTable.columnTotalBooksRegistered: 0,
      UserTable.columnTotalBooksRead: 0,
      UserTable.columnPagesRead: 0,
    });
  }

  @override
  Future<User?> getUser() async {
    final db = await _database.database;
    final result = await db.query('user', limit: 1);
    if (result.isEmpty) return null;
    return User.fromMap(result.first);
  }

  @override
  Future<void> updateUsername(String username) async {
    final db = await _database.database;
    await db.update(
      'user',
      {UserTable.columnUsername: username},
      where: '${UserTable.columnID} = ?',
      whereArgs: [1],
    );
  }

  @override
  Future<void> updatePageGoal(int pageGoal) async {
    final db = await _database.database;
    await db.update(
      'user',
      {UserTable.columnPageGoal: pageGoal},
      where: '${UserTable.columnID} = ?',
      whereArgs: [1],
    );
  }

  @override
  Future<void> updatePagesRead(int pagesRead) async {
    final db = await _database.database;
    await db.update(
      'user',
      {UserTable.columnPagesRead: pagesRead},
      where: '${UserTable.columnID} = ?',
      whereArgs: [1],
    );
  }

  @override
  Future<void> incrementTotalBooksRegistered() async {
    final db = await _database.database;
    await db.rawUpdate(
      'UPDATE user SET ${UserTable.columnTotalBooksRegistered} = '
      '${UserTable.columnTotalBooksRegistered} + 1 WHERE ${UserTable.columnID} = ?',
      [1],
    );
  }

  @override
  Future<void> decrementTotalBooksRegistered() async {
    final db = await _database.database;
    await db.rawUpdate(
      'UPDATE user SET ${UserTable.columnTotalBooksRegistered} = '
      '${UserTable.columnTotalBooksRegistered} - 1 WHERE ${UserTable.columnID} = ?',
      [1],
    );
  }

  @override
  Future<void> incrementTotalBooksRead() async {
    final db = await _database.database;
    await db.rawUpdate(
      'UPDATE user SET ${UserTable.columnTotalBooksRead} = '
      '${UserTable.columnTotalBooksRead} + 1 WHERE ${UserTable.columnID} = ?',
      [1],
    );
  }

  String _todayKey() {
    return DateTime.now().toIso8601String().substring(0, 10);
  }

  @override
  Future<void> registerReadingToday() async {
    final db = await _database.database;
    await db.insert('reading_log', {
      ReadingLogTable.columnDate: _todayKey(),
    }, conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  @override
  Future<List<String>> getReadingDates({int days = 4}) async {
    final db = await _database.database;
    final cutoff = DateTime.now()
        .subtract(Duration(days: days - 1))
        .toIso8601String()
        .substring(0, 10);

    final result = await db.query(
      'reading_log',
      where: '${ReadingLogTable.columnDate} >= ?',
      whereArgs: [cutoff],
      orderBy: '${ReadingLogTable.columnDate} ASC',
    );

    return result
        .map((row) => row[ReadingLogTable.columnDate] as String)
        .toList();
  }
}
