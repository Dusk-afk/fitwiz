import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomActions extends StatelessWidget {
  final List<Widget> actions;
  final double? gap;
  const BottomActions({super.key, required this.actions, this.gap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16.sp,
        left: 16.sp,
        right: 16.sp,
        bottom: safeBottomPadding(16.sp),
      ),
      child: Row(
        children: rowGap(gap ?? 16.sp, actions),
      ),
    );
  }
}
