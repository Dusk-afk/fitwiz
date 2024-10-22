import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarParams: const CustomAppBarParams(
        title: 'Details',
        previousTitle: 'Profile',
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return _buildLoading();
          }
          if (state is AuthLoggedIn) {
            return _buildContent(state.user);
          }
          String error = 'Unknown error occurred';
          if (state is AuthError) {
            error = state.message;
          } else if (state is AuthLoggedOut) {
            error = 'You are not logged in';
          }
          return _buildError(error);
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Text(
        error,
        style: const TextStyle(color: Colors.red),
      ),
    );
  }

  Widget _buildContent(User user) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.sp,
      ),
      children: [
        32.verticalSpace,
        _buildTile("Name", user.name),
        24.verticalSpace,
        _buildTile("Gender", user.gender),
        24.verticalSpace,
        _buildTile("Email", user.email),
        24.verticalSpace,
        _buildTile(
          "Date of Birth",
          DateFormat("d MMM, yyyy").format(user.dateOfBirth),
        ),
        32.verticalSpace,
      ],
    );
  }

  Widget _buildTile(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[11],
          ),
        ),
        4.verticalSpace,
        CustomTextField(
          initialValue: value,
          disabled: true,
          normalFillColor: AppColors.white,
        ),
      ],
    );
  }
}
