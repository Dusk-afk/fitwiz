import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';

class CustomSearchField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? placeholder;
  final TextStyle? placeholderStyle;
  final VoidCallback? onTap;

  const CustomSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.placeholder,
    this.placeholderStyle,
    this.onTap,
  });

  @override
  State<CustomSearchField> createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late final _controller = widget.controller ?? TextEditingController();

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: _controller,
      onChanged: widget.onChanged,
      placeholder: widget.placeholder ?? "Search",
      placeholderStyle: widget.placeholderStyle ??
          AppTextStyles.FFF_18_400(
            color: AppColors.textLight2,
          ),
      normalFillColor: AppColors.containerBgSecondary,
      normalBorderColor: AppColors.textLightest,
      focusedBorderColor: AppColors.textParagraph,
      prefixIconConstraints: const BoxConstraints(),
      prefixIcon: Container(
        width: 24.sp,
        height: 24.sp,
        // color: Colors.red,
        margin: EdgeInsets.only(left: 16.sp, right: 8.sp),
        child: Center(
          child: CustomIcon(
            CustomIcons.search,
            size: 14.4.sp,
            color: AppColors.textLight,
          ),
        ),
      ),
      suffixIconConstraints: const BoxConstraints(),
      onTap: widget.onTap,
      suffixIcon: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          if (_controller.text.isEmpty) {
            return const SizedBox();
          }
          return Padding(
            padding: EdgeInsets.only(right: 4.sp),
            child: IconButton(
              onPressed: () => _controller.clear(),
              icon: SizedBox(
                width: 24.sp,
                height: 24.sp,
                child: Center(
                  child: CustomIcon(
                    CustomIcons.close,
                    size: 13.2.sp,
                    color: AppColors.textHeader,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
