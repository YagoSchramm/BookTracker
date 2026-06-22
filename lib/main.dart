import 'package:book_tracker/global.dart';
import 'package:book_tracker/presentation/app_theme.dart';
import 'package:book_tracker/presentation/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  initialize();
  runApp(BookTrackerApp());
}

class BookTrackerApp extends StatelessWidget {
  const BookTrackerApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTracker',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: .system,
      home: HomeScreen(),
    );
  }
}
