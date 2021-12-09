import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'package:your_fuel_app/controller/app_controller.dart';
import 'package:your_fuel_app/ui/account.dart';
import 'package:your_fuel_app/ui/home.dart';
import 'package:your_fuel_app/ui/login.dart';
import 'package:your_fuel_app/utils/app_constants.dart';
import 'package:your_fuel_app/widgets/curved_navigation_bar.dart';

class RootPage extends StatefulWidget {
  RootPage({
    Key? key,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  StreamController onTabMenuController = StreamController<int>.broadcast();

  Stream get onTabMenuStream => onTabMenuController.stream;

  final onTabMenu = PublishSubject<int>();

  List<Widget> pageList = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    pageList = [
      HomePage(),
      const AccountPage(),
      const LoginPage(),
      const AccountPage(),
    ];

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (appController.loading.isLoading) {
        appController.loading.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: onTabMenu.stream,
        builder: (context, snapshot) {
          return Scaffold(
            bottomNavigationBar: CurvedNavigationBar(
              backgroundColor: AppColors.primaryColorDark,
              items: <Widget>[
                Icon(Icons.home, size: 30),
                Icon(Icons.list, size: 30),
                Icon(Icons.compare_arrows, size: 30),
                Icon(Icons.add, size: 30),
              ],
              onTap: (index) => onTapMenuBar(index)
            ),
            body: pageList[snapshot.data ?? 0],
          );

            // Scaffold(
            //   body: pageList[snapshot.data ?? 0],
            //   bottomNavigationBar: BottomNavigationBar(
            //       type: BottomNavigationBarType.fixed,
            //       currentIndex: snapshot.data ?? 0,
            //       items: const [
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.home),
            //           label: "Store",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.contacts),
            //           label: "News",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.email),
            //           label: "Messages",
            //         ),
            //         BottomNavigationBarItem(
            //           icon: Icon(Icons.account_circle),
            //           label: "Profile",
            //         ),
            //       ],
            //       onTap: (int index) => onTapMenuBar(index)));
        });
  }

  void onTapMenuBar(int index) {
    if (index != this.index) {
      this.index = index;
      onTabMenu.add(index);
    }
  }

  @override
  void dispose() {
    onTabMenuController.close();
    super.dispose();
  }
}
