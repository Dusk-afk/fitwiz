import 'package:fitwiz/data/string_constants.dart';
import 'package:fitwiz/features/auth/data/models/register_user_data.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/auth/presentation/widgets/dob_selector.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_dropdown.dart';
import 'package:fitwiz/utils/components/custom_notifications.dart';
import 'package:fitwiz/utils/components/custom_text_field.dart';
import 'package:fitwiz/utils/components/password_field.dart';
import 'package:fitwiz/utils/misc/url_launcher_utils.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';
import 'package:fitwiz/utils/theme/app_text_styles.dart';
import 'package:fitwiz/utils/misc/widget_utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedGender;
  DateTime? _selectedDob;
  bool _termsAccepted = false;

  bool _termsError = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
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
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          top: false,
          bottom: false,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: safeTopPadding(24.h),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: Get.back,
                          style: ButtonStyle(
                            minimumSize: WidgetStateProperty.all(Size.zero),
                            padding: WidgetStateProperty.all(EdgeInsets.zero),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            overlayColor: WidgetStateProperty.all(
                                AppColors.containerBg.withOpacity(0.05)),
                          ),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 24.sp,
                          ),
                        ),
                        12.verticalSpace,
                        Text(
                          "Register",
                          style: AppTextStyles.DDD_25_600(color: Colors.white),
                        ),
                        8.verticalSpace,
                        Text(
                          "Enter your details to register",
                          style: AppTextStyles.FFF_16_400(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.primaryShades[0],
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.sp),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                      ),
                      children: [
                        32.verticalSpace,
                        CustomTextField(
                          title: "Full Name",
                          controller: _nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        24.verticalSpace,
                        CustomDropdown<String>(
                          title: "Gender",
                          items: ["Male", "Female", "Other"]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          value: _selectedGender,
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Gender is required";
                            }
                            return null;
                          },
                        ),
                        24.verticalSpace,
                        DobSelector(
                          title: "Date of Birth",
                          validator: (value) {
                            if (value == null) {
                              return "Date of birth is required";
                            }
                            if (value.isAfter(DateTime.now())) {
                              return "Invalid date of birth";
                            }
                            if (value.isAfter(DateTime(DateTime.now().year - 18,
                                value.month, value.day))) {
                              return "You must be at least 18 years old";
                            }
                            return null;
                          },
                          initialDate: _selectedDob,
                          onDateSelected: (value) {
                            setState(() {
                              _selectedDob = value;
                            });
                          },
                        ),
                        24.verticalSpace,
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
                        24.verticalSpace,
                        Row(
                          children: [
                            Checkbox.adaptive(
                              isError: _termsError,
                              value: _termsAccepted,
                              onChanged: (value) {
                                setState(() {
                                  _termsAccepted = value!;
                                  _termsError = false;
                                });
                              },
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  text: "I accept the ",
                                  style: AppTextStyles.FFF_16_400(),
                                  children: [
                                    TextSpan(
                                      text: "Privacy Policy",
                                      style: AppTextStyles.FFF_16_600(
                                        color: AppColors.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          UrlLauncherUtils.launchURL(
                                              '${StringConstants.BASE_URL}/privacy-policy');
                                        },
                                    ),
                                    TextSpan(
                                      text: " and ",
                                      style: AppTextStyles.FFF_16_400(),
                                    ),
                                    TextSpan(
                                      text: "Terms and Conditions",
                                      style: AppTextStyles.FFF_16_600(
                                        color: AppColors.primaryColor,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          UrlLauncherUtils.launchURL(
                                              '${StringConstants.BASE_URL}/terms-and-conditions');
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        24.verticalSpace,
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: double.infinity,
                              child: CustomButton(
                                onPressed:
                                    state is AuthLoading ? null : _register,
                                label: "Register",
                                loading: state is AuthLoading,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: safeBottomPadding(24.h)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _authBlocListener(BuildContext context, AuthState state) {
    if (state is AuthLoggedIn) {
      Get.offNamedUntil("/main", (route) => false);
    } else if (state is AuthError) {
      CustomNotifications.notifyError(
        context: context,
        message: state.message,
      );
    }
  }

  void _register() {
    bool canContinue = true;
    if (!_termsAccepted) {
      setState(() {
        _termsError = true;
      });
      canContinue = false;
    }

    if (!_formKey.currentState!.validate()) {
      canContinue = false;
    }
    if (!canContinue) return;

    context.read<AuthBloc>().add(AuthRegister(
          data: RegisterUserData(
            salutation: "Mr",
            name: _nameController.text,
            gender: _selectedGender!,
            dateOfBirth: _selectedDob!,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ));
  }
}
