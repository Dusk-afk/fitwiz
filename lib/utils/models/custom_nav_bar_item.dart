import 'package:flutter/material.dart';

class CustomNavBarItem {
  final Widget icon;
  final String label;
  final Widget? activeIcon;

  CustomNavBarItem({
    required this.icon,
    required this.label,
    this.activeIcon,
  });
}
