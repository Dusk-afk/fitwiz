import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/strava_logo.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StravaConnected extends StatelessWidget {
  const StravaConnected({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        StravaLogo(
          size: 32.sp,
        ),
        8.horizontalSpaceRadius,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Strava connected',
                style: AppTextStyles.FFF_16_400(
                  color: AppColors.stravaPrimary,
                ),
              ),
              Text(
                'Your activities are being synced',
                style: AppTextStyles.GGG_12_400(
                  color: AppColors.textDarker,
                ),
              ),
            ],
          ),
        ),
        8.horizontalSpaceRadius,
        CustomIcon(
          CustomIcons.tick,
          color: AppColors.stravaPrimary,
          size: 14.4.sp,
          containerSize: 24.sp,
        ),
      ],
    );
  }
}
