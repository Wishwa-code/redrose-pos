import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
    required this.color,
    this.subtitle,
  });
  final Icon icon;
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 20,
      child: MaterialButton(
        color: color ?? Theme.of(context).primaryColor,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: onPressed,
        child: Stack(
          children: [
            Positioned(
              top: 10,
              left: 10,
              child: icon,
            ),
            Positioned(
              bottom: subtitle != null ? 27 : 10, // Shift up if subtitle is present
              left: 10,
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
            if (subtitle != null)
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
