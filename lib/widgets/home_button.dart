import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });
  final Icon icon;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 20,
      child: MaterialButton(
        color: const Color(0xFF2E72D2),
        padding: EdgeInsets.zero,
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
              bottom: 10,
              left: 10,
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}
