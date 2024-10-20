import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_scaffold_action.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/goodie.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/data/models/session.dart';
import 'package:fitwiz/features/event/presentation/blocs/event_register/event_register_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:fitwiz/features/event/presentation/screens/my_event_screen.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timelines/timelines.dart';

class EventScreen extends StatelessWidget {
  final Event event;

  const EventScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    MyEventsState myEventsState = context.watch<MyEventsBloc>().state;

    bool isLoading =
        myEventsState is MyEventsSuccess && myEventsState.isLoading;
    bool isSuccessful = myEventsState is MyEventsSuccess && !isLoading;
    bool isError = !isLoading && !isSuccessful;
    String? error;
    if (isError) {
      error = "Unexpected error occurred";
      if (myEventsState is MyEventsError) {
        error = myEventsState.message;
      }
    }

    bool isRegistered = isSuccessful &&
        myEventsState.myEvents.any((e) => e.event.id == event.id);

    return BlocListener<EventRegisterBloc, EventRegisterState>(
      listener: _eventRegisterListener,
      child: CustomScaffold(
        appBarParams: CustomAppBarParams(
          title: event.name,
          previousTitle: 'Home',
        ),
        action: CustomScaffoldAction(
          onPressed: isRegistered
              ? () {
                  _onViewReport(context);
                }
              : () {
                  _onRegister(context);
                },
          label: isRegistered ? "View Report" : "Register",
          shimmered: isLoading,
        ),
        child: isLoading
            ? _buildLoading()
            : isSuccessful
                ? _buildBody()
                : _buildError(error!),
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(error),
    );
  }

  Widget _buildBody() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      children: [
        32.verticalSpace,

        // Descdription
        _buildDescription(),

        // Team
        24.verticalSpace,
        _buildTeam(),

        // Timeline
        if (event.sessions.isNotEmpty) ...[
          24.verticalSpace,
          _buildTimeline(),
        ],

        // Goodies
        if (event.goodies.isNotEmpty) ...[
          24.verticalSpace,
          _buildGoodies(),
        ],

        32.verticalSpace,
      ],
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

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Description"),
        8.verticalSpace,
        Text(
          event.description,
          style: AppTextStyles.FFF_16_400(
            color: AppColors.greyShades[11],
          ),
        ),
      ],
    );
  }

  Widget _buildTeam() {
    Widget buildCard({
      required Widget icon,
      required String label,
      required bool isAvailable,
    }) {
      return Column(
        children: [
          Container(
            width: 64.sp,
            height: 64.sp,
            decoration: BoxDecoration(
              color: isAvailable
                  ? AppColors.greenShades[3]
                  : AppColors.redShades[3],
              borderRadius: BorderRadius.circular(8.sp),
            ),
            child: Center(
              child: DefaultTextStyle(
                style: TextStyle(
                  color: isAvailable
                      ? AppColors.greenShades[9]
                      : AppColors.redShades[9],
                ),
                child: icon,
              ),
            ),
          ),
          4.verticalSpace,
          Text(
            label,
            style: AppTextStyles.FFF_16_400(
              color: isAvailable
                  ? AppColors.greenShades[8]
                  : AppColors.redShades[10],
              strike: !isAvailable,
            ),
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Team"),
        8.verticalSpace,
        Row(
          children: [
            buildCard(
              icon: CustomIcon(
                CustomIcons.team_solo,
                size: 32.sp,
              ),
              label: "Solo",
              isAvailable: true,
            ),
            16.horizontalSpace,
            buildCard(
              icon: CustomIcon(
                CustomIcons.team_couple,
                size: 32.sp,
              ),
              label: "Couple",
              isAvailable: true,
            ),
            16.horizontalSpace,
            buildCard(
              icon: CustomIcon(
                CustomIcons.team_friends,
                size: 32.sp,
              ),
              label: "Friends",
              isAvailable: false,
            ),
          ],
        ),
      ],
    );
  }

  Connector _getDashedConnector() {
    return Connector.dashedLine(
      thickness: 2,
      gap: 4,
      dash: 2,
    );
  }

  Widget _buildTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Timeline"),
        8.verticalSpace,
        FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            connectorTheme: ConnectorThemeData(
              thickness: 2,
              color: AppColors.primaryColor,
            ),
            indicatorTheme: IndicatorThemeData(
              color: AppColors.primaryColor,
            ),
          ),
          builder: TimelineTileBuilder(
            contentsAlign: ContentsAlign.basic,
            indicatorBuilder: (context, index) => Indicator.outlined(
              color: AppColors.primaryColor,
            ),
            itemCount: event.sessions.length,
            startConnectorBuilder: (context, index) =>
                index == 0 ? null : _getDashedConnector(),
            endConnectorBuilder: (context, index) =>
                index == event.sessions.length - 1
                    ? null
                    : _getDashedConnector(),
            indicatorPositionBuilder: (context, index) => 0.16,
            nodePositionBuilder: (context, index) => 0,
            contentsBuilder: (context, index) {
              Session session = event.sessions[index];
              return Container(
                margin: EdgeInsets.only(
                  left: 16.w,
                  bottom: 8.h,
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      session.name,
                      style: AppTextStyles.FFF_18_500(
                        color: AppColors.greyShades[12],
                      ),
                    ),
                    4.verticalSpace,
                    Text(
                      DateFormat('d MMM, yy').format(session.startDateTime),
                      style: AppTextStyles.FFF_14_400(
                        color: AppColors.greyShades[11],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildGoodies() {
    Widget buildCard({
      required Goodie goodie,
    }) {
      return Row(
        children: [
          CustomIcon(
            goodie.getSvgPath(),
            size: 32.sp,
            useOriginalColor: true,
            containerSize: 52.sp,
            containerColor: AppColors.white,
            containerRadius: 4.sp,
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  goodie.name,
                  style: AppTextStyles.FFF_18_500(
                    color: AppColors.greyShades[12],
                  ),
                ),
                4.verticalSpace,
                Text(
                  goodie.description,
                  style: AppTextStyles.FFF_14_400(
                    color: AppColors.greyShades[11],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Goodies"),
        ...event.goodies.map((e) => Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: buildCard(goodie: e),
            )),
      ],
    );
  }

  // TODO: Implement this, currently not implemented on backend
  // ignore: unused_element
  Widget _buildParticipants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitle("Participants"),
      ],
    );
  }

  void _onViewReport(BuildContext context) {
    MyEventsState myEventsState = context.read<MyEventsBloc>().state;
    if (myEventsState is! MyEventsSuccess || myEventsState.isLoading) {
      return;
    }

    MyEvent? myEvent =
        myEventsState.myEvents.firstWhereOrNull((e) => e.event.id == event.id);

    if (myEvent == null) {
      CustomNotifications.notifyError(
        context: context,
        message: "You are not registered for this event",
      );
      return;
    }

    Get.to(() => MyEventScreen(
          myEvent: myEvent,
        ));
  }

  void _onRegister(BuildContext context) {
    context.read<EventRegisterBloc>().add(
          RegisterEvent(event.id),
        );
  }

  void _eventRegisterListener(BuildContext context, EventRegisterState state) {
    if (state is EventRegisterLoading) {
      CustomBottomSheet.showSimpleLoadingSheet(message: "Registering...");
    } else if (state is EventRegisterSuccess) {
      Get.back();
      context.read<MyEventsBloc>().add(FetchMyEvents());
      CustomNotifications.notifySuccess(
        context: context,
        message: "Registered successfully",
      );
    } else if (state is EventRegisterError) {
      Get.back();
      CustomNotifications.notifyError(
        context: context,
        message: state.message,
      );
    }
  }
}
