import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_icon.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/components/password_field.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
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
        backgroundColor: AppColors.primaryColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          top: false,
          bottom: false,
          child: SizedBox(
            width: double.infinity,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: safeTopPadding(32.h)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                    ),
                    child: Center(
                      child: Hero(
                        tag: "app_logo",
                        child: CustomIcon(
                          CustomIcons.app_logo,
                          size: 50.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  12.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                    ),
                    child: Center(
                      child: Text(
                        "Sign in to your Account",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.DDD_25_600(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  8.verticalSpace,
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.sp,
                    ),
                    child: Center(
                      child: Text(
                        "Enter your email and password to sign in",
                        textAlign: TextAlign.center,
                        style: AppTextStyles.FFF_16_400(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  24.verticalSpace,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.greyShades[0],
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.sp),
                        ),
                      ),
                      child: ListView(
                        padding: EdgeInsets.only(
                          top: 32.h,
                          left: 24.w,
                          right: 24.w,
                          bottom: Get.mediaQuery.viewInsets.bottom,
                        ),
                        children: [
                          CustomTextField(
                            title: "Email",
                            controller: _emailController,
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
                          24.verticalSpace,
                          PasswordField(
                            title: "Password",
                            controller: _passwordController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password is required";
                              }
                              return null;
                            },
                          ),
                          // TODO: Implement Forgot Password. Backend support needed.
                          // 12.verticalSpace,
                          // Align(
                          //   alignment: Alignment.centerLeft,
                          //   child: MouseRegion(
                          //     cursor: SystemMouseCursors.click,
                          //     child: GestureDetector(
                          //       onTap: () {
                          //         Get.toNamed("/forgot-password");
                          //       },
                          //       child: Text(
                          //         "Forgot Password?",
                          //         style: AppTextStyles.FFF_16_500(
                          //           color: AppColors.primaryColor,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          24.verticalSpace,
                          SizedBox(
                            width: double.infinity,
                            child: BlocBuilder<AuthBloc, AuthState>(
                              builder: (context, state) {
                                return CustomButton(
                                  onPressed:
                                      state is AuthLoading ? null : _login,
                                  label: "Login",
                                  loading: state is AuthLoading,
                                );
                              },
                            ),
                          ),
                          24.verticalSpace,
                          Center(
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: AppTextStyles.FFF_16_400(
                                  color: AppColors.greenShades[12],
                                ),
                                children: [
                                  TextSpan(
                                    text: "Register Now",
                                    style: AppTextStyles.FFF_16_600(
                                      color: AppColors.primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed("/register");
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
