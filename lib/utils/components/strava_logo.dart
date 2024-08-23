import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StravaLogo extends StatelessWidget {
  final double? size;

  const StravaLogo({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    double effectiveSize = size ?? 24.sp;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveSize / 2),
        color: AppColors.stravaPrimary,
      ),
      padding: EdgeInsets.all(6.sp),
      child: CustomIcon(
        CustomIcons.strava_white,
        useOriginalColor: true,
      ),
    );
  }
}
