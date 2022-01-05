import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rxdart/subjects.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/provider/main_provider.dart';
import 'package:yourfuel/ui/news/news.dart';
import 'package:yourfuel/ui/profile/account.dart';
import 'package:yourfuel/ui/home/home.dart';
import 'package:yourfuel/ui/setting/setting.dart';
import 'package:yourfuel/utils/app_utils.dart';
import 'package:yourfuel/widgets/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

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

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      if (appController.loading.isLoading) {
        appController.loading.hide();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    final isToSetting = context.watch<MainProvider>().hasBeenSet;

    return StreamBuilder<int>(
        stream: onTabMenu.stream,
        initialData: 0,
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: AppColors.pinkLightPurple,
              body: isToSetting? Stack(
                children: [
                  IndexedStack(index: snapshot.data, children: pageList),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: bottomMenuBar()
                  ),
                ],
              ): const SettingPage());
        });
  }

  void onTapMenuBar(int index) {
    if (index != this.index) {
      this.index = index;
      onTabMenu.add(index);
    }
  }

  Widget bottomMenuBar(){
    return
      CurvedNavigationBar(
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
          onTap: (index) => onTapMenuBar(index));
  }
}
