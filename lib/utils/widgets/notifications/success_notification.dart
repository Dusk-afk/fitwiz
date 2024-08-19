import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';

class SuccessNotification extends StatelessWidget {
  final String message;
  const SuccessNotification({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.sp,
      padding: EdgeInsets.only(
        left: 8.sp,
        right: 16.sp,
      ),
      margin: EdgeInsets.only(top: 32.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.sp),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD0CEDD).withOpacity(0.6),
            blurRadius: 32.sp,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.sp,
            height: 40.sp,
            decoration: BoxDecoration(
              color: const Color(0xFF80D94A),
              borderRadius: BorderRadius.circular(16.sp),
            ),
            child: Center(
              child: CustomIcon(
                CustomIcons.tick,
                size: 14.4.sp,
                color: Colors.white,
              ),
            ),
          ),
          8.horizontalSpace,
          Expanded(
            child: Text(
              message,
              style: AppTextStyles.GGG_12_400(color: AppColors.textParagraph),
            ),
          ),
        ],
      ),
    );
  }
}
