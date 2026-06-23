import 'package:flutter/material.dart';

/// Light Theme
final lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: const Color(0xFFE8DCC8),
  colorScheme: const ColorScheme.light(
    brightness: Brightness.light,
    primary: Color(0xFFD95A1A),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFFB94712),
    onSecondary: Color(0xFFFFFFFF),
    inverseSurface: Color.fromARGB(255, 107, 107, 107),
    error: Color(0xFFB3261E),
    onError: Color(0xFFFFFFFF),

    surface: Color(0xFFF6EFE4),
    onSurface: Color(0xFF4A3A2A),
  ),
);

/// Dark Theme
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF1F1A16),

  colorScheme: const ColorScheme.dark(
    brightness: Brightness.dark,

    primary: Color(0xFFE06A2C),
    onPrimary: Color(0xFFFFFFFF),

    secondary: Color(0xFFC85A1F),
    onSecondary: Color(0xFFFFFFFF),
    inverseSurface: Color.fromARGB(255, 107, 107, 107),

    error: Color(0xFFFF8A80),
    onError: Color(0xFF000000),

    surface: Color(0xFF2A241F),
    onSurface: Color(0xFFF6EFE4),
  ),
);
