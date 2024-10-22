import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DobSelector extends StatefulWidget {
  final DateTime? initialDate;
  final void Function(DateTime?)? onDateSelected;
  final String? Function(DateTime?)? validator;
  final String? title;

  const DobSelector({
    super.key,
    this.initialDate,
    this.onDateSelected,
    this.validator,
    this.title,
  });

  @override
  State<DobSelector> createState() => _DobSelectorState();
}

class _DobSelectorState extends State<DobSelector> {
  final _controller = TextEditingController();
  DateTime? _selectedDate;
  set selectedDate(DateTime? value) {
    _selectedDate = value;
    _controller.text = value == null ? "" : DateFormat.yMMMMd().format(value);
    widget.onDateSelected?.call(value);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      selectedDate = widget.initialDate;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      title: widget.title,
      controller: _controller,
      readOnly: true,
      onTap: _showDatePicker,
      suffixIcon: Padding(
        padding: EdgeInsets.only(right: 12.w, left: 4.w),
        child: CustomIcon(
          CustomIcons.calendar3,
          color: AppColors.textDarker,
          size: 14.4.sp,
          containerSize: 24.sp,
        ),
      ),
      suffixIconConstraints: const BoxConstraints(),
      validator: (value) {
        return widget.validator?.call(_selectedDate);
      },
    );
  }

  void _showDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }
}
