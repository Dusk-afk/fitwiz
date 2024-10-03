import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

/// Adds a gap between each child in a row.
List<Widget> rowGap(double gap, Iterable<Widget> children) {
  List<Widget> widgets = [];
  for (var i = 0; i < children.length; i++) {
    widgets.add(children.elementAt(i));
    if (i != children.length - 1) {
      widgets.add(SizedBox(width: gap));
    }
  }
  return widgets;
}

/// Adds a gap between each child in a column.
List<Widget> columnGap(double gap, Iterable<Widget> children) {
  List<Widget> widgets = [];
  for (var i = 0; i < children.length; i++) {
    widgets.add(children.elementAt(i));
    if (i != children.length - 1) {
      widgets.add(SizedBox(height: gap));
    }
  }
  return widgets;
}

/// Gives a value for the bottom padding that is at least the given padding.
///
/// It respects the safe area padding.
double safeBottomPadding(double padding, [BuildContext? context]) {
  final mediaQuery = context != null ? MediaQuery.of(context) : Get.mediaQuery;
  if (GetPlatform.isIOS) {
    return math.max(mediaQuery.padding.bottom, padding);
  } else {
    return mediaQuery.padding.bottom + padding;
  }
}

/// Gives a value for the top padding that is at least the given padding.
double safeTopPadding(double padding, [BuildContext? context]) {
  final mediaQuery = context != null ? MediaQuery.of(context) : Get.mediaQuery;
  if (GetPlatform.isIOS) {
    return math.max(mediaQuery.padding.top, padding);
  } else {
    return mediaQuery.padding.top + padding;
  }
}

/// Gives a value for the left padding that is at least the given padding.
double safeLeftPadding(double padding, [BuildContext? context]) {
  final mediaQuery = context != null ? MediaQuery.of(context) : Get.mediaQuery;
  if (GetPlatform.isIOS) {
    return math.max(mediaQuery.padding.left, padding);
  } else {
    return mediaQuery.padding.left + padding;
  }
}

/// Gives a value for the right padding that is at least the given padding.
double safeRightPadding(double padding, [BuildContext? context]) {
  final mediaQuery = context != null ? MediaQuery.of(context) : Get.mediaQuery;
  if (GetPlatform.isIOS) {
    return math.max(mediaQuery.padding.right, padding);
  } else {
    return mediaQuery.padding.right + padding;
  }
}

/// An extension over String to capitalize or to convert them to title case
extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension MediaQueryPaddingRemover on MediaQueryData {
  /// Removes padding from the current MediaQueryData
  MediaQueryData removePaddingValued({
    double removeLeft = 0.0,
    double removeTop = 0.0,
    double removeRight = 0.0,
    double removeBottom = 0.0,
  }) {
    EdgeInsets newPadding = padding.copyWith(
      left: math.max(0.0, padding.left - removeLeft),
      top: math.max(0.0, padding.top - removeTop),
      right: math.max(0.0, padding.right - removeRight),
      bottom: math.max(0.0, padding.bottom - removeBottom),
    );
    EdgeInsets diff = padding - newPadding;
    return copyWith(
      padding: newPadding,
      viewPadding: viewPadding.copyWith(
        left: math.max(0.0, viewPadding.left - diff.left),
        top: math.max(0.0, viewPadding.top - diff.top),
        right: math.max(0.0, viewPadding.right - diff.right),
        bottom: math.max(0.0, viewPadding.bottom - diff.bottom),
      ),
    );
  }
}
