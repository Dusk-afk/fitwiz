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
    Widget button = GestureDetector(
      onTap: disabled ? onPressed : null,
      child: ElevatedButton(
        onPressed: disabled ? null : onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(_getBgColor),
          foregroundColor: WidgetStateProperty.resolveWith(_getFgColor),
          shape: WidgetStateProperty.resolveWith((states) => StadiumBorder(
                side: BorderSide(
                  color: _getBorderColor(states),
                  width: _getBorderWidth(states),
                ),
              )),
          overlayColor: WidgetStateProperty.resolveWith(_getOverlayColor),
          padding: WidgetStateProperty.all(
            padding ??
                EdgeInsets.symmetric(
                  horizontal: _iconOnly ? 12 : 32,
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
                    style: AppTextStyles.FFF_16_700(),
                  ),
                if (rightIcon != null) ...[
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
        return AppColors.buttonDisabledPrimary;
      }
      return AppColors.buttonPrimary;
    }
    // Secondary color scheme
    else if (_type == _ButtonType.secondary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonDisabledSecondary;
      }
      return AppColors.buttonSecondary;
    }
    // Outline color scheme
    else if (_type == _ButtonType.outline) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonDisabledOutline;
      }
      return AppColors.buttonOutline;
    }

    return Colors.transparent;
  }

  /// Returns the foreground color based on the button type and state
  Color _getFgColor(Set<WidgetState> states) {
    // Primary color scheme
    if (_type == _ButtonType.primary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonTextDisabledPrimary;
      }
      return AppColors.buttonTextPrimary;
    }
    // Secondary color scheme
    else if (_type == _ButtonType.secondary) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonTextDisabledSecondary;
      }
      return AppColors.buttonTextSecondary;
    }
    // Outline color scheme
    else if (_type == _ButtonType.outline) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonTextDisabledOutline;
      }
      if (destructive) {
        return AppColors.buttonTextOutlineDestructive;
      }
      return AppColors.buttonTextOutline;
    }

    return Colors.transparent;
  }

  /// Returns the border color based on the button type and state
  Color _getBorderColor(Set<WidgetState> states) {
    // Secondary color scheme
    if (_type == _ButtonType.secondary) {
      return AppColors.buttonSecondaryBorder;
    }

    if (_type == _ButtonType.outline) {
      if (states.contains(WidgetState.disabled)) {
        return AppColors.buttonOutlineBorderDisabled;
      }
      if (destructive) {
        return AppColors.buttonOutlineBorderDestructive;
      }
      return _outlineNormalColor ?? AppColors.buttonOutlineBorder;
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
        return AppColors.buttonOutlineBorderDestructive.withOpacity(0.1);
      }
      return Colors.grey.withOpacity(0.2);
    }

    return Colors.transparent;
  }
}
