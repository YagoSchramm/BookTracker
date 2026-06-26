import 'package:book_tracker/entities/database/tables/user_table.dart';

class User {
  final int id;
  final String username;
  final int pageGoal;
  final int totalBooksRegistered;
  final int totalBooksRead;
  final int pagesRead;

  User({
    required this.id,
    required this.username,
    required this.pageGoal,
    required this.totalBooksRegistered,
    required this.totalBooksRead,
    required this.pagesRead,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map[UserTable.columnID] as int,
      username: map[UserTable.columnUsername] as String,
      pageGoal: map[UserTable.columnPageGoal] as int,
      totalBooksRegistered: map[UserTable.columnTotalBooksRegistered] as int,
      totalBooksRead: map[UserTable.columnTotalBooksRead] as int,
      pagesRead: map[UserTable.columnPagesRead] as int,
    );
  }

  User copyWith({
    int? id,
    String? username,
    int? pageGoal,
    int? totalBooksRegistered,
    int? totalBooksRead,
    int? pagesRead,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      pageGoal: pageGoal ?? this.pageGoal,
      totalBooksRegistered:
          totalBooksRegistered ?? this.totalBooksRegistered,
      totalBooksRead: totalBooksRead ?? this.totalBooksRead,
      pagesRead: pagesRead ?? this.pagesRead,
    );
  }
}
