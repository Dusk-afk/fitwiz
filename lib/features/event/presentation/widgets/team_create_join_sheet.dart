import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TeamCreateJoinSheet extends StatelessWidget {
  final VoidCallback? onJoin;
  final VoidCallback? onCreate;
  const TeamCreateJoinSheet({super.key, this.onJoin, this.onCreate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.sp,
        right: 16.sp,
        bottom: safeBottomPadding(16.sp),
      ),
      child: Row(
        children: [
          Expanded(
            child: _button(
              onPressed: onJoin,
              icon: CustomIcon(
                CustomIcons.team,
                size: 32.sp,
              ),
              text: 'Join Team',
            ),
          ),
          16.horizontalSpaceRadius,
          Expanded(
            child: _button(
              onPressed: onCreate,
              icon: CustomIcon(
                CustomIcons.team_create,
                size: 32.sp,
              ),
              text: 'Create Team',
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required VoidCallback? onPressed,
    required Widget icon,
    required String text,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        return TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            backgroundColor: WidgetStateProperty.all(
                AppColors.primaryColor.withOpacity(0.1)),
            overlayColor: WidgetStateProperty.all(
                AppColors.primaryColor.withOpacity(0.1)),
            foregroundColor: WidgetStateProperty.all(AppColors.primaryColor),
            minimumSize: WidgetStateProperty.all(Size(width, width)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.sp),
              ),
            ),
          ),
          child: Column(
            children: [
              icon,
              8.verticalSpacingRadius,
              Text(
                text,
                style: AppTextStyles.FFF_16_400(
                  color: AppColors.textHeader,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
