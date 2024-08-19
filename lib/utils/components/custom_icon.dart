// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final String path;
  final double? size;
  final double? containerSize;
  final Color? color;
  final bool useOriginalColor;

  CustomIcon(
    this.path, {
    super.key,
    this.size,
    this.containerSize,
    this.color,
    this.useOriginalColor = false,
  }) : assert(path.endsWith(".svg"), 'Only supports svg files');

  @override
  Widget build(BuildContext context) {
    final color = useOriginalColor
        ? null
        : this.color ?? DefaultTextStyle.of(context).style.color;
    Widget icon = SvgPicture.asset(
      path,
      width: size,
      height: size,
      fit: BoxFit.contain,
      colorFilter:
          color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
    );

    if (containerSize != null) {
      icon = SizedBox.square(
        dimension: containerSize!,
        child: icon,
      );
    }

    return icon;
  }
}

final class CustomIcons {
  static const String search = 'assets/icons/search.svg';
  static const String close = 'assets/icons/close.svg';
  static const String arrow_back = 'assets/icons/arrow_back.svg';
  static const String tick = 'assets/icons/tick.svg';
}
