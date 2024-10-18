import 'package:flutter/material.dart';

class CustomAppBarAction {
  final VoidCallback? onPressed;
  final Widget icon;

  const CustomAppBarAction({
    this.onPressed,
    required this.icon,
  });
}
