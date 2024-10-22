import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:fitwiz/features/address/data/models/tower_short.dart';
import 'package:fitwiz/features/address/data/repositories/address_repository.dart';
import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_address/edit_address_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_pincode/edit_pincode_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_society/edit_society_bloc.dart';
import 'package:fitwiz/features/address/presentation/blocs/edit_tower/edit_tower_bloc.dart';
import 'package:fitwiz/features/address/presentation/widgets/pincode_edit_section.dart';
import 'package:fitwiz/features/address/presentation/widgets/tower_edit_section.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_scaffold_action.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/utils/components/custom_bottom_sheet.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddressEditScreen extends StatefulWidget {
  const AddressEditScreen({super.key});

  @override
  State<AddressEditScreen> createState() => _AddressEditScreenState();
}

class _AddressEditScreenState extends State<AddressEditScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _loading = true;

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
    AddressState addressState = context.read<AddressBloc>().state;
    if (addressState is AddressLoaded) {
      _loading = false;
      _initValues(addressState.address);
    }
  }

  void _initValues(Address? address) {
    if (address != null) {
      _nameController.text = address.name;
      _pincodeController.text = address.pincode.pincode.toString();
      _cityController.text = address.pincode.city;
      _stateController.text = address.pincode.state;
      _countryController.text = address.pincode.country;
      _line1Controller.text = address.line1;
      _line2Controller.text = address.line2 ?? "";
      _landmarkController.text = address.landmark ?? "";
      _mobileController.text = address.mobile;
      _society = address.tower?.society;
      _tower =
          address.tower != null ? TowerShort.fromTower(address.tower!) : null;

      if (_society != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _editTowerBloc.add(FetchTowers(_society!));
        });
      }
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
        child: BlocListener<AddressBloc, AddressState>(
          listener: _addressBlocListener,
          child: BlocBuilder<EditAddressBloc, EditAddressState>(
            builder: (context, state) {
              bool isSaving = state is EditAddressLoading;

              return PopScope(
                canPop: !isSaving,
                child: CustomScaffold(
                  appBarParams: const CustomAppBarParams(
                    title: "Edit Address",
                    previousTitle: "Profile",
                  ),
                  action: _loading
                      ? null
                      : CustomScaffoldAction(
                          onPressed:
                              isSaving ? null : () => _onSavePressed(context),
                          label: "Save",
                          loading: isSaving,
                        ),
                  child: SizedBox(
                    width: double.infinity,
                    child: _buildContent(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }

    return Form(
      key: _formKey,
      child: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.sp,
        ),
        children: [
          32.verticalSpace,
          Text(
            "Name",
            style: AppTextStyles.FFF_16_600(
              color: AppColors.greyShades[11],
            ),
          ),
          4.verticalSpace,
          CustomTextField(
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),
          24.verticalSpace,
          PincodeEditSection(
            pincodeController: _pincodeController,
            cityController: _cityController,
            stateController: _stateController,
            countryController: _countryController,
          ),
          24.verticalSpace,
          Text(
            "Address Line 1",
            style: AppTextStyles.FFF_16_600(
              color: AppColors.greyShades[11],
            ),
          ),
          4.verticalSpace,
          CustomTextField(
            controller: _line1Controller,
            validator: (value) {
              if (value!.isEmpty) {
                return "Address line 1 is required";
              }
              return null;
            },
          ),
          24.verticalSpace,
          Text(
            "Address Line 2",
            style: AppTextStyles.FFF_16_600(
              color: AppColors.greyShades[11],
            ),
          ),
          4.verticalSpace,
          CustomTextField(
            controller: _line2Controller,
            placeholder: "Optional",
          ),
          24.verticalSpace,
          Text(
            "Landmark",
            style: AppTextStyles.FFF_16_600(
              color: AppColors.greyShades[11],
            ),
          ),
          4.verticalSpace,
          CustomTextField(
            controller: _landmarkController,
            placeholder: "Optional",
          ),
          24.verticalSpace,
          Text(
            "Mobile",
            style: AppTextStyles.FFF_16_600(
              color: AppColors.greyShades[11],
            ),
          ),
          4.verticalSpace,
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
          24.verticalSpace,
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
          24.verticalSpace,
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

      AddressState addressState = context.read<AddressBloc>().state;
      if (addressState is AddressLoaded) {
        // Check if the address is the same as the current address
        if (addressState.address == address) {
          Get.back();
          return;
        }
      }

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
      // Update the address in the address bloc
      context.read<AddressBloc>().add(UpdateAddess(state.address));

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

  void _addressBlocListener(BuildContext context, AddressState state) {
    if (state is AddressLoaded) {
      _loading = false;
      _initValues(state.address);
      setState(() {});
    } else if (state is AddressError) {
      Get.back();
      CustomNotifications.notifyError(
        context: context,
        message: state.message,
      );
    }
  }
}
