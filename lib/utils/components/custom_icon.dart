// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomIcon extends StatelessWidget {
  final String path;
  final double? size;
  final double? containerSize;
  final double? containerRadius;
  final Color? containerColor;
  final Color? color;
  final bool useOriginalColor;

  CustomIcon(
    this.path, {
    super.key,
    this.size,
    this.containerSize,
    this.containerRadius,
    this.containerColor,
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
      icon = Container(
        width: containerSize!,
        height: containerSize!,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: containerRadius != null
              ? BorderRadius.circular(containerRadius!)
              : null,
        ),
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
  static const String app_logo = 'assets/icons/app_logo.svg';
  static const String eye = 'assets/icons/eye.svg';
  static const String eye_off = 'assets/icons/eye_off.svg';
  static const String calendar3 = 'assets/icons/calendar3.svg';
  static const String team_solo = 'assets/icons/team_solo.svg';
  static const String team_couple = 'assets/icons/team_couple.svg';
  static const String team_friends = 'assets/icons/team_friends.svg';
  static const String trophy = 'assets/icons/trophy.svg';
  static const String medal = 'assets/icons/medal.svg';
  static const String tshirt = 'assets/icons/tshirt.svg';
  static const String distance_path = 'assets/icons/distance_path.svg';
  static const String stopwatch = 'assets/icons/stopwatch.svg';
  static const String speed = 'assets/icons/speed.svg';
  static const String copy = 'assets/icons/copy.svg';
  static const String crown = 'assets/icons/crown.svg';
  static const String plus = 'assets/icons/plus.svg';
  static const String delete = 'assets/icons/delete.svg';
}
