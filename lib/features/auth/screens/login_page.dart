import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../widgets/action_button.dart';
import '../providers/auth_controller.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> login() => ref.read(authControllerProvider.notifier).login(
          'myEmail',
          'myPassword',
        );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login Page'),
            ActionButton(
              onPressed: login,
              icon: Icon(
                Icons.login,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
              label: Text(
                'Login',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
