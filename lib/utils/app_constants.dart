import 'package:flutter/material.dart';

class AppConstants {
  // GlobalKey
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get currentState => navigatorKey.currentState!;
}

class AppFonts {
  static const String Montserrat = 'Montserrat';
  static const String PTSans = 'PTSans';
  static const String OpenSans = 'OpenSans';
}

class AppTextStyle {
  static const TextStyle openSans = TextStyle(
    fontFamily: AppFonts.OpenSans,
  );

  static const TextStyle montserrat = TextStyle(
    fontWeight: FontWeight.w400,
  );

  static TextStyle get normal =>
      openSans.copyWith(fontSize: 14, color: Colors.black);

  static TextStyle get medium => openSans.copyWith(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle get bold => openSans.copyWith(
      fontSize: 14, color: Colors.black, fontWeight: FontWeight.w700);
}

class AppColors {
  static const Color primaryColor = Color.fromRGBO(193, 47, 255, 1.0);
  static const Color primaryColorDark = Color.fromRGBO(135, 0, 165, 1.0);
  static const Color primaryColorLight = Color.fromRGBO(233, 116, 255, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color black = Color.fromRGBO(0, 0, 0, 1.0);
  static const Color pinkLightPurple = Color.fromRGBO(255, 198, 247, 1.0);
  static const Color purpleDark = Color.fromRGBO(134, 0, 158, 1.0);
  static const Color blue = Color.fromRGBO(0, 56, 255, 1.0);
  static const Color green = Color.fromRGBO(12, 255, 0, 1.0);
  static const Color gray = Color.fromRGBO(62, 65, 71, 1.0);
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0.0);
}
