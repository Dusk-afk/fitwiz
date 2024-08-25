import 'dart:async';

import 'package:fitwiz/features/address/presentation/blocs/edit_pincode/edit_pincode_bloc.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PincodeEditSection extends StatefulWidget {
  final TextEditingController pincodeController;
  final TextEditingController cityController;
  final TextEditingController stateController;
  final TextEditingController countryController;

  const PincodeEditSection({
    super.key,
    required this.pincodeController,
    required this.cityController,
    required this.stateController,
    required this.countryController,
  });

  @override
  State<PincodeEditSection> createState() => _PincodeEditSectionState();
}

class _PincodeEditSectionState extends State<PincodeEditSection> {
  Timer? _debounce;
  String? _lastPincode;

  @override
  void initState() {
    super.initState();
    widget.pincodeController.addListener(_onPincodeChanged);
  }

  @override
  void dispose() {
    widget.pincodeController.removeListener(_onPincodeChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditPincodeBloc, EditPincodeState>(
      listener: _editPincodeBlocListener,
      child: BlocBuilder<EditPincodeBloc, EditPincodeState>(
        builder: (context, state) {
          bool isLoading = state is EditPincodeLoading;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Pincode",
                style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
              ),
              8.verticalSpacingRadius,
              CustomTextField(
                controller: widget.pincodeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Pincode is required";
                  }
                  if (int.tryParse(value) == null) {
                    return "Invalid pincode";
                  }
                  int pincode = int.parse(value);
                  if (pincode < 100000 || pincode > 999999) {
                    return "Invalid pincode";
                  }
                  return null;
                },
                isLoading: isLoading,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              16.verticalSpacingRadius,
              Text(
                "City",
                style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
              ),
              8.verticalSpacingRadius,
              CustomTextField(
                controller: widget.cityController,
                disabled: true,
                isLoading: isLoading,
              ),
              16.verticalSpacingRadius,
              Text(
                "State",
                style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
              ),
              8.verticalSpacingRadius,
              CustomTextField(
                controller: widget.stateController,
                disabled: true,
                isLoading: isLoading,
              ),
              16.verticalSpacingRadius,
              Text(
                "Country",
                style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
              ),
              8.verticalSpacingRadius,
              CustomTextField(
                controller: widget.countryController,
                disabled: true,
                isLoading: isLoading,
              ),
            ],
          );
        },
      ),
    );
  }

  void _onPincodeChanged() {
    String pincode = widget.pincodeController.text;
    if (pincode == _lastPincode) return;
    _lastPincode = pincode;

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      final pincode = int.tryParse(widget.pincodeController.text);
      if (pincode == null) return;
      if (pincode < 100000 || pincode > 999999) return;

      context.read<EditPincodeBloc>().add(FetchPincode(pincode));
    });
  }

  void _editPincodeBlocListener(BuildContext context, EditPincodeState state) {
    if (state is EditPincodeError) {
      CustomNotifications.notifyError(context: context, message: state.message);
    } else if (state is EditPincodeLoaded) {
      widget.cityController.text = state.pincode.city;
      widget.stateController.text = state.pincode.state;
      widget.countryController.text = state.pincode.country;
    } else if (state is EditPincodeLoading) {
      widget.cityController.text = "";
      widget.stateController.text = "";
      widget.countryController.text = "";
    }
  }
}
