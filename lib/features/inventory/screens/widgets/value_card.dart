import 'package:flutter/material.dart';

class ValueCard extends StatelessWidget {
  const ValueCard({
    required this.label,
    required this.value,
    super.key,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(
            label,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                  fontWeight: FontWeight.w800,
                ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            textAlign: TextAlign.left,
            ': $value ',
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryFixed,
                ),
          ),
        ),
      ],
    );
  }
}
