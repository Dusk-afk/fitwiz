import 'package:fitwiz/data/models/user_short.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_event_details/my_event_details_bloc.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_cupertino_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

part 'event_team_without_team_page.dart';
part 'event_team_page.dart';

class EventTeamScreen extends StatelessWidget {
  final MyEventDetailsBloc myEventDetailsBloc;
  final String? previousTitle;
  const EventTeamScreen({
    super.key,
    required this.myEventDetailsBloc,
    this.previousTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEventDetailsBloc, MyEventDetailsState>(
      bloc: myEventDetailsBloc,
      builder: (context, state) {
        EventTeam? eventTeam = state.eventTeam;
        bool isLoading = state.isLoading || state.isUpdating;

        return CustomScaffold(
          appBarParams: CustomAppBarParams(
            title: 'Team',
            previousTitle: previousTitle,
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: eventTeam == null
                ? _EventTeamWithoutTeamPage(
                    isLoading: isLoading,
                    onCreateTeam: () => _onCreateTeam(state.event!),
                    onJoinTeam: (teamCode) =>
                        _onJoinTeam(state.event!, teamCode),
                  )
                : _EventTeamPage(
                    eventTeam: eventTeam,
                    onLeaveTeam: () {
                      myEventDetailsBloc.add(MyEventDetailsLeaveTeam(
                        event: state.event!,
                      ));
                    },
                    isUpdating: state.isUpdating,
                  ),
          ),
        );
      },
    );
  }

  void _onCreateTeam(Event event) {
    myEventDetailsBloc.add(MyEventDetailsCreateTeam(
      event: event,
      teamName: '',
    ));
  }

  void _onJoinTeam(Event event, String teamCode) {
    myEventDetailsBloc.add(MyEventDetailsJoinTeam(
      event: event,
      teamCode: teamCode,
    ));
  }
}
