import 'dart:math' as math;

import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_event_details/my_event_details_bloc.dart';
import 'package:fitwiz/features/event/presentation/widgets/activity_card.dart';
import 'package:fitwiz/features/event/presentation/widgets/team_card.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyEventScreen extends StatelessWidget {
  final MyEvent myEvent;
  final String? previousTitle;

  const MyEventScreen({
    super.key,
    required this.myEvent,
    this.previousTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyEventDetailsBloc(
        locator<EventsBloc>(),
        locator<EventRepository>(),
      )..add(FetchMyEventDetails(eventId: myEvent.event.id)),
      child: BlocListener<MyEventDetailsBloc, MyEventDetailsState>(
        listener: _myEventDetailsBlocListener,
        child: CustomScaffold(
          appBarParams: CustomAppBarParams(
            title: myEvent.event.name,
            previousTitle: previousTitle ?? 'Home',
          ),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.FFF_16_600(
        color: AppColors.greyShades[12],
      ),
    );
  }

  Widget _buildContent() {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.sp,
        vertical: 24.sp,
      ),
      children: [
        TeamCard(event: myEvent.event),
        _buildTitle('Summary'),
        8.verticalSpace,
        GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.sp,
            mainAxisSpacing: 16.sp,
            childAspectRatio: 169 / 137,
          ),
          children: [
            _buildMetricCard(
              title: 'Days',
              value: math
                  .min(
                    myEvent.getNumberOfDays(),
                    math.max(
                      0,
                      myEvent.getNumberOfDaysPassed(),
                    ),
                  )
                  .toString(),
              unit: 'of ${myEvent.getNumberOfDays()}',
              icon: CustomIcon(
                CustomIcons.calendar3,
                color: AppColors.primaryColor,
                size: 26.sp,
              ),
            ),
            _buildMetricCard(
              title: 'Distance',
              value: myEvent.getTotalDistanceKm().toStringAsFixed(2),
              unit: 'Km',
              icon: CustomIcon(
                CustomIcons.distance_path,
                useOriginalColor: true,
                size: 26.sp,
              ),
            ),
            _buildMetricCard(
              title: 'Time',
              value: '',
              unit: '',
              icon: CustomIcon(
                CustomIcons.stopwatch,
                useOriginalColor: true,
                size: 26.sp,
              ),
              customValueUnit: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myEvent.getTotalDuration().inHours.toString(),
                        style: AppTextStyles.DDD_25_600(
                          color: AppColors.greyShades[12],
                        ),
                      ),
                      Text(
                        'Hr',
                        style: AppTextStyles.FFF_16_400(
                          color: AppColors.greyShades[10],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    ' : ',
                    style: AppTextStyles.DDD_25_600(
                      color: AppColors.greyShades[12],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        myEvent
                            .getTotalDuration()
                            .inMinutes
                            .remainder(60)
                            .toString(),
                        style: AppTextStyles.DDD_25_600(
                          color: AppColors.greyShades[12],
                        ),
                      ),
                      Text(
                        'Min',
                        style: AppTextStyles.FFF_16_400(
                          color: AppColors.greyShades[10],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildMetricCard(
              title: 'Avg. Pace',
              value:
                  (myEvent.getAveragePace().inSeconds / 60).toStringAsFixed(2),
              unit: 'Min/Km',
              icon: CustomIcon(
                CustomIcons.speed,
                useOriginalColor: true,
                size: 22.sp,
              ),
            ),
          ],
        ),
        24.verticalSpace,
        _buildTitle('Activities'),
        8.verticalSpace,
        if (myEvent.activities.isEmpty)
          Text(
            "No activities recorded",
            style: AppTextStyles.FFF_16_400(),
          ),
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

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required Widget icon,
    Widget? customValueUnit,
  }) {
    return Container(
      padding: EdgeInsets.only(
        top: 12.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.FFF_16_400(
                    color: AppColors.greyShades[12],
                  ),
                ),
              ),
              4.horizontalSpace,
              SizedBox.square(
                dimension: 32.sp,
                child: Center(child: icon),
              ),
            ],
          ),
          const Spacer(),
          if (customValueUnit != null)
            customValueUnit
          else ...[
            Text(
              value,
              style: AppTextStyles.DDD_25_600(
                color: AppColors.greyShades[12],
              ),
            ),
            Text(
              unit,
              style: AppTextStyles.FFF_16_400(
                color: AppColors.greyShades[10],
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _myEventDetailsBlocListener(
    BuildContext context,
    MyEventDetailsState state,
  ) {
    if (state.errorMessage != null && !Get.isBottomSheetOpen!) {
      CustomNotifications.notifyError(
        context: context,
        message: state.errorMessage!,
      );
    }
  }
}
