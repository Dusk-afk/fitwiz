import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_nav_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_scaffold_action.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_nav_bar.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// A custom scaffold which should be used as the base scaffold for the app.
///
/// This ensures platform consistency for components like app bar.
class CustomScaffold extends StatelessWidget {
  final CustomAppBarParams? appBarParams;
  final CustomScaffoldAction? action;
  final CustomNavBarParams? navBarParams;
  final Widget? child;

  const CustomScaffold({
    super.key,
    this.appBarParams,
    this.action,
    this.navBarParams,
    this.child,
  });

  bool get isIOS => Theme.of(Get.context!).platform == TargetPlatform.iOS;

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Brightness.light,
        primaryColor: AppColors.primaryColor,
      ),
      child: Scaffold(
        backgroundColor: AppColors.primaryShades[2],
        body: Column(
          children: [
            if (appBarParams != null) _buildAppBar(),
            Expanded(
              child: _updateMediaQuery(context, child ?? const SizedBox()),
            ),
            if (action != null) _buildAction(context),
            if (navBarParams != null) _buildNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    if (isIOS) {
      return SizedBox(
        height: 44 + Get.mediaQuery.padding.top,
        child: CupertinoNavigationBar(
          middle: appBarParams!.title == null
              ? null
              : Text(
                  appBarParams!.title!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
          previousPageTitle: appBarParams!.previousTitle,
          border: Border.all(color: Colors.transparent),
        ),
      );
    }

    return const Placeholder(
      fallbackHeight: 50,
    );
  }

  Widget _buildAction(BuildContext context) {
    double bottomPadding = 24.h;
    if (navBarParams == null) {
      bottomPadding = safeBottomPadding(bottomPadding, context);
    }

    return Container(
      width: double.infinity,
      color: AppColors.greyShades[0],
      padding: EdgeInsets.only(
        top: 24.h,
        left: 24.w,
        right: 24.w,
        bottom: bottomPadding,
      ),
      child: CustomButton(
        onPressed: action!.onPressed,
        label: action!.label,
        rightIcon: action!.rightIcon,
        leftIcon: action!.leftIcon,
      ),
    );
  }

  Widget _buildNavBar() {
    return CustomNavBar(
      items: navBarParams!.items,
      selectedIndex: navBarParams!.selectedIndex,
      onIndexChanged: navBarParams!.onIndexChanged,
    );
  }

  Widget _updateMediaQuery(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).removePadding(
        removeTop: appBarParams != null,
        removeBottom: action != null || navBarParams != null,
      ),
      child: child,
    );
  }
}
