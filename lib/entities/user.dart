import 'package:book_tracker/entities/database/tables/user_table.dart';

class User {
  final int id;
  final String username;
  final int pageGoal;
  final int totalBooksRegistered;
  final int totalBooksRead;

  User({
    required this.id,
    required this.username,
    required this.pageGoal,
    required this.totalBooksRegistered,
    required this.totalBooksRead,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map[UserTable.columnID] as int,
      username: map[UserTable.columnUsername] as String,
      pageGoal: map[UserTable.columnPageGoal] as int,
      totalBooksRegistered: map[UserTable.columnTotalBooksRegistered] as int,
      totalBooksRead: map[UserTable.columnTotalBooksRead] as int,
    );
  }
}