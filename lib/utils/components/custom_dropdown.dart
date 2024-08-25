import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final void Function(T?)? onChanged;
  final TextStyle? style;
  final String? Function(T?)? validator;
  final void Function()? onTap;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final bool disabled;
  final String? errorText;
  final Color? normalFillColor;
  final Color? normalBorderColor;
  final Color? focusedBorderColor;
  final double? width;
  final bool isLoading;

  const CustomDropdown({
    super.key,
    required this.items,
    this.value,
    required this.onChanged,
    this.style,
    this.validator,
    this.onTap,
    this.placeholder,
    this.placeholderStyle,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.disabled = false,
    this.errorText,
    this.normalFillColor,
    this.normalBorderColor,
    this.focusedBorderColor,
    this.width,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildDropdown(context),
        if (isLoading)
          Positioned(
            top: 8.sp,
            right: 16.sp,
            bottom: 8.sp,
            child: const Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
      ],
    );
  }

  Widget _buildDropdown(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Theme(
        data: Theme.of(context).copyWith(
          // To color the menu's background.
          canvasColor: AppColors.containerBg,
        ),
        child: DropdownButtonFormField2(
          items: items,
          value: value,
          onChanged: onChanged,
          buttonStyleData: ButtonStyleData(
            height: 48.sp,
            width: width ?? double.infinity,
          ),
          style:
              style ?? AppTextStyles.FFF_16_400(color: AppColors.textFieldText),
          validator: validator,
          menuItemStyleData: MenuItemStyleData(
            height: 48.sp,
          ),
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: placeholderStyle ??
                AppTextStyles.FFF_16_400(color: AppColors.textFieldHint),
            filled: true,
            fillColor: disabled
                ? AppColors.textFieldFillDisabled
                : normalFillColor ?? AppColors.textFieldFill,
            errorText: errorText,
            errorStyle: AppTextStyles.FFF_10_400(
              color: AppColors.textFieldTextError,
            ),
            prefixIcon: prefixIcon,
            prefixIconConstraints: prefixIconConstraints,
            suffixIcon: suffixIcon,
            suffixIconConstraints: suffixIconConstraints,
            enabled: !disabled,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.sp,
              vertical: 2.sp,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: normalBorderColor ?? Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: normalBorderColor ?? Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide(
                color: focusedBorderColor ?? AppColors.textFieldBorder,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorderError,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: const BorderSide(
                color: AppColors.textFieldBorderError,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.sp),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
