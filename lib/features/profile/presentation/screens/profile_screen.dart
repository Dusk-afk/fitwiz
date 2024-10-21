import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:fitwiz/features/address/presentation/screens/address_edit_screen.dart';
import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/custom_scaffold/data/models/custom_app_bar_params.dart';
import 'package:fitwiz/features/custom_scaffold/presentation/widgets/custom_scaffold.dart';
import 'package:fitwiz/features/profile/presentation/screens/profile_details_screen.dart';
import 'package:fitwiz/features/profile/presentation/widgets/profile_tile_button.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/misc/url_launcher_utils.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBarParams: const CustomAppBarParams(
        title: 'Profile',
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return _buildLoading();
          }
          if (state is AuthLoggedIn) {
            return _buildProfileContent(context, state.user);
          }
          String error = 'Unknown error occurred';
          if (state is AuthError) {
            error = state.message;
          } else if (state is AuthLoggedOut) {
            error = 'You are not logged in';
          }
          return _buildError(context, error);
        },
      ),
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator.adaptive(),
    );
  }

  Widget _buildError(BuildContext context, String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          error,
          style: TextStyle(
            color: AppColors.error,
            fontSize: 16.sp,
          ),
        ),
        16.verticalSpace,
        CustomButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogout());
          },
          label: 'Logout',
        ),
      ],
    );
  }

  Widget _buildProfileContent(BuildContext context, User user) {
    // bool stravaConnected = false;
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
      ),
      children: [
        32.verticalSpace,
        Container(
          height: 96.h,
          padding: EdgeInsets.symmetric(
            vertical: 16.h,
            horizontal: 16.w,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryShades[4],
                  ),
                  child: Center(
                    child: Text(
                      user.name[0],
                      style: AppTextStyles.EEE_20_600(
                        color: AppColors.greyShades[12],
                      ),
                    ),
                  ),
                ),
              ),
              16.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: AppTextStyles.EEE_20_600(
                        color: AppColors.greyShades[12],
                      ),
                    ),
                    Text(
                      user.email,
                      style: AppTextStyles.FFF_16_400(
                        color: AppColors.greyShades[10],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        24.verticalSpace,
        Text(
          "Account",
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[12],
          ),
        ),
        8.verticalSpace,
        ProfileTileButton(
          onPressed: () {
            Get.to(() => const ProfileDetailsScreen());
          },
          icon: CustomIcon(
            CustomIcons.profile,
            size: 21.sp,
          ),
          label: "Details",
          actionType: ProfileTileActionType.navigate,
          isFirst: true,
        ),
        2.verticalSpace,
        ProfileTileButton(
          onPressed: () {
            AddressState state = context.read<AddressBloc>().state;
            if (state is AddressError) {
              CustomNotifications.notifyError(
                  context: context, message: state.message);
            } else {
              Get.to(() => const AddressEditScreen());
            }
          },
          icon: CustomIcon(
            CustomIcons.location,
            size: 20.sp,
          ),
          label: "Edit Address",
          actionType: ProfileTileActionType.navigate,
        ),
        2.verticalSpace,
        // TODO: Implement change password. Backend support needed.
        // ProfileTileButton(
        //   icon: CustomIcon(
        //     CustomIcons.password_key,
        //     size: 18.sp,
        //   ),
        //   label: "Change Password",
        //   actionType: ProfileTileActionType.navigate,
        // ),
        // 2.verticalSpace,
        ProfileTileButton(
          onPressed: () {
            context.read<AuthBloc>().add(AuthLogout());
          },
          icon: CustomIcon(
            CustomIcons.logout,
            size: 16.sp,
          ),
          label: "Logout",
          isLast: true,
        ),
        24.verticalSpace,
        Text(
          "Fitwiz",
          style: AppTextStyles.FFF_16_600(
            color: AppColors.greyShades[12],
          ),
        ),
        8.verticalSpace,
        // TODO: Implement check for updates.
        // ProfileTileButton(
        //   icon: CustomIcon(
        //     CustomIcons.refresh,
        //     size: 16.sp,
        //   ),
        //   label: "Check For Updates",
        //   isFirst: true,
        // ),
        // 2.verticalSpace,
        ProfileTileButton(
          onPressed: () {
            UrlLauncherUtils.launchURL('https://fit-wiz.com');
          },
          icon: CustomIcon(
            CustomIcons.app_logo,
            size: 20.sp,
          ),
          label: "Open Website",
          actionType: ProfileTileActionType.external,
          isFirst: true,
          isLast: true,
        ),
        // TODO: Implement about Fitwiz.
        // 2.verticalSpace,
        // ProfileTileButton(
        //   icon: CustomIcon(
        //     CustomIcons.info,
        //     size: 16.sp,
        //   ),
        //   label: "About Fitwiz",
        //   actionType: ProfileTileActionType.navigate,
        //   isLast: true,
        // ),
        24.verticalSpace,
      ],
    );
  }
}
