import 'package:flutter/material.dart';

import './text_theme.dart';

final darkTheme = ThemeData(
  textTheme: textTheme,
  scaffoldBackgroundColor: Colors.black,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF88304E),
    onPrimary: Colors.white,
    primaryContainer: Color(0xFF5E1131),
    onPrimaryContainer: Color(0xFFFFD9E3),
    onPrimaryFixed: Colors.white,
    secondary: Color(0xFF522546),
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFF3A0034),
    onSecondaryContainer: Color(0xFFFFD7F1),
    tertiary: Color(0xFFD92C30),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFF93000A),
    onTertiaryContainer: Color(0xFFFFDAD6),
    error: Color(0xFFF2B8B5),
    onError: Colors.black,
    errorContainer: Color(0xFF93000A),
    onErrorContainer: Color(0xFFFFDAD4),
    surface: Color(0xFF2C2C2C),
    onSurface: Color(0xFFE6E1E5),
    surfaceContainerHighest: Color(0xFF524344),
    onSurfaceVariant: Color(0xFFD6C2C2),
    outline: Color(0xFF9F8C8D),
    shadow: Colors.black,
    inverseSurface: Color(0xFFFFFBFF),
    onInverseSurface: Color(0xFF1C1B1F),
    inversePrimary: Color(0xFFB71C1C),
    surfaceTint: Color(0xFFD92C30),
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
