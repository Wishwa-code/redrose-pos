import 'package:example/features/settings/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogoBox extends ConsumerWidget {
  const LogoBox({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeNotifierProvider);

    if (themeMode == ThemeMode.light) {
      return Image.asset(
        'assets/logo/light_logo.png',
        width: 48,
        height: 48,
      );
    } else {
      return Image.asset(
        'assets/logo/dark_logo.png',
        width: 48,
        height: 48,
      );
    }
  }
}
