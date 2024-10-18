import 'package:fitwiz/features/custom_scaffold/data/models/custom_nav_bar_item.dart';
import 'package:flutter/material.dart';

class CustomNavBarParams {
  final int selectedIndex;
  final List<CustomNavBarItem> items;
  final ValueChanged<int>? onIndexChanged;

  const CustomNavBarParams({
    required this.selectedIndex,
    required this.items,
    this.onIndexChanged,
  }) : assert(items.length >= 1);
}
