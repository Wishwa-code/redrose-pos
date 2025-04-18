import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logger/logger.dart';

import 'features/inventory/providers/brand_provider.dart';
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

    return MaterialApp.router(
      routerConfig: router,
      title: 'Redrose POS',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
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
