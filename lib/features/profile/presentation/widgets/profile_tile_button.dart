import 'package:fitwiz/utils/components/custom_cupertino_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ProfileTileActionType { navigate, external, none }

class ProfileTileButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;
  final String label;
  final ProfileTileActionType actionType;
  final bool isFirst;
  final bool isLast;

  const ProfileTileButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.label,
    this.actionType = ProfileTileActionType.none,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(
        top: isFirst ? Radius.circular(8.sp) : Radius.circular(2.sp),
        bottom: isLast ? Radius.circular(8.sp) : Radius.circular(2.sp),
      ),
      child: CustomCupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        minSize: 0,
        child: Container(
          height: 56.sp,
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
          ),
          child: Row(
            children: [
              DefaultTextStyle(
                style: TextStyle(
                  color: AppColors.greyShades[12],
                ),
                child: SizedBox.square(
                  dimension: 24.sp,
                  child: Center(
                    child: icon,
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.FFF_16_400(
                    color: AppColors.greyShades[12],
                  ),
                ),
              ),
              8.horizontalSpace,
              DefaultTextStyle(
                style: TextStyle(
                  color: AppColors.greyShades[8],
                ),
                child: SizedBox.square(
                  dimension: 16.sp,
                  child: Center(
                    child: _buildActionIcon(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionIcon() {
    switch (actionType) {
      case ProfileTileActionType.navigate:
        return CustomIcon(
          CustomIcons.right_chevron,
          size: 12.sp,
        );
      case ProfileTileActionType.external:
        return CustomIcon(
          CustomIcons.open,
          size: 11.67.sp,
        );
      case ProfileTileActionType.none:
        return const SizedBox();
    }
  }
}
