import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:fitwiz/features/address/data/models/tower_short.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_address/edit_address_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_pincode/edit_pincode_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_society/edit_society_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_tower/edit_tower_bloc.dart';
import 'package:fitwiz/features/address/presentation/widgets/pincode_edit_section.dart';
import 'package:fitwiz/features/address/presentation/widgets/tower_edit_section.dart';
import 'package:fitwiz/utils/components/bottom_gradient.dart';
import 'package:fitwiz/utils/components/custom_back_button.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddressEditScreen extends StatefulWidget {
  final Address? address;

  const AddressEditScreen({super.key, this.address});

  @override
  State<AddressEditScreen> createState() => _AddressEditScreenState();
}

class _AddressEditScreenState extends State<AddressEditScreen> {
  bool get _editMode => widget.address != null;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();
  final _line1Controller = TextEditingController();
  final _line2Controller = TextEditingController();
  final _landmarkController = TextEditingController();
  final _mobileController = TextEditingController();
  Society? _society;
  TowerShort? _tower;
  final EditTowerBloc _editTowerBloc =
      EditTowerBloc(locator<AddressRepository>());

  @override
  void initState() {
    super.initState();
    _initValues();
  }

  void _initValues() {
    if (_editMode) {
      _nameController.text = widget.address!.name;
      _pincodeController.text = widget.address!.pincode.pincode.toString();
      _cityController.text = widget.address!.pincode.city;
      _stateController.text = widget.address!.pincode.state;
      _countryController.text = widget.address!.pincode.country;
      _line1Controller.text = widget.address!.line1;
      _line2Controller.text = widget.address!.line2 ?? "";
      _landmarkController.text = widget.address!.landmark ?? "";
      _mobileController.text = widget.address!.mobile;
      _society = widget.address!.tower?.society;
      _tower = widget.address!.tower != null
          ? TowerShort.fromTower(widget.address!.tower!)
          : null;

      if (_society != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _editTowerBloc.add(FetchTowers(_society!));
        });
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => EditAddressBloc(locator<AddressRepository>()),
        ),
        BlocProvider(
          create: (_) => EditPincodeBloc(locator<AddressRepository>()),
        ),
        BlocProvider(
          create: (_) => EditSocietyBloc(locator<AddressRepository>())
            ..add(FetchSocieties()),
        ),
        BlocProvider(
          create: (_) => _editTowerBloc,
        ),
      ],
      child: BlocListener<EditAddressBloc, EditAddressState>(
        listener: _editAddressBlocListener,
        child: BlocBuilder<EditAddressBloc, EditAddressState>(
          builder: (context, state) {
            bool isSaving = state is EditAddressLoading;

            return PopScope(
              canPop: !isSaving,
              child: Scaffold(
                backgroundColor: AppColors.containerBg,
                body: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.sp),
                            color: AppColors.containerBgSecondary,
                          ),
                          child: Stack(
                            children: [
                              _buildContent(),
                              const Positioned.fill(
                                top: null,
                                child: BottomGradient(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 16.sp,
                          left: 16.sp,
                          right: 16.sp,
                          bottom: safeBottomPadding(16.sp),
                        ),
                        child: Builder(
                          builder: (context) {
                            return Row(
                              children: rowGap(
                                8.sp,
                                [
                                  CustomBackButton(
                                    onPressed: isSaving ? null : Get.back,
                                  ),
                                  Expanded(
                                    child: CustomButton(
                                      onPressed: () => _onSavePressed(context),
                                      label: "Save",
                                      padding: EdgeInsets.zero,
                                      loading: isSaving,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          24.verticalSpacingRadius,
          Center(
            child: Text(
              "${_editMode ? "Edit" : "Create"} Address",
              style: AppTextStyles.DDD_25_600(),
            ),
          ),
          32.verticalSpacingRadius,
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              children: [
                Text(
                  "Name",
                  style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
                ),
                8.verticalSpacingRadius,
                CustomTextField(
                  controller: _nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name is required";
                    }
                    return null;
                  },
                ),
                16.verticalSpacingRadius,
                PincodeEditSection(
                  pincodeController: _pincodeController,
                  cityController: _cityController,
                  stateController: _stateController,
                  countryController: _countryController,
                ),
                16.verticalSpacingRadius,
                Text(
                  "Address Line 1",
                  style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
                ),
                8.verticalSpacingRadius,
                CustomTextField(
                  controller: _line1Controller,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Address line 1 is required";
                    }
                    return null;
                  },
                ),
                16.verticalSpacingRadius,
                Text(
                  "Address Line 2",
                  style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
                ),
                8.verticalSpacingRadius,
                CustomTextField(
                  controller: _line2Controller,
                  placeholder: "Optional",
                ),
                16.verticalSpacingRadius,
                Text(
                  "Landmark",
                  style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
                ),
                8.verticalSpacingRadius,
                CustomTextField(
                  controller: _landmarkController,
                  placeholder: "Optional",
                ),
                16.verticalSpacingRadius,
                Text(
                  "Mobile",
                  style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
                ),
                8.verticalSpacingRadius,
                CustomTextField(
                  controller: _mobileController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Mobile is required";
                    }
                    if (value.length != 10) {
                      return "Invalid mobile number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
                16.verticalSpacingRadius,
                TowerEditSection(
                  society: _society,
                  tower: _tower,
                  onSocietyChanged: (society) {
                    _society = society;
                    _tower = null;
                    setState(() {});
                  },
                  onTowerChanged: (tower) {
                    _tower = tower;
                    setState(() {});
                  },
                ),
                24.verticalSpacingRadius,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onSavePressed(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final address = Address(
        name: _nameController.text,
        pincode: Pincode(
          pincode: int.parse(_pincodeController.text),
          city: _cityController.text,
          state: _stateController.text,
          country: _countryController.text,
        ),
        line1: _line1Controller.text,
        line2: _line2Controller.text,
        landmark: _landmarkController.text,
        mobile: _mobileController.text,
        tower: Tower(id: _tower!.id, society: _society!, name: _tower!.name),
      );
      context.read<EditAddressBloc>().add(UpdateAddress(address));
    } catch (e, st) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: st);
      CustomNotifications.notifyError(
        context: context,
        message: "Failed to save address",
      );
    }
  }

  void _editAddressBlocListener(BuildContext context, EditAddressState state) {
    if (state is EditAddressLoading) {
      CustomBottomSheet.showSimpleLoadingSheet(message: "Saving address");
    } else if (state is EditAddressUpdated) {
      // Close the bottom sheet
      Get.back();
      CustomNotifications.notifySuccess(
        context: context,
        message: "Address updated successfully",
      );
      Get.back(result: state.address);
    } else if (state is EditAddressError) {
      // Close the bottom sheet
      Get.back();
      CustomNotifications.notifyError(context: context, message: state.message);
    }
  }
}
