import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/widgets/notifications/success_notification.dart';

class CustomNotifications {
  const CustomNotifications._();

  static SnackBar _buildSnackBar({
    required BuildContext context,
    VoidCallback? onPresesd,
    required Widget content,
  }) {
    return SnackBar(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      behavior: SnackBarBehavior.fixed,
      elevation: 0,
      showCloseIcon: false,
      backgroundColor: Colors.transparent,
      // TODO: Change the duration to suitable value. This value is just for testing
      duration: const Duration(days: 1),
      content: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          onPresesd?.call();
        },
        child: content,
      ),
    );
  }

  static void notifySuccess({
    required BuildContext context,
    required String message,
  }) {
    final snackBar = _buildSnackBar(
      context: context,
      content: SuccessNotification(message: message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
