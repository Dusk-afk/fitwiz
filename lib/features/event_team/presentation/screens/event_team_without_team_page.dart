part of 'event_team_screen.dart';

class _EventTeamWithoutTeamPage extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onCreateTeam;
  final void Function(String teamCode)? onJoinTeam;

  const _EventTeamWithoutTeamPage({
    this.isLoading = false,
    this.onCreateTeam,
    this.onJoinTeam,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      children: [
        32.verticalSpace,
        _TeamCodeField(
          isLoading: isLoading,
          onJoinTeam: onJoinTeam,
        ),
        16.verticalSpace,
        _buildOr(),
        16.verticalSpace,
        CustomButton(
          onPressed: onCreateTeam,
          label: 'Create Team',
          padding: EdgeInsets.zero,
          loading: isLoading,
        ),
        8.verticalSpace,
        Text(
          "If your partner/friend has not created a team yet.",
          style: AppTextStyles.FFF_16_400(
            color: AppColors.greyShades[11],
          ),
        ),
      ],
    );
  }

  Widget _buildOr() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1.h,
            color: AppColors.greyShades[8],
          ),
        ),
        4.horizontalSpace,
        Text(
          'OR',
          style: AppTextStyles.GGG_12_400(
            color: AppColors.greyShades[8],
          ),
        ),
        4.horizontalSpace,
        Expanded(
          child: Container(
            height: 1.h,
            color: AppColors.greyShades[8],
          ),
        ),
      ],
    );
  }
}

class _TeamCodeField extends StatefulWidget {
  final bool isLoading;
  final void Function(String teamCode)? onJoinTeam;
  const _TeamCodeField({super.key, required this.isLoading, this.onJoinTeam});

  @override
  State<_TeamCodeField> createState() => _TeamCodeFieldState();
}

class _TeamCodeFieldState extends State<_TeamCodeField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "Team Code",
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[11],
          ),
        ),
        4.verticalSpace,
        CustomTextField(
          controller: _controller,
          placeholder: 'Enter team code',
          disabled: widget.isLoading,
        ),
        16.verticalSpace,
        CustomButton(
          onPressed: widget.onJoinTeam == null
              ? null
              : () {
                  if (_controller.text.isNotEmpty) {
                    widget.onJoinTeam?.call(_controller.text.trim());
                  }
                },
          label: 'Join Team',
          padding: EdgeInsets.zero,
          loading: widget.isLoading,
        ),
        8.verticalSpace,
        Text(
          "If you have a team code from your partner/friend.",
          style: AppTextStyles.FFF_16_400(
            color: AppColors.greyShades[11],
          ),
        ),
      ],
    );
  }
}
