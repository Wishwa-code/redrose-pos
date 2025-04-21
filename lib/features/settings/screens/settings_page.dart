import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final themeMode = ref.watch(themeNotifierProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);

    return Scaffold(
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: Icon(
                themeMode == ThemeMode.light ? Icons.dark_mode : Icons.light_mode,
                color: const Color(0xFF7A7A7A),
              ),
              title: const Text('Toggle Theme'),
              onTap: themeNotifier.toggleTheme,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: ColorSchemeView(colorScheme: colorScheme),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorSchemeView extends StatelessWidget {
  const ColorSchemeView({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ColorGroup(
          title: 'Primary Colors',
          children: [
            ColorChip('primary', colorScheme.primary, colorScheme.onPrimary),
            ColorChip('onPrimary', colorScheme.onPrimary, colorScheme.primary),
            ColorChip(
              'primaryContainer',
              colorScheme.primaryContainer,
              colorScheme.onPrimaryContainer,
            ),
            ColorChip(
              'onPrimaryContainer',
              colorScheme.onPrimaryContainer,
              colorScheme.primaryContainer,
            ),
            ColorChip('primaryFixed', colorScheme.primaryFixed, colorScheme.onPrimaryFixed),
            ColorChip('onPrimaryFixed', colorScheme.onPrimaryFixed, colorScheme.primaryFixed),
            ColorChip(
              'primaryFixedDim',
              colorScheme.primaryFixedDim,
              colorScheme.onPrimaryFixedVariant,
            ),
            ColorChip(
              'onPrimaryFixedVariant',
              colorScheme.onPrimaryFixedVariant,
              colorScheme.primaryFixedDim,
            ),
          ],
        ),
        ColorGroup(
          title: 'Secondary Colors',
          children: [
            ColorChip('secondary', colorScheme.secondary, colorScheme.onSecondary),
            ColorChip('onSecondary', colorScheme.onSecondary, colorScheme.secondary),
            ColorChip(
              'secondaryContainer',
              colorScheme.secondaryContainer,
              colorScheme.onSecondaryContainer,
            ),
            ColorChip(
              'onSecondaryContainer',
              colorScheme.onSecondaryContainer,
              colorScheme.secondaryContainer,
            ),
            ColorChip('secondaryFixed', colorScheme.secondaryFixed, colorScheme.onSecondaryFixed),
            ColorChip('onSecondaryFixed', colorScheme.onSecondaryFixed, colorScheme.secondaryFixed),
            ColorChip(
              'secondaryFixedDim',
              colorScheme.secondaryFixedDim,
              colorScheme.onSecondaryFixedVariant,
            ),
            ColorChip(
              'onSecondaryFixedVariant',
              colorScheme.onSecondaryFixedVariant,
              colorScheme.secondaryFixedDim,
            ),
          ],
        ),
        ColorGroup(
          title: 'Tertiary Colors',
          children: [
            ColorChip('tertiary', colorScheme.tertiary, colorScheme.onTertiary),
            ColorChip('onTertiary', colorScheme.onTertiary, colorScheme.tertiary),
            ColorChip(
              'tertiaryContainer',
              colorScheme.tertiaryContainer,
              colorScheme.onTertiaryContainer,
            ),
            ColorChip(
              'onTertiaryContainer',
              colorScheme.onTertiaryContainer,
              colorScheme.tertiaryContainer,
            ),
            ColorChip('tertiaryFixed', colorScheme.tertiaryFixed, colorScheme.onTertiaryFixed),
            ColorChip('onTertiaryFixed', colorScheme.onTertiaryFixed, colorScheme.tertiaryFixed),
            ColorChip(
              'tertiaryFixedDim',
              colorScheme.tertiaryFixedDim,
              colorScheme.onTertiaryFixedVariant,
            ),
            ColorChip(
              'onTertiaryFixedVariant',
              colorScheme.onTertiaryFixedVariant,
              colorScheme.tertiaryFixedDim,
            ),
          ],
        ),
        ColorGroup(
          title: 'Error Colors',
          children: [
            ColorChip('error', colorScheme.error, colorScheme.onError),
            ColorChip('onError', colorScheme.onError, colorScheme.error),
            ColorChip('errorContainer', colorScheme.errorContainer, colorScheme.onErrorContainer),
            ColorChip('onErrorContainer', colorScheme.onErrorContainer, colorScheme.errorContainer),
          ],
        ),
        ColorGroup(
          title: 'Surface Colors',
          children: [
            ColorChip('surfaceDim', colorScheme.surfaceDim, colorScheme.onSurface),
            ColorChip('surface', colorScheme.surface, colorScheme.onSurface),
            ColorChip('surfaceBright', colorScheme.surfaceBright, colorScheme.onSurface),
            ColorChip(
              'surfaceContainerLowest',
              colorScheme.surfaceContainerLowest,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainerLow',
              colorScheme.surfaceContainerLow,
              colorScheme.onSurface,
            ),
            ColorChip('surfaceContainer', colorScheme.surfaceContainer, colorScheme.onSurface),
            ColorChip(
              'surfaceContainerHigh',
              colorScheme.surfaceContainerHigh,
              colorScheme.onSurface,
            ),
            ColorChip(
              'surfaceContainerHighest',
              colorScheme.surfaceContainerHighest,
              colorScheme.onSurface,
            ),
            ColorChip('onSurface', colorScheme.onSurface, colorScheme.surface),
            ColorChip(
              'onSurfaceVariant',
              colorScheme.onSurfaceVariant,
              colorScheme.surfaceContainerHighest,
            ),
          ],
        ),
        ColorGroup(
          title: 'Miscellaneous',
          children: [
            ColorChip('outline', colorScheme.outline, null),
            ColorChip('shadow', colorScheme.shadow, null),
            ColorChip('inverseSurface', colorScheme.inverseSurface, colorScheme.onInverseSurface),
            ColorChip('onInverseSurface', colorScheme.onInverseSurface, colorScheme.inverseSurface),
            ColorChip('inversePrimary', colorScheme.inversePrimary, colorScheme.primary),
          ],
        ),
      ],
    );
  }
}

class ColorGroup extends StatelessWidget {
  const ColorGroup({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            ),
            child: Text(title, style: Theme.of(context).textTheme.titleMedium),
          ),
          ...children,
        ],
      ),
    );
  }
}

class ColorChip extends StatelessWidget {
  const ColorChip(this.label, this.color, this.onColor, {super.key});

  final Color color;
  final Color? onColor;
  final String label;

  static Color contrastColor(Color color) {
    final brightness = ThemeData.estimateBrightnessForColor(color);
    return brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  @override
  Widget build(BuildContext context) {
    final labelColor = onColor ?? contrastColor(color);
    return ColoredBox(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Text(label, style: TextStyle(color: labelColor, fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(
              '#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
              style: TextStyle(color: labelColor.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }
}
