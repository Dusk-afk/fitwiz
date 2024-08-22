import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class EventsHorizList extends StatelessWidget {
  const EventsHorizList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Text(
                "Events",
                style: AppTextStyles.DDD_25_700(),
              ),
            ),
            8.verticalSpacingRadius,
            _buildBody(state),
          ],
        );
      },
    );
  }

  Widget _buildBody(EventsState state) {
    if (state is EventsSuccess) {
      return _buildList(state.events);
    }

    String error = "Unexpected error occurred";
    if (state is EventsError) {
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

  Widget _buildList(List<Event> events) {
    return SizedBox(
      height: 200.sp,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 16.sp),
        scrollDirection: Axis.horizontal,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];
          return Padding(
            padding:
                EdgeInsets.only(right: index == events.length - 1 ? 0 : 16.sp),
            child: _Card(
              onPressed: () {},
              event: event,
            ),
          );
        },
      ),
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
                event.name,
                style: AppTextStyles.FFF_16_700(),
              ),
              8.verticalSpacingRadius,
              Text(
                event.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.FFF_16_400(),
              ),
              const Spacer(),
              Row(
                children: [
                  CustomIcon(
                    CustomIcons.calendar2,
                    size: 14.4.sp,
                    containerSize: 16.sp,
                    color: AppColors.textDarker,
                  ),
                  4.horizontalSpaceRadius,
                  Text(
                    DateFormat('d MMM, yy').format(event.startDateTime),
                    style: AppTextStyles.GGG_12_400(),
                  ),
                  Text(
                    " - ",
                    style:
                        AppTextStyles.GGG_12_400(color: AppColors.textLighter),
                  ),
                  Text(
                    DateFormat('d MMM, yy').format(event.startDateTime),
                    style: AppTextStyles.GGG_12_400(),
                  ),
                ],
              ),
              4.verticalSpacingRadius,
              Row(
                children: [
                  CustomIcon(
                    CustomIcons.rupee,
                    size: 12.sp,
                    containerSize: 16.sp,
                    color: AppColors.textDarker,
                  ),
                  4.horizontalSpaceRadius,
                  Text(
                    event.price == null ? "Free" : "${event.price}",
                    style: AppTextStyles.GGG_12_400(),
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
