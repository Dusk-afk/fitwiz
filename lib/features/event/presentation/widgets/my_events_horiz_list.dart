import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:fitwiz/features/event/presentation/screens/my_event_screen.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.sp),
          child: Text(
            "Participating Events",
            style: AppTextStyles.DDD_25_600(),
          ),
        ),
        8.verticalSpacingRadius,
        isLoading ? _buildLoading() : _buildBody(myEventsState),
      ],
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      height: 200.sp,
      child: ListView(
        padding: EdgeInsets.only(left: 16.sp),
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          for (int i = 0; i < 5; i++)
            Container(
              margin: EdgeInsets.only(right: 16.sp),
              width: 300.sp,
              height: 200.sp,
              alignment: Alignment.center,
              padding: EdgeInsets.all(16.sp),
              decoration: BoxDecoration(
                color: AppColors.containerBg,
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Shimmer.fromColors(
                baseColor: AppColors.shimmerBase,
                highlightColor: AppColors.shimmerHighlight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200.sp,
                      height: 16.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    8.verticalSpacingRadius,
                    Container(
                      width: 300.sp,
                      height: 16.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    8.verticalSpacingRadius,
                    Container(
                      width: 200.sp,
                      height: 16.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 100.sp,
                      height: 16.sp,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(MyEventsState state) {
    if (state is MyEventsSuccess) {
      return _buildList(state.myEvents);
    }

    String error = "Unexpected error occurred";
    if (state is MyEventsError) {
      error = state.message;
    }
    return _buildError(error);
  }

  Widget _buildError(String error) {
    return Text(
      error,
      style: AppTextStyles.FFF_16_400(
        color: AppColors.error,
      ),
    );
  }

  Widget _buildList(List<MyEvent> myEvents) {
    return SizedBox(
      height: 200.sp,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        scrollDirection: Axis.horizontal,
        itemCount: myEvents.length,
        itemBuilder: (context, index) {
          final myEvent = myEvents[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index == myEvents.length - 1 ? 0 : 16.sp,
            ),
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
      ),
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
    return Stack(
      children: [
        Container(
          width: 300.sp,
          padding: EdgeInsets.symmetric(
            vertical: 16.sp,
            horizontal: 16.sp,
          ),
          decoration: BoxDecoration(
            color: AppColors.containerBg,
            borderRadius: BorderRadius.circular(16.sp),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                myEvent.event.name,
                style: AppTextStyles.FFF_16_600(),
              ),
              8.verticalSpacingRadius,
              Text(
                myEvent.event.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.FFF_16_400(),
              ),
              const Spacer(),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16.sp),
              overlayColor: WidgetStateProperty.all(
                  AppColors.primaryColor.withOpacity(0.05)),
              onTap: onPressed,
            ),
          ),
        ),
      ],
    );
  }
}
