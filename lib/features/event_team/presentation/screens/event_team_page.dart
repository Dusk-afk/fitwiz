part of 'event_team_screen.dart';

class _EventTeamPage extends StatelessWidget {
  final EventTeam eventTeam;
  final VoidCallback? onLeaveTeam;
  final bool isUpdating;

  const _EventTeamPage({
    required this.eventTeam,
    this.onLeaveTeam,
    required this.isUpdating,
  });

  @override
  Widget build(BuildContext context) {
    AuthState authState = context.watch<AuthBloc>().state;
    User? currentUser;
    if (authState is AuthLoggedIn) {
      currentUser = authState.user;
    }

    bool isMyTeam =
        currentUser != null && eventTeam.leader.id == currentUser.id;

    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      children: [
        32.verticalSpace,
        Text(
          "Team Code",
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[12],
          ),
        ),
        8.verticalSpace,
        Row(
          children: [
            CustomCupertinoButton(
              onPressed: _copyToClipboard,
              padding: EdgeInsets.zero,
              minSize: 0,
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.w,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryShades[3],
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Row(
                  children: [
                    Text(
                      eventTeam.teamCode,
                      style: GoogleFonts.robotoMono(
                        fontSize: 24.sp,
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.horizontalSpace,
                    CustomIcon(
                      CustomIcons.copy,
                      size: 19.sp,
                      containerSize: 24.sp,
                      color: AppColors.primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        4.verticalSpace,
        Text(
          "Share this code with your partner/friend to join your team",
          style: AppTextStyles.FFF_16_400(
            color: AppColors.greyShades[11],
          ),
        ),
        24.verticalSpace,
        Text(
          "Members",
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[12],
          ),
        ),
        8.verticalSpace,
        _buildMembers(context),
        24.verticalSpace,
        Text(
          "Danger Zone!",
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[12],
          ),
        ),
        8.verticalSpace,
        CustomButton(
          onPressed: () => _onDeleteLeaveTeam(isMyTeam),
          destructive: true,
          label: isMyTeam ? 'Delete Team' : 'Leave Team',
          loading: isUpdating,
        ),
      ],
    );
  }

  Widget _buildMembers(BuildContext context) {
    List<UserShort> members = [eventTeam.leader, ...eventTeam.members];
    AuthState authState = context.read<AuthBloc>().state;
    User? currentUser;
    if (authState is AuthLoggedIn) {
      currentUser = authState.user;
      int index =
          members.indexWhere((element) => element.id == currentUser!.id);
      if (index != -1) {
        UserShort user = members.removeAt(index);
        members.insert(0, user);
      }
    }

    return Column(
      children: columnGap(
        2.h,
        [
          for (int i = 0; i < members.length; i++)
            _MemberCard(
              key: ValueKey(members[i].id),
              member: members[i],
              isLeader: members[i] == eventTeam.leader,
              isMe: currentUser != null && members[i].id == currentUser.id,
              isFirst: i == 0,
              isMeLeader:
                  currentUser != null && currentUser.id == eventTeam.leader.id,
            ),
          _MemberCard(
            isInviteButton: true,
            isFirst: members.isEmpty,
            isLast: true,
          ),
        ],
      ),
    );
  }

  void _onDeleteLeaveTeam(bool isDelete) {
    CustomBottomSheet.showSimpleSheet(
      icon: CustomIcon(
        CustomIcons.delete,
        size: 36.sp,
        color: AppColors.redShades[9],
      ),
      title: isDelete ? "Delete Team?" : "Leave Team?",
      message: isDelete
          ? "This will delete your team and all the members will be removed."
          : "This will remove you from the team. You can join back anytime.",
      actions: [
        Expanded(
          child: CustomButton.outline(
            onPressed: () {
              Get.back();
            },
            label: "Cancel",
          ),
        ),
        Expanded(
          child: CustomButton(
            onPressed: () {
              Get.back();
              onLeaveTeam?.call();
            },
            label: isDelete ? "Delete" : "Leave",
            destructive: true,
          ),
        ),
      ],
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(
      text: eventTeam.teamCode,
    ));
    CustomNotifications.notifySuccess(
      context: Get.context!,
      message: "Copied to clipboard",
    );
  }
}

class _MemberCard extends StatelessWidget {
  /// The member to display
  final UserShort? member;

  // Whether to act as an invite button
  final bool isInviteButton;

  /// Whether the member is the first in the list
  final bool isFirst;

  /// Whether the member is the last in the list
  final bool isLast;

  /// Whether the member is the leader
  final bool isLeader;

  /// Whether the member is the current user
  final bool isMe;

  /// Whether the current user is the leader
  final bool isMeLeader;

  const _MemberCard({
    super.key,
    this.member,
    this.isInviteButton = false,
    this.isFirst = false,
    this.isLast = false,
    this.isLeader = false,
    this.isMe = false,
    this.isMeLeader = false,
  }) : assert(
          (isInviteButton || member != null) &&
              !(isInviteButton && member != null),
          "Either member or invite button must be provided but not both",
        );

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(8.sp) : Radius.circular(2.sp),
        bottom: isLast ? Radius.circular(8.sp) : Radius.circular(2.sp),
      ),
      child: Slidable(
        // TODO: Implement delete team member. Backend support needed
        endActionPane: false && isMeLeader && !isInviteButton && !isMe
            ? const ActionPane(
                extentRatio: 0.2,
                motion: DrawerMotion(),
                children: [
                  // SlidableAction(
                  //   onPressed: (context) {},
                  //   backgroundColor: AppColors.redShades[9],
                  //   foregroundColor: AppColors.white,
                  //   icon: Icons.delete,
                  // ),
                ],
              )
            : null,
        child: _buildChild(),
      ),
    );
  }

  Widget _buildChild() {
    Widget child = Container(
      height: 56.sp,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
      ),
      child: Row(
        children: [
          isInviteButton
              ? Container(
                  width: 32.sp,
                  height: 32.sp,
                  decoration: BoxDecoration(
                    color: AppColors.primaryShades[3],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: CustomIcon(
                      CustomIcons.plus,
                      size: 14.sp,
                      color: AppColors.primaryColor,
                    ),
                  ),
                )
              : Container(
                  width: 32.sp,
                  height: 32.sp,
                  decoration: BoxDecoration(
                    color: AppColors.primaryShades[6],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      member!.name[0],
                      style: AppTextStyles.FFF_16_600(
                        color: AppColors.greyShades[12],
                      ),
                    ),
                  ),
                ),
          16.horizontalSpace,
          Expanded(
            child: Text(
              isInviteButton
                  ? "Invite members"
                  : isMe
                      ? "${member!.name} (You)"
                      : member!.name,
              style: AppTextStyles.FFF_16_400(
                color: AppColors.greyShades[12],
              ),
            ),
          ),
          if (isLeader) ...[
            8.horizontalSpace,
            CustomIcon(
              CustomIcons.crown,
              size: 14.sp,
              color: AppColors.primaryColor,
              containerSize: 24.sp,
            ),
          ],
        ],
      ),
    );

    if (isInviteButton) {
      child = CustomCupertinoButton(
        onPressed: () {},
        padding: EdgeInsets.zero,
        minSize: 0,
        child: child,
      );
    }

    return child;
  }
}
