import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/subjects.dart';
import 'package:your_fuel_app/controller/app_controller.dart';
import 'package:your_fuel_app/ui/news/news.dart';
import 'package:your_fuel_app/ui/profile/account.dart';
import 'package:your_fuel_app/ui/home/home.dart';
import 'package:your_fuel_app/utils/app_utils.dart';
import 'package:your_fuel_app/widgets/curved_navigation_bar.dart';

import 'messages/messages.dart';

class RootPage extends StatefulWidget {
  RootPage({
    Key? key,
  }) : super(key: key);

  @override
  _RootPageState createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final onTabMenu = PublishSubject<int>();

  List<Widget> pageList = [];
  int index = 0;

  @override
  void initState() {
    super.initState();
    pageList = [
      const HomePage(),
      const News(),
      const Messages(),
      const AccountPage(),
    ];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (appController.loading.isLoading) {
        appController.loading.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: onTabMenu.stream,
        initialData: 0,
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: AppColors.pinkLightPurple,
              body: Stack(
                children: [
                  IndexedStack(index: snapshot.data, children: pageList),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: CurvedNavigationBar(
                        backgroundColor: AppColors.transparent,
                        items: <Widget>[
                          SvgPicture.asset(
                            'assets/icons/icon_store.svg',
                            width: 50.0,
                            height: 50.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/icon_news.svg',
                            width: 30.0,
                            height: 30.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/icon_chat.svg',
                            width: 30.0,
                            height: 30.0,
                          ),
                          SvgPicture.asset(
                            'assets/icons/icon_account.svg',
                            width: 30.0,
                            height: 30.0,
                          ),
                        ],
                        onTap: (index) => onTapMenuBar(index)),
                  ),
                ],
              ));
        });
  }

  void onTapMenuBar(int index) {
    if (index != this.index) {
      this.index = index;
      onTabMenu.add(index);
    }
  }
}
