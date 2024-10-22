import 'package:fitwiz/data/models/user_short.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_event_details/my_event_details_bloc.dart';
import 'package:fitwiz/features/event_team/presentation/screens/event_team_screen.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeamCard extends StatelessWidget {
  final Event event;
  const TeamCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEventDetailsBloc, MyEventDetailsState>(
      builder: (context, state) {
        bool isLoading = state.isLoading;
        bool isTeamEvent = event.isTeamEvent;
        EventTeam? eventTeam = state.eventTeam;
        bool isInTeam = eventTeam != null;

        if (isLoading) return const SizedBox();
        if (!isInTeam && !isTeamEvent) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "Team",
                    style: AppTextStyles.FFF_16_600(
                      color: AppColors.greyShades[12],
                    ),
                  ),
                ),
                if (!isInTeam) ...[
                  Text(
                    "You are not in a team",
                    style: AppTextStyles.FFF_16_400(
                      color: AppColors.redShades[11],
                    ),
                  ),
                  4.horizontalSpace,
                  CustomIcon(
                    CustomIcons.alert,
                    size: 12.sp,
                    color: AppColors.redShades[11],
                  )
                ] else
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        textStyle: AppTextStyles.FFF_16_400(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    child: CupertinoButton(
                      onPressed: () {
                        Get.to(() => EventTeamScreen(
                              myEventDetailsBloc:
                                  context.read<MyEventDetailsBloc>(),
                              previousTitle: event.name,
                            ));
                      },
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: Text(
                        "View",
                        style: AppTextStyles.FFF_16_400(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            8.verticalSpace,
            if (!isInTeam)
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  onPressed: () {
                    Get.to(() => EventTeamScreen(
                          myEventDetailsBloc:
                              context.read<MyEventDetailsBloc>(),
                          previousTitle: event.name,
                        ));
                  },
                  label: "Create/Join Team",
                  padding: EdgeInsets.zero,
                ),
              )
            else
              _buildMembers(eventTeam.leader, eventTeam.members),
            24.verticalSpace,
          ],
        );
      },
    );
  }

  Widget _buildMembers(UserShort leader, List<UserShort> members) {
    List<UserShort> allMembers = [leader, ...members];
    List<Widget> children = [];

    double size = 52.sp;
    double overlap = 16.sp;

    for (int i = 0; i < allMembers.length; i++) {
      children.add(Positioned(
        left: i * (size - overlap),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.greyShades[2],
              width: 2.sp,
            ),
            color: AppColors.primaryShades[6],
          ),
          child: Center(
            child: Text(
              allMembers[i].name[0],
              style: AppTextStyles.FFF_16_600(
                color: AppColors.greyShades[12],
              ),
            ),
          ),
        ),
      ));
    }

    return SizedBox(
      height: size,
      child: Stack(
        children: children,
      ),
    );
  }
}
