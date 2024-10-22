import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:fitwiz/features/event/presentation/screens/my_event_screen.dart';
import 'package:fitwiz/features/event/presentation/widgets/events_carousel.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyEventsHorizList extends StatelessWidget {
  const MyEventsHorizList({super.key});

  @override
  Widget build(BuildContext context) {
    EventsState eventsState = context.watch<EventsBloc>().state;
    MyEventsState myEventsState = context.watch<MyEventsBloc>().state;

    if (myEventsState is MyEventsSuccess &&
        !myEventsState.isLoading &&
        myEventsState.myEvents.isEmpty) {
      return const SizedBox();
    }

    bool isLoading = false;
    if (eventsState is EventsSuccess && eventsState.isLoading) {
      isLoading = true;
    }
    if (myEventsState is MyEventsSuccess && myEventsState.isLoading) {
      isLoading = true;
    }

    List<MyEvent> myEvents = [];
    if (myEventsState is MyEventsSuccess) {
      myEvents = myEventsState.myEvents;
    }

    String? error =
        myEventsState is MyEventsSuccess ? null : "Unexpected error occurred";
    if (myEventsState is MyEventsError) {
      error = myEventsState.message;
    }

    return EventsCarousel(
      title: "Participating Events",
      height: 180.sp,
      itemCount: myEvents.length,
      itemBuilder: (context, index) {
        MyEvent myEvent = myEvents[index];
        return Padding(
          padding: EdgeInsets.only(right: 16.sp),
          child: _Card(
            key: ValueKey(myEvent.event.id),
            onPressed: () {
              Get.to(() => MyEventScreen(
                    myEvent: myEvent,
                  ));
            },
            myEvent: myEvent,
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
  }
}

class _Card extends StatelessWidget {
  final VoidCallback onPressed;
  final MyEvent myEvent;

  const _Card({
    super.key,
    required this.onPressed,
    required this.myEvent,
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        myEvent.event.name,
                        style: AppTextStyles.FFF_18_400(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    8.horizontalSpace,
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(4.sp),
                      ),
                      child: Text(
                        "View Report",
                        style: AppTextStyles.FFF_14_400(
                          color: AppColors.primaryColor,
                        ),
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
