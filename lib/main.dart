import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'features/inventory/providers/brand_provider.dart';
import 'features/settings/providers/theme_provider.dart';
import 'router/router.dart';
import 'utils/state_logger.dart';

Logger logger = Logger(
  printer: PrettyPrinter(
      // methodCount: 2, // Number of method calls to be displayed
      // errorMethodCount: 8, // Number of method calls if stacktrace is provided
      // lineLength: 120, // Width of the output
      // colors: true, // Colorful log messages
      // printEmojis: true, // Print an emoji for each log message
      // Should each log print contain a timestamp
      //dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
      ),
);

void main() {
  //Logger.level = Level.warning;

  // logger.t('Trace log');

  // logger.d('Debug log');

  // logger.i('Info log');

  // logger.w('Warning log');

  // logger.e('Error log', error: 'Test Error');

  // logger.f(
  //   'What a fatal log',
  // );

  runApp(
    const ProviderScope(
      observers: [StateLogger()],
      child: _EagerInitialization(
        child: MyAwesomeApp(),
      ),
    ),
  );
}

class MyAwesomeApp extends ConsumerWidget {
  const MyAwesomeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    const textTheme = TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 26,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 24,
        fontWeight: FontWeight.w500,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 18,
      ),
      titleLarge: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 18,
        fontStyle: FontStyle.italic,
      ),
      titleMedium: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'IBM Plex Sans',
        fontSize: 15,
        fontWeight: FontWeight.w800,
      ),
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Redrose POS',
      themeMode: themeMode,
      theme: ThemeData(
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        navigationRailTheme: NavigationRailThemeData(
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
          ),
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          selectedLabelTextStyle: const TextStyle(
            color: Colors.white,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
      darkTheme: ThemeData(
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
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Theme.of(context).colorScheme.primary,
          unselectedItemColor: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        navigationRailTheme: NavigationRailThemeData(
          selectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.primary,
          ),
          unselectedIconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
          selectedLabelTextStyle: const TextStyle(
            color: Colors.white,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: Theme.of(context).colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    // ref.watch(productProvider);
    // ref.watch(menutreeProvider);
    ref.watch(brandNotifierProvider);
    return child;
  }
}
