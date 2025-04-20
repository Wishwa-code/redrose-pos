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
              bottom: subtitle != null ? 30 : 10, // Shift up if subtitle is present
              left: 10,
              child: Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            if (subtitle != null)
              Positioned(
                bottom: 10,
                left: 10,
                child: Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
