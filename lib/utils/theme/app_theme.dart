import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryShades[0],
    primaryColor: AppColors.primaryColor,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.primaryColor.withOpacity(0.4),
      selectionHandleColor: AppColors.primaryColor,
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.primaryShades[0]),
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        if (states.contains(WidgetState.error)) {
          return AppColors.redShades[2];
        }
        return AppColors.primaryShades[0];
      }),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: BorderSide(
        color: AppColors.greyShades[8],
        width: 2,
      ),
    ),
  );
}
