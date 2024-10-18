import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetailsSection extends StatelessWidget {
  /// Callback to be called when the user wants to edit the profile details
  ///
  /// If null, no edit button will be shown
  final VoidCallback? onEdit;

  /// The title of the section
  final String title;

  /// The child widget to be displayed in the section
  final Widget child;

  const ProfileDetailsSection({
    super.key,
    this.onEdit,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.sp),
        color: AppColors.containerBg,
        border: Border(
          bottom: BorderSide(
            color: AppColors.textLight2,
            width: 1.sp,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.EEE_20_600(color: AppColors.textHeader),
                ),
              ),
              8.horizontalSpaceRadius,
              if (onEdit != null)
                CustomButton.outlineIcon(
                  onPressed: onEdit,
                  icon: CustomIcon(
                    CustomIcons.edit,
                    size: 16.sp,
                  ),
                ),
            ],
          ),
          16.verticalSpacingRadius,
          child,
        ],
      ),
    );
  }
}
