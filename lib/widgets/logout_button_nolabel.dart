import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/auth_controller.dart';
import 'action_button_nolabel.dart';

class NormalLogoutButton extends ConsumerWidget {
  const NormalLogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionButton(
      onPressed: ref.read(authControllerProvider.notifier).logout,
      icon: const Icon(Icons.logout),
    );
  }
}
