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
  static const Color primaryColor = Color.fromRGBO(214, 120, 255, 1.0);
  static const Color primaryColorDark = Color.fromRGBO(216, 47, 255, 1.0);
  static const Color primaryColorLight = Color.fromRGBO(248, 211, 255, 1.0);
  static const Color white = Color.fromRGBO(255, 255, 255, 1.0);
  static const Color black = Color.fromRGBO(0, 0, 0, 1.0);
  static const Color pinkLightPurple = Color.fromRGBO(248, 230, 246, 1.0);
  static const Color purpleDark = Color.fromRGBO(134, 0, 158, 1.0);
  static const Color blue = Color.fromRGBO(0, 56, 255, 1.0);
  static const Color green = Color.fromRGBO(12, 255, 0, 1.0);
  static const Color greenLight =
  Color.fromRGBO(95, 191, 91, 0.3686274509803922);
  static const Color gray = Color.fromRGBO(62, 65, 71, 1.0);
  static const Color yellowLight =
  Color.fromRGBO(255, 240, 79, 0.25098039215686274);
  static const Color yellow = Color.fromRGBO(248, 232, 69, 1.0);
  static const Color pink = Color.fromRGBO(133, 216, 255, 1.0);
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0.0);
}

class AppHelper {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
