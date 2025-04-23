import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/providers/auth_controller.dart';
import 'action_button.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionButton(
      onPressed: ref.read(authControllerProvider.notifier).logout,
      icon: Icon(
        Icons.logout,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      label: Text(
        'Logout',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
