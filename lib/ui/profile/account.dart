import 'package:flutter/material.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColorDark
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
              ),
            )
          ],
        ));
  }
}
