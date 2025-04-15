import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:logging/logging.dart';

import 'router/router.dart';
import 'utils/state_logger.dart';

final log = Logger('ExampleLogger');
int fibonacci(int n) {
  if (n <= 2) {
    if (n < 0) log.shout('Unexpected negative n: $n');
    return 1;
  } else {
    log.info('recursion: n = $n');
    return fibonacci(n - 2) + fibonacci(n - 1);
  }
}

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  print('Fibonacci(4) is: ${fibonacci(4)}');

  Logger.root.level = Level.SEVERE; // skip logs less then severe.
  print('Fibonacci(5) is: ${fibonacci(5)}');

  print('Fibonacci(-42) is: ${fibonacci(-42)}');
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
    return child;
  }
}
