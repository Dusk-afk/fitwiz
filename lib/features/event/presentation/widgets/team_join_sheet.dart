import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_event_details/my_event_details_bloc.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TeamJoinSheet extends StatefulWidget {
  final Event event;
  final MyEventDetailsBloc myEventDetailsBloc;
  const TeamJoinSheet({
    super.key,
    required this.event,
    required this.myEventDetailsBloc,
  });

  @override
  State<TeamJoinSheet> createState() => _TeamJoinSheetState();
}

class _TeamJoinSheetState extends State<TeamJoinSheet> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _teamCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyEventDetailsBloc, MyEventDetailsState>(
      bloc: widget.myEventDetailsBloc,
      builder: (context, state) {
        bool loading = state.isLoading || state.isUpdating;
        String? error = state.errorMessage;

        return BlocListener<MyEventDetailsBloc, MyEventDetailsState>(
          bloc: widget.myEventDetailsBloc,
          listener: _myEventDetailsBlocListener,
          child: Padding(
            padding: EdgeInsets.only(
              left: 16.sp,
              right: 16.sp,
              bottom: safeBottomPadding(16.sp),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Team Code',
                    style:
                        AppTextStyles.FFF_16_400(color: AppColors.textHeader),
                  ),
                  if (error != null) ...[
                    8.verticalSpacingRadius,
                    Text(
                      error,
                      style: AppTextStyles.FFF_16_400(color: AppColors.error),
                    ),
                  ],
                  16.verticalSpacingRadius,
                  CustomTextField(
                    controller: _teamCodeController,
                    normalBorderColor: AppColors.textHeader,
                    autofocus: true,
                    validator: (value) {
                      if (value!.isEmpty) return 'Please enter team code';
                      return null;
                    },
                  ),
                  16.verticalSpacingRadius,
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      loading: loading,
                      onPressed: _onJoinTeamPressed,
                      label: 'Join Team',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onJoinTeamPressed() {
    if (!_formKey.currentState!.validate()) return;
    widget.myEventDetailsBloc.add(
      MyEventDetailsJoinTeam(
        event: widget.event,
        teamCode: _teamCodeController.text,
      ),
    );
  }

  void _myEventDetailsBlocListener(
    BuildContext context,
    MyEventDetailsState state,
  ) {
    if (!state.isUpdating && state.errorMessage == null) {
      Get.back();
    }
  }
}
