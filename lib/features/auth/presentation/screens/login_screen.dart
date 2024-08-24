import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/widget_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: _authBlocListener,
      child: Scaffold(
        backgroundColor: AppColors.containerBgSecondary,
        body: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.sp,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  32.verticalSpacingRadius,
                  Center(
                    child: Text(
                      "Welcome back",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.CCC_31_700(),
                    ),
                  ),
                  40.verticalSpacingRadius,
                  Text(
                    "Email",
                    textAlign: TextAlign.start,
                    style:
                        AppTextStyles.FFF_16_400(color: AppColors.textHeader),
                  ),
                  8.verticalSpacingRadius,
                  CustomTextField(
                    controller: _emailController,
                    normalBorderColor: AppColors.textLightest,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      }
                      if (!value.isEmail) {
                        return "Invalid email";
                      }
                      return null;
                    },
                  ),
                  16.verticalSpacingRadius,
                  Text(
                    "Password",
                    textAlign: TextAlign.start,
                    style:
                        AppTextStyles.FFF_16_400(color: AppColors.textHeader),
                  ),
                  8.verticalSpacingRadius,
                  CustomTextField(
                    controller: _passwordController,
                    normalBorderColor: AppColors.textLightest,
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                  ),
                  24.verticalSpacingRadius,
                  const Divider(color: AppColors.textLightest),
                  24.verticalSpacingRadius,
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: AppTextStyles.FFF_16_400(),
                        children: [
                          TextSpan(
                            text: "Register",
                            style: AppTextStyles.FFF_16_700(
                              color: AppColors.primaryColor,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAndToNamed("/register");
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return CustomButton(
                              onPressed: _login,
                              label: "Login",
                              loading: state is AuthLoading,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: safeBottomPadding(16.sp),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _authBlocListener(BuildContext context, AuthState state) {
    if (state is AuthLoggedIn) {
      Get.offAndToNamed("/main");
    } else if (state is AuthError) {
      CustomNotifications.notifyError(
        context: context,
        message: state.message,
      );
    }
  }

  void _login() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(
          AuthLogin(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }
}
