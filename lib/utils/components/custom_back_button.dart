import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const CustomBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomButton.secondaryIcon(
      onPressed: onPressed,
      icon: CustomIcon(
        CustomIcons.arrow_back,
        size: 14.4.sp,
        color: AppColors.textParagraph,
      ),
    );
  }
}
