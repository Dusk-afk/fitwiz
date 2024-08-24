import 'package:dotted_border/dotted_border.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/strava_logo.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissingStravaConnection extends StatelessWidget {
  const MissingStravaConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(16.sp),
          color: AppColors.stravaPrimary,
          strokeWidth: 1.sp,
          dashPattern: [8.sp, 8.sp],
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 12.sp,
              horizontal: 16.sp,
            ).copyWith(right: 8.sp),
            decoration: BoxDecoration(
              color: AppColors.stravaPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Row(
              children: [
                StravaLogo(
                  size: 32.sp,
                ),
                8.horizontalSpaceRadius,
                Expanded(
                  child: Text(
                    'Connect with Strava to sync your activities',
                    style: AppTextStyles.FFF_16_400(
                      color: AppColors.stravaPrimary,
                    ),
                  ),
                ),
                8.horizontalSpaceRadius,
                CustomIcon(
                  CustomIcons.arrow_forward,
                  color: AppColors.textDarker,
                  size: 14.4.sp,
                  containerSize: 24.sp,
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.sp),
              overlayColor: WidgetStateProperty.all(
                AppColors.stravaPrimary.withOpacity(0.075),
              ),
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }
}
