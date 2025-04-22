import 'package:flutter/material.dart';

import './text_theme.dart';

final lightTheme = ThemeData(
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.white,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF88304E),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFFFD9E3),
    onPrimaryContainer: Color(0xFF3A0016),
    onPrimaryFixed: Colors.black,
    secondary: Color(0xFF522546),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFFFD7F1),
    onSecondaryContainer: Color(0xFF250022),
    onSecondaryFixed: Colors.black,
    tertiary: Color(0xFFD92C30),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFFDAD6),
    onTertiaryContainer: Color(0xFF410002),
    error: Color(0xFFB3261E),
    onError: Colors.white,
    errorContainer: Color(0xFFFFDAD4),
    onErrorContainer: Color(0xFF410001),
    surface: Color(0xFFFFFBFF),
    onSurface: Color(0xFF1C1B1F),
    surfaceContainerHighest: Color(0xFFF3DDDD),
    onSurfaceVariant: Color(0xFF524344),
    outline: Color(0xFF857374),
    shadow: Colors.black,
    inverseSurface: Color(0xFF313033),
    onInverseSurface: Color(0xFFF4EFF4),
    inversePrimary: Color(0xFFFFB4A9),
    surfaceTint: Color.fromARGB(255, 78, 145, 114),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFF88304E),
    unselectedItemColor: Color(0xFF3A0016),
  ),
  navigationRailTheme: const NavigationRailThemeData(
    selectedIconTheme: IconThemeData(
      color: Colors.white,
    ),
    unselectedIconTheme: IconThemeData(
      color: Color(0xFF3A0016),
    ),
    selectedLabelTextStyle: TextStyle(
      color: Colors.white,
    ),
    unselectedLabelTextStyle: TextStyle(
      color: Color(0xFF3A0016),
    ),
  ),
);
