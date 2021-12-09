import 'package:flutter/material.dart';
import 'package:your_fuel_app/utils/app_constants.dart';
import 'package:your_fuel_app/widgets/bg_top_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        top: true,
        child: Stack(children: [
          Container(
            decoration: const BoxDecoration(color: AppColors.pinkLightPurple),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  "Cay xang Thu Hong",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.purpleDark,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 5, top: 5),
                child: Text("Thu 4, 9/12/2021"),
              ),
              Stack(
                children: [
                  AspectRatio(
                      aspectRatio: 1 / 1,
                      child: Column(
                        children: [
                          Expanded(
                              flex: 2,
                              child: CustomPaint(
                                painter: HalfCircleCustom(),
                                child: Container(
                                ),
                              )),
                          Expanded(
                              flex: 8,
                              child: Container(
                                // color: Colors.transparent,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [
                                        AppColors.primaryColorLight,
                                        AppColors.primaryColor
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                ),
                              )),
                        ],
                      )),
                  AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Container(
                      margin: EdgeInsets.all(70),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.gray,
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColorDark
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              ))
            ],
          ),

          // Container(
          //   decoration: const BoxDecoration(
          //       gradient: LinearGradient(colors: [
          //     AppColors.primaryColorLight,
          //     AppColors.primaryColor,
          //     AppColors.primaryColorDark
          //   ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          // ),
        ]));
  }
}
