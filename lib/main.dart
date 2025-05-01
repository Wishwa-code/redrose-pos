import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../utils/print_logger.dart';
import 'features/inventory/providers/brand_provider.dart';
import 'features/settings/models/dark_theme.dart';
import 'features/settings/models/light_theme.dart';
import 'features/settings/providers/theme_provider.dart';
import 'router/router.dart';
// import 'utils/state_logger.dart';

void main() {
  // debugRepaintRainbowEnabled = true;
  // debugInvertOversizedImages = true;
  runApp(
    const ProviderScope(
      // observers: [StateLogger()],
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

    return KeyboardListener(
      focusNode: FocusNode()..requestFocus(),
      onKeyEvent: (event) {
        if (event is KeyDownEvent) {
          // Handle key down event
          logger.d('Key down event: ${event.logicalKey}');
          // scaffoldKey.currentState!.closeDrawer(),
        }
      },
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        title: 'Redrose POS',
        themeMode: themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
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
    logger.t('🔥 Eagerly initialized providers $brandNotifierProvider');
    // ref.watch(productProvider);
    // ref.watch(menutreeProvider);
    ref.watch(brandNotifierProvider);
    return child;
  }
}
