import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/profile/presentation/widgets/missing_strava_connection.dart';
import 'package:fitwiz/features/profile/presentation/widgets/profile_address_section.dart';
import 'package:fitwiz/features/profile/presentation/widgets/profile_details_section.dart';
import 'package:fitwiz/features/profile/presentation/widgets/strava_connected.dart';
import 'package:fitwiz/utils/components/bottom_gradient.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.containerBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.containerBgSecondary,
                  borderRadius: BorderRadius.circular(24.sp),
                ),
                child: Stack(
                  children: [
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return _buildLoading();
                        }
                        if (state is AuthLoggedIn) {
                          return _buildProfileContent(state.user);
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
              child: SizedBox(
                width: double.infinity,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(AuthLogout());
                      },
                      label: "Logout",
                      loading: state is AuthLoading,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
        style: TextStyle(
          color: AppColors.error,
          fontSize: 16.sp,
        ),
      ),
    );
  }

  Widget _buildProfileContent(User user) {
    bool stravaConnected = false;
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 16.sp,
        vertical: 24.sp,
      ),
      children: [
        Center(
          child: Text(
            "${user.salutation}. ${user.name}",
            style: AppTextStyles.DDD_25_700(),
          ),
        ),
        24.verticalSpacingRadius,
        stravaConnected
            ? const StravaConnected()
            : const MissingStravaConnection(),
        24.verticalSpacingRadius,
        _buildPersonalDetails(user),
        16.verticalSpacingRadius,
        const ProfileAddressSection(),
      ],
    );
  }

  Widget _buildPersonalDetails(User user) {
    return ProfileDetailsSection(
      title: 'Personal Details',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name:',
            style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
          ),
          Text(
            user.name,
            style: AppTextStyles.FFF_16_400(),
          ),
          16.verticalSpacingRadius,
          Text(
            'Email:',
            style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
          ),
          Text(
            user.email,
            style: AppTextStyles.FFF_16_400(),
          ),
          16.verticalSpacingRadius,
          Text(
            'Gender:',
            style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
          ),
          Text(
            user.gender,
            style: AppTextStyles.FFF_16_400(),
          ),
          16.verticalSpacingRadius,
          Text(
            'Date of Birth:',
            style: AppTextStyles.FFF_16_700(color: AppColors.textHeader),
          ),
          Text(
            DateFormat('dd MMMM yyyy').format(user.dateOfBirth),
            style: AppTextStyles.FFF_16_400(),
          ),
        ],
      ),
    );
  }
}
