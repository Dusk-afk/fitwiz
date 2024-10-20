import 'package:flutter/material.dart';

class CustomScaffoldAction {
  final VoidCallback? onPressed;
  final String? label;
  final Widget? rightIcon;
  final Widget? leftIcon;
  final bool shimmered;

  const CustomScaffoldAction({
    this.onPressed,
    this.label,
    this.rightIcon,
    this.leftIcon,
    this.shimmered = false,
  });
}
