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
        child: Center(child: icon),
      );
    }

    return icon;
  }
}

final class CustomIcons {
  const CustomIcons._();

  static const String search = 'assets/icons/search.svg';
  static const String close = 'assets/icons/close.svg';
  static const String arrow_back = 'assets/icons/arrow_back.svg';
  static const String tick = 'assets/icons/tick.svg';
  static const String alert = 'assets/icons/alert.svg';
  static const String calendar2 = 'assets/icons/calendar2.svg';
  static const String profile = 'assets/icons/profile.svg';
  static const String profile_filled = 'assets/icons/profile_filled.svg';
  static const String compass = 'assets/icons/compass.svg';
  static const String compass_filled = 'assets/icons/compass_filled.svg';
  static const String rupee = 'assets/icons/rupee.svg';
  static const String map_location = 'assets/icons/map_location.svg';
  static const String clock_9 = 'assets/icons/clock_9.svg';
  static const String pace = 'assets/icons/pace.svg';
  static const String home = 'assets/icons/home.svg';
  static const String home_filled = 'assets/icons/home_filled.svg';
  static const String strava_white = 'assets/icons/strava_white.svg';
  static const String arrow_forward = 'assets/icons/arrow_forward.svg';
  static const String edit = 'assets/icons/edit.svg';
  static const String team = 'assets/icons/team.svg';
  static const String team_create = 'assets/icons/team_create.svg';
}
