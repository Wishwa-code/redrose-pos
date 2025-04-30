import 'package:flutter/material.dart';

import '/widgets/loading_spinner.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'වයලා.....',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryFixed,
                  ),
            ),
            const SizedBox(height: 16),
            const LoadingSpinner(),
          ],
        ),
      ),
    );
  }
}
