import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';

class CustomBottomSheet {
  static Future<T?> showSimpleSheet<T>({
    required Widget icon,
    required String title,
    required String message,
    List<Widget>? actions,
    double? iconContainerSize,
    TextStyle? titleStyle,
    double? topPadding,
    double? bottomPadding,
    bool isDismissible = true,
  }) =>
      showSimpleSheetMultiIcons<T>(
        icons: [icon],
        title: title,
        message: message,
        actions: actions,
        iconContainerSize: iconContainerSize,
        titleStyle: titleStyle,
        topPadding: topPadding,
        bottomPadding: bottomPadding,
        isDismissible: isDismissible,
      );

  static Future<T?> showSimpleSheetMultiIcons<T>({
    required List<Widget> icons,
    required String title,
    required String message,
    List<Widget>? actions,
    double? iconContainerSize,
    TextStyle? titleStyle,
    double? topPadding,
    double? bottomPadding,
    bool isDismissible = true,
  }) {
    return Get.bottomSheet<T>(
      PopScope(
        canPop: isDismissible,
        child: CustomSheet(
          icons: icons,
          iconContainerSize: iconContainerSize,
          topPadding: topPadding,
          bgColor: AppColors.white,
          content: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(
                        16.sp,
                        0,
                        16.sp,
                        bottomPadding ?? 22.sp,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(24.sp),
                        ),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              title,
                              style: titleStyle ?? AppTextStyles.DDD_25_600(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          8.verticalSpace,
                          Center(
                            child: Text(
                              message,
                              style: AppTextStyles.FFF_16_400(),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Positioned.fill(
                    //   top: null,
                    //   child: Container(
                    //     height: 40.sp,
                    //     decoration: BoxDecoration(
                    //       gradient: LinearGradient(
                    //         colors: [
                    //           AppColors.primaryShades[3].withOpacity(0),
                    //           AppColors.primaryShades[3].withOpacity(0.6),
                    //         ],
                    //         begin: Alignment.topCenter,
                    //         end: Alignment.bottomCenter,
                    //       ),
                    //       borderRadius: BorderRadius.vertical(
                    //         bottom: Radius.circular(24.sp),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),

                // Actions
                if (actions != null)
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      16.w,
                      16.h,
                      16.w,
                      safeBottomPadding(8.h),
                    ),
                    child: Row(
                      children: rowGap(16.w, actions),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static Future<T?> showSheet<T>({
    List<Widget>? icons,
    required Widget content,
    Color? bgColor,
    bool showHandle = false,
    bool isDismissible = true,
  }) {
    return Get.bottomSheet<T>(
      CustomSheet(
        icons: icons,
        content: content,
        bgColor: bgColor,
        showHandle: showHandle,
      ),
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  static Future<T?> showSimpleLoadingSheet<T>({
    String title = 'Please wait',
    required String message,
    bool isDismissible = false,
  }) async {
    return showSimpleSheet<T>(
      icon: SizedBox.square(
        dimension: 24.sp,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(AppColors.primaryColor),
        ),
      ),
      title: title,
      message: message,
      isDismissible: isDismissible,
    );
  }
}

class CustomSheet extends StatelessWidget {
  final List<Widget> icons;
  final Widget content;
  final double? iconContainerSize;
  final double? topPadding;
  final double? bottomPadding;
  final Color? bgColor;
  final bool showHandle;

  const CustomSheet({
    super.key,
    List<Widget>? icons,
    required this.content,
    this.iconContainerSize,
    this.topPadding,
    this.bottomPadding,
    this.bgColor,
    this.showHandle = false,
  }) : icons = icons ?? const [];

  double get iSize => iconContainerSize ?? 88.sp;
  double get tPad => topPadding ?? 32.sp;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.back(),
      child: BackdropFilter(
        filter:
            ImageFilter.blur(sigmaX: 20, sigmaY: 20, tileMode: TileMode.decal),
        child: Container(
          color: const Color.fromRGBO(0, 0, 0, 0.001),
          child: GestureDetector(
            onTap: () {},
            child: Wrap(
              children: [
                Stack(
                  children: [
                    // To remove a thin line which appears between the top of sheet and start of content
                    // Only occurs on Android
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: icons.isEmpty ? 0 : iSize + tPad - 24.sp),
                        decoration: BoxDecoration(
                          color: bgColor ?? AppColors.containerBgSecondary,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.sp),
                          ),
                        ),
                      ),
                    ),

                    // The content
                    _buildSheetContent(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSheetContent() {
    return Column(
      children: [
        // The icon
        icons.isEmpty
            ? Container(
                width: double.infinity,
                height: 24.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(24.sp),
                  ),
                  color: bgColor ?? AppColors.containerBgSecondary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    6.verticalSpacingRadius,
                    if (showHandle)
                      Container(
                        height: 4.sp,
                        width: 40.sp,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                  ],
                ),
              )
            : SizedBox(
                height: iSize + tPad,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: iSize / 2 + tPad,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(24.sp),
                          ),
                          color: bgColor ?? AppColors.containerBgSecondary,
                        ),
                      ),
                    ),
                    ...icons.mapIndexed(
                      (index, icon) => Align(
                        alignment: Alignment.topCenter,
                        child: _buildIcon(icon, index),
                      ),
                    ),
                  ],
                ),
              ),
        content
      ],
    );
  }

  Widget _buildIcon(Widget icon, int index) {
    return Container(
      width: iSize,
      height: iSize,
      margin: EdgeInsets.only(
        left: 56.sp * index.toDouble(),
        right: 56.sp * (icons.length - index - 1).toDouble(),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD0CEDD).withOpacity(0.6),
            blurRadius: 32,
          )
        ],
      ),
      child: Center(child: icon),
    );
  }
}
