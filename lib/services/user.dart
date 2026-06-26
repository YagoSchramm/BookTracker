import 'package:book_tracker/entities/user.dart';

abstract class UserService {
  Future<bool> hasCompletedOnboarding();
  Future<int> createUser(String username, int pageGoal);
  Future<User?> getUser();
  Future<void> updateUsername(String username);
  Future<void> updatePageGoal(int pageGoal);
  Future<void> incrementTotalBooksRegistered();
  Future<void> incrementTotalBooksRead();
  Future<void> decrementTotalBooksRegistered();
  Future<void> registerReadingToday();
  Future<List<String>> getReadingDates({int days = 4});
}