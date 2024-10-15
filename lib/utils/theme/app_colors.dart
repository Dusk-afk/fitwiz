import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const List<Color> primaryShades = [
    Colors.white,

    // Backgrounds
    Color(0xFFFBFDFF), // 1
    Color(0xFFF5F9FF), // 2

    // Interactive Components
    Color(0xFFE9F3FF), // 3
    Color(0xFFD9EBFF), // 4
    Color(0xFFC7E1FF), // 5

    // Borders and separators
    Color(0xFFB2D4FF), // 6
    Color(0xFF97C2FF), // 7
    Color(0xFF70A8FF), // 8

    // Solid colors
    Color(0xFF006EFF), // 9
    Color(0xFF0060EE), // 10

    // Accessible text
    Color(0xFF0063F2), // 11
    Color(0xFF062F6D), // 12
  ];

  static const List<Color> greyShades = [
    Colors.white,

    // Backgrounds
    Color(0xFFFBFCFD), // 1
    Color(0xFFF8F9FA), // 2

    // Interactive Components
    Color(0xFFEEF1F2), // 3
    Color(0xFFE5E9EA), // 4
    Color(0xFFDDE2E4), // 5

    // Borders and separators
    Color(0xFFD5DADD), // 6
    Color(0xFFC9D0D3), // 7
    Color(0xFFB4BDC1), // 8

    // Solid colors
    Color(0xFF868F93), // 9
    Color(0xFF7C8588), // 10

    // Accessible text
    Color(0xFF5E6568), // 11
    Color(0xFF1C2022), // 12
  ];

  static const List<Color> redShades = [
    Colors.white,

    // Backgrounds
    Color(0xFFFFFCFC), // 1
    Color(0xFFFFF8F6), // 2

    // Interactive Components
    Color(0xFFFFEBE8), // 3
    Color(0xFFFFDBD5), // 4
    Color(0xFFFFCCC4), // 5

    // Borders and separators
    Color(0xFFFFBCB2), // 6
    Color(0xFFF9A79D), // 7
    Color(0xFFF08C80), // 8

    // Solid colors
    Color(0xFFD82222), // 9
    Color(0xFFC8000F), // 10

    // Accessible text
    Color(0xFFD51E1F), // 11
    Color(0xFF651A16), // 12
  ];

  static const List<Color> greenShades = [
    Colors.white,

    // Backgrounds
    Color(0xFFFBFEFA), // 1
    Color(0xFFF5FBF3), // 2

    // Interactive Components
    Color(0xFFE1FBD8), // 3
    Color(0xFFCEF7BF), // 4
    Color(0xFFBAEFA8), // 5

    // Borders and separators
    Color(0xFFA6E390), // 6
    Color(0xFF8DD274), // 7
    Color(0xFF68BE44), // 8

    // Solid colors
    Color(0xFF65E11A), // 9
    Color(0xFF59D600), // 10

    // Accessible text
    Color(0xFF3C821A), // 11
    Color(0xFF26431A), // 12
  ];

  static const List<Color> orangeShades = [
    Colors.white,

    // Backgrounds
    Color(0xFFFEFDFB), // 1
    Color(0xFFFFFAEA), // 2

    // Interactive Components
    Color(0xFFFFF3C2), // 3
    Color(0xFFFFEAA0), // 4
    Color(0xFFFFDF7E), // 5

    // Borders and separators
    Color(0xFFF9D37A), // 6
    Color(0xFFE6C36D), // 7
    Color(0xFFD4AB43), // 8

    // Solid colors
    Color(0xFFFFCC2C), // 9
    Color(0xFFF6C335), // 10

    // Accessible text
    Color(0xFF987100), // 11
    Color(0xFF453A20), // 12
  ];

  static Color get primaryColor => primaryShades[9];

  static const Color primaryDarkColor = Color(0xFF4E1799);
  static const Color transparentPrimaryColor = Color.fromRGBO(223, 210, 242, 1);
  static const Color textHeader = Color(0xFF191925);
  static const Color textParagraph = Color(0xFF65637F);
  static const Color textDarker = Color(0xFF423F60);
  static const Color textLight = Color(0xFF89879E);
  static const Color textLight2 = Color(0xFFACAABE);
  static const Color textLighter = Color(0xFFD0CEDD);
  static const Color textLightest = Color(0xFFE1E0EC);
  static const Color textLightestest = Color(0xFFF0F0F7);
  static const Color fadeColor = Color.fromRGBO(232, 232, 233, 1);
  static const Color whiteColor = Colors.white;
  static const Color shadowColor = Color.fromRGBO(208, 206, 221, 0.6);
  static const Color backgroundColor = Color.fromRGBO(244, 244, 249, 1);
  static const Color iconLightColor = Color.fromRGBO(101, 99, 127, 1);
  static const Color hintColor = Color.fromRGBO(172, 170, 190, 1);
  static const Color progressBarDoneColor = Color.fromRGBO(66, 63, 96, 1);
  static const Color progressBarRemainingColor = Colors.white;
  static const Color blackColor = Color.fromRGBO(25, 25, 37, 1);
  static const Color borderColor = Color.fromRGBO(240, 240, 247, 1);
  static const Color textLightColor = Color.fromRGBO(137, 135, 158, 1);
  static const Color bgLightColor = Color.fromRGBO(208, 206, 221, 1);
  static const Color ringColor = Color.fromRGBO(128, 217, 74, 1);

  // -------- OTHER COLORS --------
  static const Color error = Color(0xFFD94A4A);
  static const Color success = Color(0xFF80D94A);
  static const Color warning = Color(0xFFD9B44A);

  // -------- CONTAINER COLORS --------
  static const Color containerBg = Color(0xFFFFFFFF);
  static const Color containerBgSecondary = Color(0xFFF4F4F9);

  // -------- BUTTON COLORS --------
  static const Color buttonPrimary = Color(0xFF621DBF);
  static const Color buttonSecondary = Color(0xFFFFFFFF);
  static const Color buttonOutline = Color(0xFFFFFFFF);
  static const Color buttonDisabledPrimary = Color(0xFFDFD2F2);
  static const Color buttonDisabledSecondary = Color(0xFFFFFFFF);
  static const Color buttonDisabledOutline = Color(0xFFFFFFFF);
  static const Color buttonSecondaryBorder = Color(0xFFE1E0EC);
  static const Color buttonOutlineBorder = Color(0xFF191925);
  static const Color buttonOutlineBorderDisabled = Color(0xFFE1E0EC);
  static const Color buttonOutlineBorderDestructive = Color(0xFFD94A4A);
  static const Color buttonTextPrimary = Color(0xFFFFFFFF);
  static const Color buttonTextSecondary = Color(0xFF191925);
  static const Color buttonTextOutline = Color(0xFF191925);
  static const Color buttonTextOutlineDestructive = Color(0xFFD94A4A);
  static const Color buttonTextDisabledPrimary = Color(0xFFA177D9);
  static const Color buttonTextDisabledSecondary = Color(0xFF89879E);
  static const Color buttonTextDisabledOutline = Color(0xFFE1E0EC);

  // -------- TEXT FIELD COLORS --------
  static const Color textFieldFill = Color(0xFFFFFFFF);
  static const Color textFieldFillDisabled = Color(0xFFE1E0EC);
  static const Color textFieldFillError = Color(0xFFFBEDED);
  static const Color textFieldBorder = Color(0xFF191925);
  static const Color textFieldBorderError = Color(0xFFD94A4A);
  static const Color textFieldHint = Color(0xFFACAABE);
  static const Color textFieldText = Color(0xFF191925);
  static const Color textFieldTextDisabled = Color(0xFFACAABE);
  static const Color textFieldTextError = Color(0xFFD94A4A);

  // -------- BRAND COLORS --------
  static const Color stravaPrimary = Color(0xFFFC4C02);

  // -------- SHIMMER COLORS --------
  static const Color shimmerBase = Color(0xFFE1E0EC);
  static const Color shimmerHighlight = Color(0xFFD0CEDD);
}
