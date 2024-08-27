import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/address/presentation/blocs/address/address_bloc.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/my_events/my_events_bloc.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';
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
  void initState() {
    super.initState();
    locator<EventsBloc>().add(FetchEvents());
    locator<MyEventsBloc>().add(FetchMyEvents());
    locator<AddressBloc>().add(FetchAddress());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _authBlocListener,
      child: BlocListener<EventsBloc, EventsState>(
        listener: _eventsBlocListener,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: _buildBody(),
              ),
              CustomNavBar(
                items: [
                  CustomNavBarItem(
                    icon: CustomIcon(
                      CustomIcons.home,
                      size: 19.2.sp,
                    ),
                    activeIcon: CustomIcon(
                      CustomIcons.home_filled,
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
            ],
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

  void _eventsBlocListener(BuildContext context, EventsState state) {
    if (state is EventsSuccess && !state.isLoading) {
      context.read<MyEventsBloc>().add(FetchMyEvents());
    }
  }
}
