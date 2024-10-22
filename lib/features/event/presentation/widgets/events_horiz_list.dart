import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/presentation/screens/event_screen.dart';
import 'package:fitwiz/features/event/presentation/widgets/events_carousel.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventsHorizList extends StatelessWidget {
  const EventsHorizList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        bool isLoading = state is EventsSuccess && state.isLoading;

        List<Event> events = [];
        if (state is EventsSuccess) {
          events = state.events;
        }

        String? error =
            state is EventsSuccess ? null : "Unexpected error occurred";
        if (state is EventsError) {
          error = state.message;
        }

        return EventsCarousel(
          title: "Upcoming Events",
          height: 230.sp,
          itemCount: events.length,
          itemBuilder: (context, index) {
            Event event = events[index];
            return Padding(
              padding: EdgeInsets.only(right: 16.sp),
              child: _Card(
                key: ValueKey(event.id),
                onPressed: () {
                  Get.to(
                    () => EventScreen(
                      event: event,
                    ),
                  );
                },
                event: event,
              ),
            );
          },
          error: error,
          errorBuider: (context) {
            return Text(
              error ?? "",
              style: AppTextStyles.FFF_16_400(
                color: AppColors.error,
              ),
            );
          },
          isLoading: isLoading,
        );
      },
    );
  }
}

class _Card extends StatelessWidget {
  final VoidCallback onPressed;
  final Event event;

  const _Card({
    super.key,
    required this.onPressed,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.sp),
      child: Stack(
        children: [
          Image.asset(
            "assets/images/running_bg.jpg",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryShades[9].withOpacity(0),
                    AppColors.primaryShades[9].withOpacity(0.6),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  event.name,
                  style: AppTextStyles.EEE_20_600(
                    color: AppColors.white,
                  ),
                ),
                8.verticalSpace,
                Row(
                  children: [
                    CustomIcon(
                      CustomIcons.calendar3,
                      size: 12.sp,
                      containerSize: 24.sp,
                      color: AppColors.white,
                    ),
                    4.horizontalSpace,
                    Text(
                      DateFormat('d MMM, yy').format(event.startDateTime),
                      style: AppTextStyles.FFF_14_400(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      " - ",
                      style: AppTextStyles.FFF_14_400(
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      DateFormat('d MMM, yy').format(event.startDateTime),
                      style: AppTextStyles.FFF_14_400(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                4.verticalSpace,
                Row(
                  children: [
                    CustomIcon(
                      CustomIcons.rupee,
                      size: 12.sp,
                      containerSize: 24.sp,
                      color: AppColors.white,
                    ),
                    4.horizontalSpace,
                    Text(
                      event.price == null ? "Free" : "${event.price}",
                      style: AppTextStyles.FFF_14_400(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                overlayColor:
                    WidgetStateProperty.all(AppColors.white.withOpacity(0.1)),
                onTap: onPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
