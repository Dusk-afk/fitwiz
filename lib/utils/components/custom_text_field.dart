import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';

/// A wrapper around the [TextField] widget that adheres to the app's design system.
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final int? minLines;
  final int? maxLines;
  final String? errorText;
  final bool disabled;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final TextStyle? style;
  final ValueChanged<String>? onChanged;
  final Widget? prefixIcon;
  final BoxConstraints? prefixIconConstraints;
  final Widget? suffixIcon;
  final BoxConstraints? suffixIconConstraints;
  final VoidCallback? onTap;
  final bool expands;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool obscureText;
  final bool isLoading;
  final bool autofocus;

  // Colors when the field is not focused
  final Color? normalFillColor;
  final Color? normalBorderColor;

  // Colors when the field is focused
  final Color? focusedBorderColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.placeholder,
    this.placeholderStyle,
    this.minLines,
    this.maxLines = 1,
    this.errorText,
    this.disabled = false,
    this.validator,
    this.inputFormatters,
    this.normalFillColor,
    this.normalBorderColor,
    this.focusedBorderColor,
    this.maxLength,
    this.style,
    this.onChanged,
    this.prefixIcon,
    this.prefixIconConstraints,
    this.suffixIcon,
    this.suffixIconConstraints,
    this.onTap,
    this.expands = false,
    this.keyboardType,
    this.readOnly = false,
    this.obscureText = false,
    this.isLoading = false,
    this.autofocus = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late TextEditingController _controller =
      widget.controller ?? TextEditingController();
  late bool _isLoading = widget.isLoading;

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CustomTextField oldWidget) {
    if (widget.controller != oldWidget.controller) {
      if (oldWidget.controller == null) {
        _controller.dispose();
      }
      _controller = widget.controller ?? TextEditingController();
    }

    if (widget.isLoading != oldWidget.isLoading) {
      setState(() {
        _isLoading = widget.isLoading;
      });
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildWrappedTextFormField(),
        if (widget.maxLength != null) ...[
          _buildWrappedTextFormField(),
          8.verticalSpacingRadius,
          ListenableBuilder(
            listenable: _controller,
            builder: (context, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: _controller.text.length.toString(),
                      style:
                          AppTextStyles.GGG_12_400(color: AppColors.textHeader),
                      children: [
                        TextSpan(
                          text: ' / ${widget.maxLength}',
                          style: AppTextStyles.GGG_12_400(
                            color: const Color(0xFFACAABE),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ],
    );
  }

  Widget _buildWrappedTextFormField() {
    return Stack(
      children: [
        _buildTextFormField(),
        if (_isLoading) ...[
          Positioned(
            right: 16.sp,
            top: 8.sp,
            bottom: 8.sp,
            child: const CircularProgressIndicator.adaptive(
              strokeWidth: 2,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: _controller,
      focusNode: widget.focusNode,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: widget.style ??
          AppTextStyles.FFF_16_400(
            color: AppColors.textFieldText,
          ),
      cursorColor: AppColors.textFieldBorder,
      validator: widget.validator,
      inputFormatters: [
        if (widget.maxLength != null)
          LengthLimitingTextInputFormatter(widget.maxLength),
        ...?widget.inputFormatters,
      ],
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      expands: widget.expands,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      autofocus: widget.autofocus,
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: widget.placeholderStyle ??
            AppTextStyles.FFF_16_400(
              color: AppColors.textFieldHint,
            ),
        filled: true,
        fillColor: widget.disabled
            ? AppColors.textFieldFillDisabled
            : widget.normalFillColor ?? AppColors.textFieldFill,
        errorText: widget.errorText,
        errorStyle: AppTextStyles.FFF_10_400(
          color: AppColors.textFieldTextError,
        ),
        prefixIcon: widget.prefixIcon,
        prefixIconConstraints: widget.prefixIconConstraints,
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints: widget.suffixIconConstraints,
        enabled: !widget.disabled,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.sp,
          vertical: 12.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.sp),
          borderSide: BorderSide(
            color: widget.normalBorderColor ?? Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.sp),
          borderSide: BorderSide(
            color: widget.normalBorderColor ?? Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.sp),
          borderSide: BorderSide(
            color: widget.focusedBorderColor ?? AppColors.textFieldBorder,
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
    );
  }
}
