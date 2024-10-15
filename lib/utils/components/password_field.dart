import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatefulWidget {
  final String? title;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    this.title,
    this.controller,
    this.focusNode,
    this.validator,
  });

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: widget.title,
      controller: widget.controller,
      focusNode: widget.focusNode,
      validator: widget.validator,
      obscureText: _obscureText,
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
            child: CustomIcon(
              _obscureText ? CustomIcons.eye : CustomIcons.eye_off,
              size: _obscureText ? 14.sp : 16.sp,
              containerSize: 24.sp,
            ),
          ),
        ),
      ),
    );
  }
}
