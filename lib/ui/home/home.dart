import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:your_fuel_app/models/staff.dart';
import 'package:your_fuel_app/ui/daily_check/daily_check.dart';
import 'package:your_fuel_app/utils/app_utils.dart';
import 'package:your_fuel_app/widgets/bg_top_home.dart';
import 'package:your_fuel_app/ui/home/store_feature.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Staff> staffList = [];

  @override
  void initState() {
    staffList.add(Staff(
        1,
        "tran huynh tuan",
        "22/10/1997",
        "https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg",
        "female"));
    staffList.add(Staff(
        2,
        "phan van minh",
        "22/10/1997",
        "https://kynguyenlamdep.com/wp-content/uploads/2020/01/hinh-anh-dep-hoa-bo-cong-anh.jpg",
        "male"));
    staffList.add(Staff(
        3,
        "tran thanh hai",
        "22/10/1997",
        "https://kynguyenlamdep.com/wp-content/uploads/2020/01/bo-cong-anh.jpg",
        "male"));
    staffList.add(Staff(
        4,
        "do thi hoa",
        "22/10/1997",
        "https://thuthuatnhanh.com/wp-content/uploads/2019/11/hinh-nen-dien-thoai-dep-585x390.jpg",
        "female"));
    staffList.add(Staff(
        5,
        "nguyen ngoc thuan",
        "22/10/1997",
        "https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg",
        "male"));
    super.initState();
  }

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
              SizedBox(
                width: AppHelper.screenWidth(context),
                height: AppHelper.screenWidth(context) * 0.7,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: CustomPaint(
                              painter: HalfCircleCustom(),
                              child: Container(),
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
                    ),
                    Center(
                      child: Container(
                        width: AppHelper.screenWidth(context) * 0.7,
                        height: AppHelper.screenWidth(context) * 0.7,
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 70, bottom: 20),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.gray,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColorDark
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    StoreFeature(
                      icon: "assets/icons/icon_worker.svg",
                      name: "Staff",
                    ),
                    StoreFeature(
                      icon: "assets/icons/icon_gas_station.svg",
                      name: "Checkout",
                    ),
                    StoreFeature(
                      icon: "assets/icons/icon_tank_truck.svg",
                      name: "Import Fuel",
                    ),
                    InkWell(
                      onTap: () => _onClickDailyCheck(context),
                      child: StoreFeature(
                        icon: "assets/icons/icon_check_note.svg",
                        name: "Daily Check",
                      ),
                    ),
                    StoreFeature(
                      icon: "assets/icons/icon_statistics.svg",
                      name: "Statistics",
                    ),
                    StoreFeature(
                      icon: "assets/icons/icon_contacts.svg",
                      name: "Feedback",
                    ),
                  ],
                ),
              ))
            ],
          ),
        ]));
  }

  void _onClickDailyCheck(BuildContext context) {
    AppHelper.navigatePush(context, AppScreenName.dailyCheck, DailyCheck());
  }

  void _onClickStaff() {}

  void _onClickAddStaff() {}
}

// SizedBox(
//   height: 70,
//   width: double.infinity,
//   child: ListView.builder(
//       itemCount: staffList.length+1,
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//
//         return (index == staffList.length)
//             ? InkWell(
//                 onTap: _onClickAddStaff,
//                 child: Container(width: 70, height: 70,child: const Icon(Icons.add),
//                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(70),
//                 color: AppColors.yellowLight),),
//               )
//             : InkWell(
//                 onTap: _onClickStaff,
//                 child: Container(
//                   margin: const EdgeInsets.only(right: 15),
//                   decoration: const BoxDecoration(
//                       color: AppColors.yellowLight,
//                       borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(70),
//                           bottomLeft: Radius.circular(70),
//                           topRight: Radius.circular(30),
//                           bottomRight:
//                               Radius.circular(30))),
//                   child: Row(
//                     children: [
//                       ClipRRect(
//                         borderRadius:
//                             BorderRadius.circular(70),
//                         child: Image.network(
//                           staffList[index].avatar,
//                           fit: BoxFit.cover,
//                           width: 70,
//                           height: 70,
//                         ),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                       Text(
//                         staffList[index].name,
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(
//                         width: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//       }),
// )
