import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:your_fuel_app/models/debt.dart';
import 'package:your_fuel_app/models/fuel_price.dart';
import 'package:your_fuel_app/models/fuel_station.dart';
import 'package:your_fuel_app/utils/app_utils.dart';

import 'debt_widget.dart';

class DailyCheck extends StatefulWidget {
  const DailyCheck({Key? key}) : super(key: key);

  @override
  _DailyCheckState createState() => _DailyCheckState();
}

class _DailyCheckState extends State<DailyCheck> {
  List<FuelStation> fuelStationList = [];
  var toDay;
  late TextStyle labelTextStyle;
  late TextStyle normalTextStyle;
  List<Debt> debtList = [];
  List<FuelPrice> fuelPriceList = [];

  final onClickDebtListener = PublishSubject<List<Debt>>();

  var totalDiesel05 = 0;
  var totalDiesel025 = 0;
  var totalA92 = 0;
  var totalA95 = 0;
  var totalE5 = 0;
  var totalSale = 0;
  var totalDebt = 0;
  var actuallyReceived = 0;

  @override
  void initState() {
    fuelPriceList.add(FuelPrice(1, 14000));
    fuelPriceList.add(FuelPrice(2, 13000));
    fuelPriceList.add(FuelPrice(3, 15000));
    fuelPriceList.add(FuelPrice(4, 16000));
    fuelPriceList.add(FuelPrice(5, 17000));

    fuelStationList.add(FuelStation(id: 1, type: 1, numberStation: 1));
    fuelStationList.add(FuelStation(id: 2, type: 1, numberStation: 2));
    fuelStationList.add(FuelStation(id: 3, type: 4, numberStation: 3));
    fuelStationList.add(FuelStation(id: 4, type: 4, numberStation: 4));
    fuelStationList.add(FuelStation(id: 5, type: 4, numberStation: 5));
    fuelStationList.add(FuelStation(id: 6, type: 4, numberStation: 6));

    toDay = DateTime.now();
    labelTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 17);
    normalTextStyle = const TextStyle(
        fontWeight: FontWeight.normal, color: AppColors.black, fontSize: 15);
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
                            child: const TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Giá dầu",
                                  fillColor: AppColors.primaryColor),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(
                                bottom: 8, left: 8, right: 8),
                            child: const TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
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
                        crossAxisCount: 3,
                        scrollDirection: Axis.vertical,
                        children: fuelStationList.map(
                          (e) {
                            return NumberTextField(
                              onDataChange: (value) =>
                                  e.oldElectronicNumber = value,
                              labelText: e.compactTypeName() +
                                  e.numberStation.toString() +
                                  ":",
                            );
                          },
                        ).toList()),
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
                        crossAxisCount: 3,
                        scrollDirection: Axis.vertical,
                        children: fuelStationList.map(
                          (e) {
                            return NumberTextField(
                              onDataChange: (value) =>
                                  e.newElectronicNumber = value,
                              labelText: e.compactTypeName() +
                                  e.numberStation.toString() +
                                  ":",
                            );
                          },
                        ).toList()),
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
                        crossAxisCount: 3,
                        scrollDirection: Axis.vertical,
                        children: fuelStationList.map(
                          (e) {
                            return NumberTextField(
                              onDataChange: (value) =>
                                  e.oldElectronicNumber = value,
                              labelText: e.compactTypeName() +
                                  e.numberStation.toString() +
                                  ":",
                            );
                          },
                        ).toList()),
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
                    StreamBuilder<List<Debt>>(
                        stream: onClickDebtListener.stream,
                        initialData: debtList,
                        builder: (context, snapshot) {
                          debtList = [...snapshot.data!];
                          return Column(
                            children: snapshot.data!
                                .map((item) => DebtItem(
                                      key: ValueKey(item.id.toString()),
                                      item: item,
                                      onDelete: () =>
                                          _removeDebt(snapshot.data!, item.id),
                                    ))
                                .toList(),
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NormalButton(
                buttonName: "Tính kết quả",
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: _onClickCalculate,
                          child: Text(
                            "Tính Toán :",
                            textAlign: TextAlign.center,
                            style: labelTextStyle,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      for (int i = 0; i < fuelStationList.length; i++)
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fuelStationList[i].fullTypeName() +
                                  fuelStationList[i].numberStation.toString() +
                                  ":",
                              style: labelTextStyle,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Electronic: " +
                                  fuelStationList[i]
                                      .newElectronicNumber
                                      .toString() +
                                  " - " +
                                  fuelStationList[i]
                                      .oldElectronicNumber
                                      .toString() +
                                  " = " +
                                  (fuelStationList[i].newElectronicNumber -
                                          fuelStationList[i]
                                              .oldElectronicNumber)
                                      .toString() +
                                  " Lit",
                              style: normalTextStyle,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Engine: " +
                                  fuelStationList[i].engineNumber.toString(),
                              style: normalTextStyle,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        )
                    ]),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: InkWell(
                          onTap: _onClickCalculate,
                          child: Text(
                            "Kết quả:",
                            textAlign: TextAlign.center,
                            style: labelTextStyle,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (totalDiesel05 > 0)
                        Text(
                          "Diesel 0,05: $totalDiesel05 L",
                          style: normalTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      if (totalDiesel025 > 0)
                        Text(
                          "Diesel 0,025: $totalDiesel025 L",
                          style: normalTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      if (totalA92 > 0)
                        Text(
                          "A92: $totalA92 L",
                          style: normalTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      if (totalA95 > 0)
                        Text(
                          "A95: $totalA95 L",
                          style: normalTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      if (totalE5 > 0)
                        Text(
                          "E5: $totalE5 L",
                          style: normalTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      Text(
                        "Total Sale: $totalSale vnd",
                        style: labelTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Total Debt: $totalDebt vnd",
                        style: labelTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Actually Received: $actuallyReceived vnd",
                        style: labelTextStyle,
                        textAlign: TextAlign.start,
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addDebt() {
    debtList.add(Debt(debtList.length + 1, 1, "", 1, 1, ""));
    onClickDebtListener.add(debtList);
  }

  void _removeDebt(List<Debt> debtList, int id) {
    debtList.removeWhere((element) => element.id == id);

    onClickDebtListener.add(debtList);
  }

  void _onClickCalculate() {
    fuelStationList.map((e) {
      switch (e.type) {
        case 1:
          totalDiesel05 + (e.newElectronicNumber - e.oldElectronicNumber);
          break;
        case 2:
          totalDiesel025 + (e.newElectronicNumber - e.oldElectronicNumber);
          break;
        case 3:
          totalA92 + (e.newElectronicNumber - e.oldElectronicNumber);
          break;
        case 4:
          totalA95 + (e.newElectronicNumber - e.oldElectronicNumber);
          break;
        case 5:
          totalE5 + (e.newElectronicNumber - e.oldElectronicNumber);
          break;
      }
    });
  }
}

class NormalButton extends StatelessWidget {
  NormalButton({Key? key, this.buttonName}) : super(key: key);

  String? buttonName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              gradient: const LinearGradient(
                  colors: [AppColors.primaryColor, AppColors.primaryColorDark],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)),
          child: Text(
            buttonName ?? "ButtonName",
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
                fontSize: 17),
          ),
        ),
      ],
    );
  }
}

class NumberTextField extends StatelessWidget {
  NumberTextField(
      {Key? key, required this.onDataChange, this.data, this.labelText})
      : super(key: key);

  TextEditingController textEditingController = TextEditingController();
  final Function(int) onDataChange;
  String? data;
  String? labelText;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = data ?? "";
    return Container(
      margin: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
      child: TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        maxLength: 6,
        decoration: InputDecoration(
            counter: const Offstage(),
            labelText: labelText,
            fillColor: AppColors.primaryColor),
        onChanged: (value) =>
            onDataChange((value.isNotEmpty) ? int.parse(value) : 0),
      ),
    );
  }
}
