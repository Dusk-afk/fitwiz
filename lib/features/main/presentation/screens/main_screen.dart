import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _authBlocListener,
      child: Scaffold(
        body: Center(
          child: CustomButton(
            onPressed: () {
              context.read<AuthBloc>().add(AuthLogout());
            },
            label: "Logout",
          ),
        ),
      ),
    );
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
