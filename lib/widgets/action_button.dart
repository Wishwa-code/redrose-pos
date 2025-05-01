import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../hooks/use_side_effect.dart';
import 'loading_spinner.dart';

class ActionButton<T> extends HookWidget {
  const ActionButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
    this.focusNode,
  });
  final Future<T> Function() onPressed;
  final Widget label;
  final Widget icon;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final (clear: _, :mutate, :snapshot) = useSideEffect<void>();
    Future<void> pressButton() async {
      final future = onPressed();
      mutate(future);
      try {
        await future;
      } catch (exception) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' $exception')),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: ElevatedButton.icon(
        focusNode: focusNode,
        onPressed: switch (snapshot) {
          AsyncSnapshot(connectionState: ConnectionState.waiting) => null,
          _ => pressButton,
        },
        icon: switch (snapshot) {
          AsyncSnapshot(connectionState: ConnectionState.waiting) => const LoadingSpinner(),
          _ => icon,
        },
        label: label,
        style: ElevatedButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.onPrimaryFixed, // Text and icon color
          backgroundColor: Theme.of(context).colorScheme.primary, // Button background
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ), // Font style
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Theme.of(context).colorScheme.outline, // Border color
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
