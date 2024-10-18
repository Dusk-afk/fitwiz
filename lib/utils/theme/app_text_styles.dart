// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fitwiz/utils/theme/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle CCC_31_700({Color? color}) => GoogleFonts.poppins(
        fontSize: 31.25.sp,
        fontWeight: FontWeight.w700,
        color: color ?? AppColors.textHeader,
        height: 40 / 31.25,
      );

  static TextStyle CCC_31_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 31.25.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 40 / 31.25,
      );

  static TextStyle DDD_25_600({Color? color}) => GoogleFonts.poppins(
        fontSize: 25.sp,
        fontWeight: FontWeight.w600,
        height: (32.5 / 25),
        color: color ?? AppColors.textHeader,
      );

  static TextStyle DDD_25_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 25.sp,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textHeader,
        height: 32.5 / 25,
      );

  static TextStyle EEE_20_600({Color? color}) => GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 31.6 / 20,
      );

  static TextStyle EEE_20_500({Color? color}) => GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 31.6 / 20,
      );

  static TextStyle EEE_20_400({Color? color, double? height}) =>
      GoogleFonts.poppins(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textHeader,
        height: height ?? (31.6 / 20),
      );

  static TextStyle FFF_16_600({Color? color, double? height}) =>
      GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: height ?? (24.32 / 16),
      );

  static TextStyle FFF_16_500({Color? color}) => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.textParagraph,
        height: 24.32 / 16,
      );

  static TextStyle FFF_16_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 24.32 / 16,
      );

  static TextStyle FFF_16_300({Color? color}) => GoogleFonts.poppins(
        fontSize: 16.sp,
        fontWeight: FontWeight.w300,
        color: color ?? AppColors.textParagraph,
        height: 24.32 / 16,
      );

  static TextStyle FFF_18_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: color ?? AppColors.textParagraph,
        height: 23.76 / 18,
      );

  static TextStyle FFF_10_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle FFF_14_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: color,
      );

  static TextStyle GGG_12_700({Color? color}) => GoogleFonts.poppins(
        fontSize: 12.8.sp,
        fontWeight: FontWeight.w700,
        color: color,
        height: 16.26 / 12,
      );

  static TextStyle GGG_12_400({Color? color, FontStyle? fontStyle}) =>
      GoogleFonts.poppins(
        fontSize: 12.8.sp,
        fontWeight: FontWeight.w400,
        fontStyle: fontStyle,
        color: color,
        height: 16.26 / 12,
      );

  static TextStyle HHH_10_700({Color? color}) => GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w700,
        color: color,
        height: 16.26 / 12,
      );

  static TextStyle HHH_10_400({Color? color}) => GoogleFonts.poppins(
        fontSize: 10.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 15.56 / 10,
      );
}
