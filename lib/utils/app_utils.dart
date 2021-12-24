import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart' as crypto;

class AppConstants {
  // GlobalKey
  static final navigatorKey = GlobalKey<NavigatorState>();

  static NavigatorState get currentState => navigatorKey.currentState!;

  static final moneyFormat= NumberFormat("#,###", "en_US");
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
  static const Color blueLight = Color.fromRGBO(133, 216, 255, 1.0);
  static const Color transparent = Color.fromRGBO(0, 0, 0, 0.0);
  static const Color halfTransparent =
      Color.fromRGBO(0, 0, 0, 0.8352941176470589);
  static const Color hintTextColors =
      Color.fromRGBO(0, 0, 0, 0.5529411764705883);
  static const Color backgroundText =
      Color.fromRGBO(72, 213, 255, 0.5137254901960784);
  static const Color colorMenuBar = Color.fromRGBO(115, 241, 255, 1.0);
  static const Color orange = Color.fromRGBO(255, 140, 0, 1.0);
}

const listRandomColor = [
  Colors.red,
  Colors.blue,
  Colors.pink,
  Colors.purpleAccent,
  Colors.black,
  Colors.green
];

class AppHelper {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Navigate push with callback
  static void navigatePush(context, String screenName, Widget screen,
      [Function(Object)? callback]) {
    if (context == null) return;
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => screen,
          settings: RouteSettings(name: screenName),
        )).then((data) {
      if (data != null && callback != null) {
        callback(data);
      }
    });
  }
  /// Navigate push with callback
  static void navigateReplace(context, String screenName, Widget screen,
      [Function(Object)? callback]) {
    if (context == null) return;
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => screen,
          settings: RouteSettings(name: screenName),
        )).then((data) {
      if (data != null && callback != null) {
        callback(data);
      }
    });
  }

  static String generateMd5(String input) {
    return crypto.md5.convert(utf8.encode(input)).toString();
  }
}

class AppScreenName {
  static const String login = 'loginScreen';
  static const String register = 'registerScreen';
  static const String home = 'homeScreen';
  static const String main = 'mainAppScreen';
  static const String dailyCheck = 'dailyCheckScreen';
}