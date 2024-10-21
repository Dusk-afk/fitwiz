import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';

enum _ButtonType { primary, secondary, outline }

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget? leftIcon;
  final String? label;
  final Widget? rightIcon;
  final EdgeInsetsGeometry? padding;
  final bool disabled;
  final bool destructive;
  final _ButtonType _type;
  final double? elevation;
  final Widget? child;
  final bool loading;

  // Custom Colors
  final Color? _outlineNormalColor;

  // Creates primary button
  const CustomButton({
    super.key,
    required this.onPressed,
    this.leftIcon,
    this.label,
    this.rightIcon,
    this.disabled = false,
    this.padding,
    this.destructive = false,
    this.elevation,
    this.loading = false,
  })  : _type = _ButtonType.primary,
        _outlineNormalColor = null,
        child = null;

  // Creates primary button with child
  const CustomButton.raw({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabled = false,
    this.destructive = false,
    this.elevation,
    this.loading = false,
  })  : _type = _ButtonType.primary,
        leftIcon = null,
        label = null,
        rightIcon = null,
        padding = EdgeInsets.zero,
        _outlineNormalColor = null;

  // Creates secondary button
  const CustomButton.secondary({
    super.key,
    required this.onPressed,
    this.leftIcon,
    this.label,
    this.rightIcon,
    this.disabled = false,
    this.padding,
    this.destructive = false,
    this.elevation,
    this.loading = false,
  })  : _type = _ButtonType.secondary,
        _outlineNormalColor = null,
        child = null;

  /// Creates a primary button with only an icon
  const CustomButton.icon({
    super.key,
    required this.onPressed,
    required Icon icon,
    this.disabled = false,
    this.destructive = false,
    this.loading = false,
  })  : _type = _ButtonType.primary,
        leftIcon = icon,
        label = null,
        rightIcon = null,
        padding = null,
        _outlineNormalColor = null,
        child = null,
        elevation = 0;

  /// Creates a secondary button with only an icon
  const CustomButton.secondaryIcon({
    super.key,
    required this.onPressed,
    required Widget icon,
    this.disabled = false,
    this.destructive = false,
    this.loading = false,
  })  : _type = _ButtonType.secondary,
        leftIcon = icon,
        label = null,
        rightIcon = null,
        padding = null,
        _outlineNormalColor = null,
        child = null,
        elevation = 0;

  /// Creates a outline button
  const CustomButton.outline({
    super.key,
    required this.onPressed,
    this.leftIcon,
    this.label,
    this.rightIcon,
    this.disabled = false,
    this.padding,
    this.destructive = false,
    Color? outlineNormalColor,
    this.elevation = 0,
    this.loading = false,
  })  : _type = _ButtonType.outline,
        _outlineNormalColor = outlineNormalColor,
        child = null;

  /// Creates a outline button with only an icon
  const CustomButton.outlineIcon({
    super.key,
    required this.onPressed,
    required Widget icon,
    this.disabled = false,
    this.destructive = false,
    Color? outlineNormalColor,
    this.loading = false,
  })  : _type = _ButtonType.outline,
        leftIcon = icon,
        label = null,
        rightIcon = null,
        padding = null,
        _outlineNormalColor = outlineNormalColor,
        child = null,
        elevation = 0;

  const CustomButton.outlineRaw({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabled = false,
    this.destructive = false,
    Color? outlineNormalColor,
    this.elevation = 0,
    this.loading = false,
  })  : _type = _ButtonType.outline,
        leftIcon = null,
        label = null,
        rightIcon = null,
        padding = null,
        _outlineNormalColor = outlineNormalColor;

  /// Determines if the button has only an icon
  bool get _iconOnly =>
      label == null &&
      ((leftIcon != null && rightIcon == null) ||
          (leftIcon == null && rightIcon != null));

  @override
  Widget build(BuildContext context) {
    bool effectiveDisabled = disabled || loading;

    Widget button = GestureDetector(
      onTap: effectiveDisabled ? onPressed : null,
      child: ElevatedButton(
        onPressed: effectiveDisabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(_getBgColor),
          foregroundColor: WidgetStateProperty.resolveWith(_getFgColor),
          shape: WidgetStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp),
                    side: BorderSide(
                      color: _getBorderColor(states),
                      width: _getBorderWidth(states),
                    ),
                  )),
          overlayColor: WidgetStateProperty.resolveWith(_getOverlayColor),
          padding: WidgetStateProperty.all(
            padding ??
                EdgeInsets.symmetric(
                  horizontal: _iconOnly ? 12.w : 32.w,
                ),
          ),
          minimumSize: WidgetStateProperty.all(Size(48.sp, 48.sp)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          elevation: WidgetStateProperty.all(elevation),
        ),
        child: child ??
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leftIcon != null) ...[
                  leftIcon!,
                  if (label != null || rightIcon != null) SizedBox(width: 8.w),
                ],
                if (label != null)
                  Text(
                    label!,
                    style: AppTextStyles.FFF_16_600(),
                  ),
                if (loading) ...[
                  SizedBox(width: 8.w),
                  SizedBox(
                    width: 16.sp,
                    height: 16.sp,
                    child: Builder(
                      builder: (context) {
                        return CircularProgressIndicator.adaptive(
                          strokeWidth: 2.sp,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            DefaultTextStyle.of(context).style.color!,
                          ),
                        );
                      },
                    ),
                  ),
                ] else if (rightIcon != null) ...[
                  if (label != null || leftIcon != null) SizedBox(width: 8.w),
                  rightIcon!,
                ],
              ],
            ),
      ),
    );

    Widget invisibleButton = Visibility(
      maintainInteractivity: false,
      child: button,
    );

    if (_iconOnly) {
      return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          invisibleButton,
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: AppColors.textLighter.withOpacity(0.6),
                  // color: Colors.red,
                  blurRadius: 32.sp,
                ),
              ]),
            ),
          ),
          button,
        ],
      );
    }

    return button;
  }

  /// Returns the background color based on the button type and state
  Color _getBgColor(Set<WidgetState> states) {
    // Primary color scheme
    if (_type == _ButtonType.primary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[5];
      }
      if (destructive) {
        return AppColors.redShades[9];
      }
      return AppColors.primaryColor;
    }
    // Secondary color scheme
    else if (_type == _ButtonType.secondary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[0];
      }
      return AppColors.primaryShades[0];
    }
    // Outline color scheme
    else if (_type == _ButtonType.outline) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[0];
      }
      return AppColors.primaryShades[0];
    }

    return Colors.transparent;
  }

  /// Returns the foreground color based on the button type and state
  Color _getFgColor(Set<WidgetState> states) {
    // Primary color scheme
    if (_type == _ButtonType.primary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[8];
      }
      return AppColors.primaryShades[0];
    }
    // Secondary color scheme
    else if (_type == _ButtonType.secondary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[8];
      }
      return AppColors.primaryColor;
    }
    // Outline color scheme
    else if (_type == _ButtonType.outline) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[8];
      }
      if (destructive) {
        return AppColors.redShades[9];
      }
      return AppColors.primaryColor;
    }

    return Colors.transparent;
  }

  /// Returns the border color based on the button type and state
  Color _getBorderColor(Set<WidgetState> states) {
    if (_type == _ButtonType.outline) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.primaryShades[8];
      }
      if (destructive) {
        return AppColors.redShades[9];
      }
      return _outlineNormalColor ?? AppColors.primaryColor;
    }

    return Colors.transparent;
  }

  /// Returns the border width based on the button type and state
  double _getBorderWidth(Set<WidgetState> states) {
    // If primary button, no border
    if (_type == _ButtonType.primary) return 0;

    // If icon only and secondary button, no border
    if (_type == _ButtonType.secondary && _iconOnly) return 0;

    if (_type == _ButtonType.outline) return 2.sp;

    return 2.sp;
  }

  /// Returns the overlay color based on the button type and state
  Color _getOverlayColor(Set<WidgetState> sets) {
    // Primary color scheme
    if (_type == _ButtonType.primary) {
      return Colors.white.withOpacity(0.1);
    }
    // Secondary color scheme
    else if (_type == _ButtonType.secondary) {
      return Colors.grey.withOpacity(0.2);
    }
    // Outline color scheme
    else if (_type == _ButtonType.outline) {
      if (destructive) {
        return AppColors.redShades[9].withOpacity(0.1);
      }
      return Colors.grey.withOpacity(0.2);
    }

    return Colors.transparent;
  }
}
