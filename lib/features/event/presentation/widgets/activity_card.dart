import 'package:fitwiz/features/event/data/models/activity.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({
    super.key,
    required this.activity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 12.sp,
        horizontal: 16.sp,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: AppColors.containerBg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd MMMM yyyy').format(activity.startDateTime),
            style: AppTextStyles.GGG_12_400(),
          ),
          8.verticalSpacingRadius,
          Row(
            children: [
              CustomIcon(
                CustomIcons.map_location,
                size: 16.sp,
                containerSize: 24.sp,
                color: AppColors.primaryColor,
              ),
              4.horizontalSpaceRadius,
              Expanded(
                child: Text(
                  "${activity.distanceKm.toStringAsFixed(2)} Km",
                  style: AppTextStyles.FFF_16_400(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          8.verticalSpacingRadius,
          Row(
            children: [
              CustomIcon(
                CustomIcons.clock_9,
                size: 16.sp,
                containerSize: 24.sp,
                color: AppColors.primaryColor,
              ),
              4.horizontalSpaceRadius,
              Expanded(
                child: Text(
                  activity.formattedDuration,
                  style: AppTextStyles.FFF_16_400(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          8.verticalSpacingRadius,
          Row(
            children: [
              CustomIcon(
                CustomIcons.pace,
                size: 16.sp,
                containerSize: 24.sp,
                color: AppColors.primaryColor,
              ),
              4.horizontalSpaceRadius,
              Expanded(
                child: Text(
                  "${activity.formattedPace} / Km",
                  style: AppTextStyles.FFF_16_400(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
