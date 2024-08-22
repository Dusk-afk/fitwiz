import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/home/presentation/screens/home_screen.dart';
import 'package:fitwiz/features/profile/presentation/screens/profile_screen.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_nav_bar.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/models/custom_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => EventsBloc()..add(FetchEvents())),
      ],
      child: BlocListener<AuthBloc, AuthState>(
        listener: _authBlocListener,
        child: Scaffold(
          body: _buildBody(),
          bottomNavigationBar: CustomNavBar(
            items: [
              CustomNavBarItem(
                icon: CustomIcon(
                  CustomIcons.compass,
                  size: 19.2.sp,
                ),
                activeIcon: CustomIcon(
                  CustomIcons.compass_filled,
                  size: 19.2.sp,
                ),
                label: 'Home',
              ),
              CustomNavBarItem(
                icon: CustomIcon(
                  CustomIcons.profile,
                  size: 19.2.sp,
                ),
                activeIcon: CustomIcon(
                  CustomIcons.profile_filled,
                  size: 19.2.sp,
                ),
                label: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onItemSelected: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const ProfileScreen();
      default:
        return Container();
    }
  }

  void _authBlocListener(BuildContext context, AuthState state) {
    if (state is AuthLoggedOut) {
      Get.offAndToNamed("/login");
    } else if (state is AuthError) {
      CustomNotifications.notifyError(
        context: context,
        message: state.message,
      );
    }
  }
}
