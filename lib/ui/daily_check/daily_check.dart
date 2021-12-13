import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:your_fuel_app/models/debt.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

import 'debt_widget.dart';

class DailyCheck extends StatefulWidget {
  DailyCheck({Key? key, this.totalDieselOilStation, this.totalGasolineStation})
      : super(key: key);

  int? totalDieselOilStation = 2;
  int? totalGasolineStation = 2;

  @override
  _DailyCheckState createState() => _DailyCheckState();
}

class _DailyCheckState extends State<DailyCheck> {
  var toDay;
  late TextStyle labelTextStyle;
  List<Debt> debtList = [];

  final onClickDebtListener = PublishSubject<List<Debt>>();

  @override
  void initState() {
    toDay = DateTime.now();
    labelTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 17);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLightPurple,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Check day: ${DateFormat('dd-MM-yyyy').format(toDay)}"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Giá Xăng dầu:",
                            textAlign: TextAlign.start,
                            style: labelTextStyle,
                          ),
                        ),
                        NormalButton(
                          buttonName: "Thay đổi",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 8, left: 8, right: 8),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: "Giá dầu",
                                  fillColor: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 8, left: 8, right: 8),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: "Giá xăng",
                                  fillColor: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Số điện tử cũ:",
                            textAlign: TextAlign.start,
                            style: labelTextStyle,
                          ),
                        ),
                        NormalButton(
                          buttonName: "Thay đổi",
                        )
                      ],
                    ),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      scrollDirection: Axis.vertical,
                      children: List.generate(
                            widget.totalDieselOilStation ?? 2,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText:
                                          "Dầu ${(index + 1).toString()}",
                                      fillColor: AppColors.primaryColor),
                                ),
                              );
                            },
                          ) +
                          List.generate(
                            widget.totalDieselOilStation ?? 2,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText:
                                          "Xăng ${(index + 1).toString()}",
                                      fillColor: AppColors.primaryColor),
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Số điện tử mới:",
                        textAlign: TextAlign.start,
                        style: labelTextStyle,
                      ),
                    ),
                    GridView.count(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      crossAxisCount: 4,
                      scrollDirection: Axis.vertical,
                      children: List.generate(
                            widget.totalDieselOilStation ?? 2,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText:
                                          "Dầu ${(index + 1).toString()}",
                                      fillColor: AppColors.primaryColor),
                                ),
                              );
                            },
                          ) +
                          List.generate(
                            widget.totalDieselOilStation ?? 2,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText:
                                          "Xăng ${(index + 1).toString()}",
                                      fillColor: AppColors.primaryColor),
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Số kê:",
                        textAlign: TextAlign.start,
                        style: labelTextStyle,
                      ),
                    ),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 4,
                      scrollDirection: Axis.vertical,
                      children: List.generate(
                            widget.totalDieselOilStation ?? 7,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText:
                                          "Dầu ${(index + 1).toString()}",
                                      fillColor: AppColors.primaryColor),
                                ),
                              );
                            },
                          ) +
                          List.generate(
                            widget.totalDieselOilStation ?? 2,
                            (index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    bottom: 8, left: 8, right: 8),
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      labelText:
                                          "Xăng ${(index + 1).toString()}",
                                      fillColor: AppColors.primaryColor),
                                ),
                              );
                            },
                          ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Nợ:",
                        textAlign: TextAlign.start,
                        style: labelTextStyle,
                      ),
                    ),
                    StreamBuilder(
                        stream: onClickDebtListener.stream,
                        initialData: debtList,
                        builder: (context, snapshot) {
                          int length = (snapshot.data as List<Debt>).length;
                          return Column(
                            children: List.generate(
                              length,
                              (index) {
                                return DebtItem(
                                  item: debtList[index],
                                  onDelete: () =>
                                      _removeDebt(debtList[index].id),
                                );
                              },
                            ),
                          );
                        }),
                    OutlinedButton.icon(
                      icon: const Icon(
                        Icons.add,
                        color: AppColors.primaryColorDark,
                      ),
                      onPressed: _addDebt,
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.primaryColor, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                      ),
                      label: const Text(
                        "Thêm công nợ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryColorDark,
                            fontSize: 15),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _addDebt() {
    debtList.add(Debt(debtList.length + 1, 1, "", 1, 1, ""));
    onClickDebtListener.add(debtList);
  }

  void _removeDebt(int id) {
    debtList = List.from(debtList)..removeWhere((element) => element.id == id);
    onClickDebtListener.add(debtList);
  }
}

class NormalButton extends StatelessWidget {
  NormalButton({Key? key, this.buttonName}) : super(key: key);

  String? buttonName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: const LinearGradient(
              colors: [AppColors.primaryColor, AppColors.primaryColorDark],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: Text(
        buttonName ?? "ButtonName",
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColors.white, fontSize: 17),
      ),
    );
  }
}
