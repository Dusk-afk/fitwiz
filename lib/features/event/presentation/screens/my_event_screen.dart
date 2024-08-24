import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/presentation/widgets/activity_card.dart';
import 'package:fitwiz/utils/components/bottom_gradient.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyEventScreen extends StatelessWidget {
  final MyEvent myEvent;

  const MyEventScreen({
    super.key,
    required this.myEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.containerBgSecondary,
                  borderRadius: BorderRadius.circular(24.sp),
                ),
                child: Stack(
                  children: [
                    _buildContent(),
                    const Positioned.fill(
                      top: null,
                      child: BottomGradient(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 16.sp,
                left: 16.sp,
                right: 16.sp,
                bottom: safeBottomPadding(16.sp),
              ),
              child: Row(
                children: rowGap(
                  16.sp,
                  [
                    // CustomBackButton(onPressed: Get.back),
                    Expanded(
                      child: CustomButton(
                        onPressed: Get.back,
                        label: "Okay",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 24.sp,
      ),
      children: [
        Center(
          child: Text(
            myEvent.event.name,
            style: AppTextStyles.DDD_25_700(),
          ),
        ),
        8.verticalSpacingRadius,
        Center(
          child: Text(
            myEvent.event.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.FFF_16_400(),
          ),
        ),
        16.verticalSpacingRadius,
        Text(
          'Distance',
          style: AppTextStyles.FFF_16_700(),
        ),
        Text(
          "${myEvent.getTotalDistanceKm().toStringAsFixed(2)} Km",
          style: AppTextStyles.FFF_16_400(),
        ),
        8.verticalSpacingRadius,
        Text(
          'Time',
          style: AppTextStyles.FFF_16_700(),
        ),
        Text(
          myEvent.getFormattedTotalDuration(),
          style: AppTextStyles.FFF_16_400(),
        ),
        8.verticalSpacingRadius,
        Text(
          'Average Pace',
          style: AppTextStyles.FFF_16_700(),
        ),
        Text(
          "${myEvent.getFormattedAveragePace()} / Km",
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'Activities:',
          style: AppTextStyles.FFF_16_700(),
        ),
        8.verticalSpacingRadius,
        ...columnGap(
          8.sp,
          myEvent.activities
              .map(
                (activity) => ActivityCard(activity: activity),
              )
              .toList(),
        ),
      ],
    );
  }
}
