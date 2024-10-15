import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/presentation/blocs/event_register/event_register_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:fitwiz/utils/components/bottom_actions.dart';
import 'package:fitwiz/utils/components/bottom_gradient.dart';
import 'package:fitwiz/utils/components/custom_back_button.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EventScreen extends StatelessWidget {
  final Event event;

  const EventScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventRegisterBloc, EventRegisterState>(
      listener: _eventRegisterListener,
      child: Scaffold(
        backgroundColor: AppColors.containerBg,
        body: SafeArea(
          bottom: false,
          child: BlocBuilder<MyEventsBloc, MyEventsState>(
            builder: (context, state) {
              if (state is MyEventsSuccess) {
                if (state.isLoading) {
                  return _buildLoading();
                }
                return _buildBody(context, state);
              }
              String error = 'Unknown error occurred';
              if (state is MyEventsError) {
                error = state.message;
              }
              return _buildError(error);
            },
          ),
        ),
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

  Widget _buildBody(BuildContext context, MyEventsSuccess state) {
    bool isRegistered = state.myEvents.any((e) => e.event.id == event.id);

    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: AppColors.containerBgSecondary,
              borderRadius: BorderRadius.circular(24.sp),
            ),
            child: BottomGradientWrapper(
              child: _buildContent(isRegistered),
            ),
          ),
        ),
        BottomActions(
          actions: [
            CustomBackButton(onPressed: Get.back),
            Expanded(
              child: CustomButton(
                onPressed: isRegistered
                    ? null
                    : () {
                        context.read<EventRegisterBloc>().add(
                              RegisterEvent(event.id),
                            );
                      },
                label: isRegistered
                    ? "Already Registered"
                    : (event.price ?? 0) == 0
                        ? "Free"
                        : "₹${event.price}",
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildContent(bool isRegistered) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      children: [
        24.verticalSpacingRadius,
        Center(
          child: Text(
            event.name,
            textAlign: TextAlign.center,
            style: AppTextStyles.DDD_25_600(),
          ),
        ),
        16.verticalSpacingRadius,
        Center(
          child: Text(
            event.description,
            textAlign: TextAlign.center,
            style: AppTextStyles.FFF_16_400(),
          ),
        ),
        16.verticalSpacingRadius,
        Center(
          child: Text(
            "${DateFormat.yMMMd().format(event.startDateTime)} - ${DateFormat.yMMMd().format(event.endDateTime)}",
            style: AppTextStyles.FFF_16_400(),
          ),
        ),
      ],
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
