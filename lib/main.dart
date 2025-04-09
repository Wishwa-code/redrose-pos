import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'features/inventory/providers/products_provider.dart';
import 'router/router.dart';
import 'utils/state_logger.dart';

void main() {
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
      title: 'hooks_riverpod + go_router Demo',
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
    ref.watch(productProvider);
    return child;
  }
}
