import 'package:fitwiz/features/auth/data/models/register_user_data.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/auth/presentation/widgets/dob_selector.dart';
import 'package:fitwiz/utils/components/custom_button.dart';
import 'package:fitwiz/utils/components/custom_dropdown.dart';
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

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _selectedSalutation;
  String? _selectedGender;
  DateTime? _selectedDob;

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
        backgroundColor: AppColors.containerBg,
        body: SafeArea(
          bottom: false,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.containerBgSecondary,
                      borderRadius: BorderRadius.circular(24.sp),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.sp,
                      ),
                      children: [
                        32.verticalSpacingRadius,
                        Center(
                          child: Text(
                            "Let's get started",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.CCC_31_700(),
                          ),
                        ),
                        40.verticalSpacingRadius,
                        Text(
                          "Salutation",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.FFF_16_400(
                              color: AppColors.textHeader),
                        ),
                        8.verticalSpacingRadius,
                        CustomDropdown<String>(
                          width: 80.sp,
                          items: ["Mr", "Mrs", "Miss"]
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedSalutation = value;
                            });
                          },
                          normalBorderColor: AppColors.textLightest,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Salutation is required";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpacingRadius,
                        Text(
                          "Name",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.FFF_16_400(
                              color: AppColors.textHeader),
                        ),
                        8.verticalSpacingRadius,
                        CustomTextField(
                          controller: _nameController,
                          normalBorderColor: AppColors.textLightest,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Name is required";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpacingRadius,
                        Text(
                          "Gender",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.FFF_16_400(
                              color: AppColors.textHeader),
                        ),
                        8.verticalSpacingRadius,
                        CustomDropdown<String>(
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
                          normalBorderColor: AppColors.textLightest,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Gender is required";
                            }
                            return null;
                          },
                        ),
                        16.verticalSpacingRadius,
                        Text(
                          "Date of Birth",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.FFF_16_400(
                              color: AppColors.textHeader),
                        ),
                        8.verticalSpacingRadius,
                        DobSelector(
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
                        16.verticalSpacingRadius,
                        Text(
                          "Email",
                          textAlign: TextAlign.start,
                          style: AppTextStyles.FFF_16_400(
                              color: AppColors.textHeader),
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
                          style: AppTextStyles.FFF_16_400(
                              color: AppColors.textHeader),
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
                              text: "Already have an account? ",
                              style: AppTextStyles.FFF_16_400(),
                              children: [
                                TextSpan(
                                  text: "Login",
                                  style: AppTextStyles.FFF_16_700(
                                    color: AppColors.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.offAndToNamed("/login");
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        24.verticalSpacingRadius,
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
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return SizedBox(
                        width: double.infinity,
                        child: CustomButton(
                          onPressed: _register,
                          label: "Register",
                          loading: state is AuthLoading,
                        ),
                      );
                    },
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
      Get.offAndToNamed("/main");
    } else if (state is AuthError) {
      CustomNotifications.notifyError(
        context: context,
        message: state.message,
      );
    }
  }

  void _register() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(AuthRegister(
          data: RegisterUserData(
            salutation: _selectedSalutation!,
            name: _nameController.text,
            gender: _selectedGender!,
            dateOfBirth: _selectedDob!,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ));
  }
}
