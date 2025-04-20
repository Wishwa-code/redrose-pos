import 'package:flutter/material.dart';

class NavButtonData {
  NavButtonData({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.color,
    this.subtitle,
  });
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final String? subtitle;
}
