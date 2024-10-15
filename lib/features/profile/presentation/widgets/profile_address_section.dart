import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:fitwiz/features/address/presentation/screens/address_edit_screen.dart';
import 'package:fitwiz/features/profile/presentation/widgets/profile_details_section.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileAddressSection extends StatelessWidget {
  const ProfileAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressBloc, AddressState>(
      builder: (context, state) {
        Widget child;
        bool showEdit = false;

        if (state is AddressLoading) {
          child = _buildLoading();
        } else if (state is AddressLoaded) {
          child = _buildContent(state.address);
          showEdit = true;
        } else {
          String error = 'Unknown error occurred';
          if (state is AddressError) {
            error = state.message;
          }
          child = _buildError(error);
        }

        return ProfileDetailsSection(
          title: 'Address',
          onEdit: showEdit
              ? () => _onEditPressed(context, (state as AddressLoaded).address)
              : null,
          child: child,
        );
      },
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildContent(Address? address) {
    if (address == null) {
      return Text(
        'No address',
        style: AppTextStyles.FFF_16_400(),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          address.name,
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'Mobile:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          address.mobile,
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'Address:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          '${address.line1}\n${address.line2 ?? ''}'.trim(),
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'Landmark:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          address.landmark ?? 'No landmark',
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'Pincode:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          address.pincode.pincode.toString(),
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'City:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          address.pincode.city,
          style: AppTextStyles.FFF_16_400(),
        ),
        16.verticalSpacingRadius,
        Text(
          'State:',
          style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
        ),
        Text(
          address.pincode.state,
          style: AppTextStyles.FFF_16_400(),
        ),
        if (address.tower != null) ...[
          16.verticalSpacingRadius,
          Text(
            'Society:',
            style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
          ),
          Text(
            address.tower!.society.name,
            style: AppTextStyles.FFF_16_400(),
          ),
          16.verticalSpacingRadius,
          Text(
            'Tower:',
            style: AppTextStyles.FFF_16_600(color: AppColors.textHeader),
          ),
          Text(
            address.tower!.name,
            style: AppTextStyles.FFF_16_400(),
          ),
        ],
      ],
    );
  }

  Future<void> _onEditPressed(BuildContext context, Address? address) async {
    AddressBloc addressBloc = context.read<AddressBloc>();

    Address? updatedAddress =
        await Get.to<Address>(() => AddressEditScreen(address: address));

    if (updatedAddress != null) {
      // Better to rely on the bloc to fetch the address again
      addressBloc.add(FetchAddress());
    }
  }
}
