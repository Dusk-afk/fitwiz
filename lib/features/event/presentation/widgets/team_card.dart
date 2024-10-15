import 'package:dotted_border/dotted_border.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_event_details/my_event_details_bloc.dart';
import 'package:fitwiz/features/event/presentation/widgets/team_create_join_sheet.dart';
import 'package:fitwiz/features/event/presentation/widgets/team_join_sheet.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamCard extends StatelessWidget {
  final Event event;
  const TeamCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEventDetailsBloc, MyEventDetailsState>(
      builder: (context, state) {
        if (!state.isLoading && !state.isUpdating) {
          if (state.eventTeam != null) {
            return _TeamCard(
              key: ValueKey(state.eventTeam),
              eventTeam: state.eventTeam!,
            );
          } else if (event.isTeamEvent) {
            return _CreateTeamCard(event: event);
          }
        } else if (state.isUpdating) {
          return _CreateTeamCard(
            event: event,
            showLoading: true,
            loadingText: state.updatingMessage ?? '',
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _TeamCard extends StatelessWidget {
  final EventTeam eventTeam;
  const _TeamCard({super.key, required this.eventTeam});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.sp),
      padding: EdgeInsets.symmetric(
        vertical: 8.sp,
        horizontal: 16.sp,
      ),
      decoration: BoxDecoration(
        color: AppColors.containerBg,
        borderRadius: BorderRadius.circular(16.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Team Code  ",
                style: AppTextStyles.FFF_16_400(),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 4.sp,
                  horizontal: 8.sp,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Text(
                  eventTeam.teamCode,
                  style: GoogleFonts.robotoMono(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          Text(
            "Team Members",
            style: AppTextStyles.FFF_16_600(),
          ),
          4.verticalSpacingRadius,
          RichText(
            text: TextSpan(
              text: eventTeam.leader.name,
              style: AppTextStyles.GGG_12_400(color: AppColors.textParagraph),
              children: [
                TextSpan(
                  text: " (Leader)",
                  style: AppTextStyles.GGG_12_400(
                    color: AppColors.textParagraph,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          ...eventTeam.members.map(
            (member) {
              return Padding(
                padding: EdgeInsets.only(top: 4.sp),
                child: RichText(
                  text: TextSpan(
                    text: member.name,
                    style: AppTextStyles.GGG_12_400(
                        color: AppColors.textParagraph),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CreateTeamCard extends StatelessWidget {
  final Event event;
  final bool showLoading;
  final String loadingText;
  const _CreateTeamCard({
    required this.event,
    this.showLoading = false,
    this.loadingText = "",
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.sp),
      child: Stack(
        children: [
          DottedBorder(
            borderType: BorderType.RRect,
            radius: Radius.circular(16.sp),
            color: AppColors.primaryColor,
            strokeWidth: 1.sp,
            dashPattern: [8.sp, 8.sp],
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 12.sp,
                horizontal: 16.sp,
              ).copyWith(right: 8.sp),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.sp),
              ),
              child: Row(
                children: [
                  showLoading
                      ? SizedBox.square(
                          dimension: 24.sp,
                          child: const CircularProgressIndicator.adaptive(),
                        )
                      : CustomIcon(
                          CustomIcons.team,
                          size: 24.sp,
                        ),
                  8.horizontalSpaceRadius,
                  Expanded(
                    child: Text(
                      showLoading ? loadingText : 'Create or Join a Team',
                      style: AppTextStyles.FFF_16_400(
                        color: AppColors.textHeader,
                      ),
                    ),
                  ),
                  if (!showLoading) ...[
                    8.horizontalSpaceRadius,
                    CustomIcon(
                      CustomIcons.arrow_forward,
                      color: AppColors.textDarker,
                      size: 14.4.sp,
                      containerSize: 24.sp,
                    ),
                  ],
                ],
              ),
            ),
          ),
          if (!showLoading)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16.sp),
                  overlayColor: WidgetStateProperty.all(
                    AppColors.primaryColor.withOpacity(0.075),
                  ),
                  onTap: () => _onPressed(context),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPressed(BuildContext context) {
    CustomBottomSheet.showSheet(
      showHandle: true,
      content: TeamCreateJoinSheet(
        onCreate: () {
          Get.back();
          context.read<MyEventDetailsBloc>().add(
                MyEventDetailsCreateTeam(
                  event: event,
                  teamName: '',
                ),
              );
        },
        onJoin: () {
          Get.back();
          CustomBottomSheet.showSheet(
            content: TeamJoinSheet(
              event: event,
              myEventDetailsBloc: context.read<MyEventDetailsBloc>(),
            ),
          );
        },
      ),
    );
  }
}
