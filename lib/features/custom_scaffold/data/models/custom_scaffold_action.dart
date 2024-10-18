import 'package:flutter/material.dart';

class CustomScaffoldAction {
  final VoidCallback? onPressed;
  final String? label;
  final Widget? rightIcon;
  final Widget? leftIcon;

  const CustomScaffoldAction({
    this.onPressed,
    this.label,
    this.rightIcon,
    this.leftIcon,
  });
}
