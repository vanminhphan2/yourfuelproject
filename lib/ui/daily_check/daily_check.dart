import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/fuel_station.dart';
import 'package:yourfuel/utils/app_utils.dart';

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

  bool isChangingPrice = false;
  bool isChangingOldElectronicNumber = false;
  bool isChangingData = false;

  final onClickDebtListener = PublishSubject<List<Debt>>();
  final onClickCalculateListener = PublishSubject<bool>();
  final onClickChangePrice = PublishSubject<bool>();
  final onClickChangeOldElectronicNumber = PublishSubject<bool>();
  final onClickChangeData = PublishSubject<bool>();
  final onCanSaveResult = PublishSubject<bool>();

  var totalSale = 0;
  var totalDebt = 0;
  var totalDebtOtherFuel = 0;
  var actuallyReceived = 0;

  @override
  void initState() {
    fuelPriceList.add(FuelPrice(0, 0, "vnd"));
    fuelPriceList.add(FuelPrice(1, 0, "Other fuel"));
    fuelPriceList.add(FuelPrice(2, 14000, "DO 05"));
    fuelPriceList.add(FuelPrice(3, 13000, "DO 025"));
    fuelPriceList.add(FuelPrice(4, 15000, "A92"));
    fuelPriceList.add(FuelPrice(5, 16000, "A95"));
    fuelPriceList.add(FuelPrice(6, 17000, "E5"));

    fuelStationList.add(FuelStation(id: 1, type: 2, numberStation: 1));
    fuelStationList.add(FuelStation(id: 2, type: 2, numberStation: 2));
    fuelStationList.add(FuelStation(id: 1, type: 3, numberStation: 1));
    fuelStationList.add(FuelStation(id: 2, type: 4, numberStation: 2));

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
                child: StreamBuilder<bool>(
                    stream: onClickChangePrice.stream,
                    initialData: isChangingPrice,
                    builder: (context, snapshot) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  "Giá Xăng/Dầu:",
                                  textAlign: TextAlign.start,
                                  style: labelTextStyle,
                                ),
                              ),
                              NormalButton(
                                onTap: _onClickChangePrice,
                                buttonName:
                                    !snapshot.data! ? "Thay đổi" : "Lưu",
                              )
                            ],
                          ),
                          GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              childAspectRatio: 1.5,
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              padding: EdgeInsets.zero,
                              children: fuelPriceList
                                  .skipWhile((value) => value.type <= 1)
                                  .map(
                                (e) {
                                  return MoneyTextField(
                                    data: e.price.toString(),
                                    isEnable: snapshot.data!,
                                    maxLength: 6,
                                    onDataChange: (value) => e.price = value,
                                    labelText: e.name + ":",
                                  );
                                },
                              ).toList()),
                        ],
                      );
                    }),
              ),
            ),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: StreamBuilder<bool>(
                    stream: onClickChangeOldElectronicNumber.stream,
                    initialData: isChangingOldElectronicNumber,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                buttonName:
                                    !snapshot.data! ? "Thay đổi" : "Lưu",
                                onTap: _onClickChangeOldElectronicNumber,
                              )
                            ],
                          ),
                          GridView.count(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              childAspectRatio: 1.5,
                              crossAxisCount: 3,
                              crossAxisSpacing: 15,
                              padding: EdgeInsets.zero,
                              children: fuelStationList.map(
                                (e) {
                                  return NumberTextField(
                                    isEnable: snapshot.data!,
                                    onDataChange: (value) =>
                                        e.oldElectronicNumber = value,
                                    labelText: e.compactTypeName() +
                                        e.numberStation.toString() +
                                        ":",
                                  );
                                },
                              ).toList()),
                        ],
                      );
                    }),
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
                        childAspectRatio: 1.5,
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        padding: EdgeInsets.zero,
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
                        childAspectRatio: 1.5,
                        crossAxisCount: 3,
                        crossAxisSpacing: 15,
                        padding: EdgeInsets.zero,
                        children: fuelStationList.map(
                          (e) {
                            return NumberTextField(
                              onDataChange: (value) => e.engineNumber = value,
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
                                      priceType: fuelPriceList,
                                      onValueChange: (value) {
                                        item = value;
                                      },
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
              child: StreamBuilder<bool>(
                  stream: onClickChangeData.stream,
                  initialData: isChangingData,
                  builder: (context, snapshot) {
                    return NormalButton(
                      onTap: _onClickCalculate,
                      buttonName: "Tính kết quả",
                      canClick: !snapshot.data!,
                    );
                  }),
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
                        child: Text(
                          "Tính Toán :",
                          textAlign: TextAlign.center,
                          style: labelTextStyle,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<bool>(
                          stream: onClickCalculateListener.stream,
                          initialData: false,
                          builder: (context, snapshot) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0; i < fuelStationList.length; i++)
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        fuelStationList[i].fullTypeName() +
                                            fuelStationList[i]
                                                .numberStation
                                                .toString() +
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
                                            (fuelStationList[i]
                                                        .newElectronicNumber -
                                                    fuelStationList[i]
                                                        .oldElectronicNumber)
                                                .toString() +
                                            " Lit",
                                        style: normalTextStyle,
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                        "Engine: " +
                                            fuelStationList[i]
                                                .engineNumber
                                                .toString(),
                                        style: normalTextStyle,
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )
                              ],
                            );
                          }),
                    ]),
              ),
            ),
            Card(
              elevation: 5,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerLeft,
                child: StreamBuilder<Object>(
                    stream: onClickCalculateListener.stream,
                    builder: (context, snapshot) {
                      _checkForCanClickSave();

                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                "Kết quả:",
                                textAlign: TextAlign.center,
                                style: labelTextStyle,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: fuelPriceList
                                    .skipWhile((value) => value.type <= 1)
                                    .map((e) {
                                  int totalFuelByType = getTotalFuelByType(e);
                                  int totalMoneyByType =
                                      totalFuelByType * e.price;
                                  return Text(
                                    "${e.name}: ${totalFuelByType.toString()} L = ${AppConstants.moneyFormat.format(totalMoneyByType)} vnd",
                                    style: normalTextStyle,
                                    textAlign: TextAlign.start,
                                  );
                                }).toList(),
                              ),
                            ),
                            if (totalDebt > 0 || totalDebtOtherFuel > 0)
                              Text(
                                "Debt:",
                                style: labelTextStyle,
                                textAlign: TextAlign.start,
                              ),
                            if (totalDebt > 0 || totalDebtOtherFuel > 0)
                              debtShowList(),
                            Text(
                              "Total sale: ${AppConstants.moneyFormat.format(totalSale)} vnd",
                              style: labelTextStyle,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Total debt: ${AppConstants.moneyFormat.format(totalDebt)} vnd",
                              style: labelTextStyle,
                              textAlign: TextAlign.start,
                            ),
                            if (totalDebtOtherFuel > 0)
                              Text(
                                "Total debt other fuel: ${AppConstants.moneyFormat.format(totalDebtOtherFuel)} vnd",
                                style: labelTextStyle,
                                textAlign: TextAlign.start,
                              ),
                            Text(
                              "Actually received: ${AppConstants.moneyFormat.format(actuallyReceived)} vnd",
                              style: labelTextStyle,
                              textAlign: TextAlign.start,
                            ),
                          ]);
                    }),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder<bool>(
                stream: onCanSaveResult.stream,
                initialData: false,
                builder: (context, snapshot) {
                  return NormalButton(
                    onTap: _onClickSaveResult,
                    buttonName: "Lưu kết quả",
                    canClick: snapshot.data!,
                  );
                }),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  void _checkForCanClickSave() {
    fuelPriceList.skipWhile((value) => value.type <= 1).forEach((element) {
      int totalFuelByType = getTotalFuelByType(element);
      int totalMoneyByType = totalFuelByType * element.price;

      totalSale = totalSale + totalMoneyByType;
    });

    actuallyReceived = totalSale - totalDebt;
    onCanSaveResult.add(totalSale > 0);
  }

  void _addDebt() {
    debtList.add(Debt(debtList.length + 1, 1, "", fuelPriceList.first, 0, ""));
    onClickDebtListener.add(debtList);
  }

  void _removeDebt(List<Debt> debtList, int id) {
    debtList.removeWhere((element) => element.id == id);

    onClickDebtListener.add(debtList);
  }

  void _onClickCalculate() {
    print("_onClickCalculate");
    totalSale = 0;
    totalDebt = 0;
    totalDebtOtherFuel = 0;
    actuallyReceived = 0;

    for (var item in debtList) {
      totalDebt = totalDebt + item.getValue();
      if (item.fuelType.type == 1) {
        totalDebtOtherFuel = totalDebtOtherFuel + item.value;
      }
    }
    onClickCalculateListener.add(true);
  }

  int getPrice(int type) {
    return fuelPriceList.firstWhere((element) => element.type == type).price;
  }

  void _onClickChangePrice() {
    bool _hasEmpty = false;
    if (isChangingPrice) {
      //neu dang thay doi => luu thay doi
      _hasEmpty = fuelPriceList
          .any((element) => element.type > 1 && element.price <= 0);

      if (!_hasEmpty) {
        //save to server
        isChangingPrice = false;
        onClickChangePrice.add(isChangingPrice); // doi lai UI

        //set can click calculate
        if (!isChangingOldElectronicNumber) {
          isChangingData = false;
          onClickChangeData.add(isChangingData);
        }
      }
    } else {
      //dang khong thay doi=> co the thay doi
      isChangingPrice = true;
      onClickChangePrice.add(isChangingPrice);

      isChangingData = true;
      onClickChangeData.add(isChangingData);
    }
  }

  void _onClickChangeOldElectronicNumber() {
    if (isChangingOldElectronicNumber) {
      //neu dang thay doi => luu thay doi

      //save to server
      isChangingOldElectronicNumber = false;
      onClickChangeOldElectronicNumber
          .add(isChangingOldElectronicNumber); // doi lai UI

      //set can click calculate
      if (!isChangingPrice) {
        isChangingData = false;
        onClickChangeData.add(isChangingData);
      }
    } else {
      //dang khong thay doi=> co the thay doi
      isChangingOldElectronicNumber = true;
      onClickChangeOldElectronicNumber.add(isChangingOldElectronicNumber);

      isChangingData = true;
      onClickChangeData.add(isChangingData);
    }
  }

  int getTotalFuelByType(FuelPrice item) {
    int total = 0;
    for (var e in fuelStationList) {
      if (e.type == item.type) {
        total = total + (e.newElectronicNumber - e.oldElectronicNumber);
      }
    }
    return total;
  }

  Widget debtShowList() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: debtList.map((e) {
          return RichText(
            text: TextSpan(
                text: e.debtorName + ": ",
                style: const TextStyle(
                    color: AppColors.orange,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: getValueDebt(e),
                      style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.normal))
                ]),
          );
        }).toList(),
      ),
    );
  }

  String getValueDebt(Debt e) {
    if (e.fuelType.type == 0) {
      return AppConstants.moneyFormat.format(e.value) + " vnd";
    }
    if (e.fuelType.type == 1) {
      return e.value.toString() + " " + e.engineOilName;
    }
    return e.value.toString() + " Lit " + e.fuelType.name;
  }

  void _onClickSaveResult() {
    print("_onClickSaveResult");
  }
}

class NormalButton extends StatelessWidget {
  NormalButton(
      {Key? key, this.buttonName, required this.onTap, this.canClick = true})
      : super(key: key);

  String? buttonName;
  VoidCallback onTap;
  bool canClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: canClick ? onTap : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColorDark
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: Text(
              buttonName ?? "ButtonName",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                  fontSize: 17),
            ),
          ),
        ],
      ),
    );
  }
}

class NumberTextField extends StatelessWidget {
  NumberTextField(
      {Key? key,
      required this.onDataChange,
      this.data,
      this.isEnable,
      this.labelText})
      : super(key: key);

  TextEditingController textEditingController = TextEditingController();
  final Function(int) onDataChange;
  String? data;
  String? labelText;
  bool? isEnable = true;

  @override
  Widget build(BuildContext context) {
    textEditingController.text = data ?? "";
    return TextField(
      scrollPadding: EdgeInsets.zero,
      controller: textEditingController,
      keyboardType: TextInputType.number,
      maxLines: 1,
      enabled: isEnable,
      maxLength: 6,
      decoration: InputDecoration(
          counter: const Offstage(),
          labelText: labelText,
          fillColor: AppColors.primaryColor),
      onChanged: (value) =>
          onDataChange((value.isNotEmpty) ? int.parse(value) : 0),
    );
  }
}

class MoneyTextField extends StatelessWidget {
  MoneyTextField(
      {Key? key,
      required this.onDataChange,
      this.data,
      this.labelText,
      this.isEnable,
      this.maxLength})
      : super(key: key);

  TextEditingController textEditingController = TextEditingController();
  final Function(int) onDataChange;
  String? data;
  String? labelText;
  int? maxLength = 6;
  bool? isEnable = true;

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern("en").format(int.parse(s));

  @override
  Widget build(BuildContext context) {
    if (data != null && data!.isNotEmpty) {
      textEditingController.text = _formatNumber(data!.replaceAll(',', ''));
    } else {
      textEditingController.text = "";
    }
    return TextField(
        controller: textEditingController,
        keyboardType: TextInputType.number,
        maxLines: 1,
        enabled: isEnable,
        maxLength: maxLength,
        decoration: InputDecoration(
            counter: const Offstage(),
            labelText: labelText,
            fillColor: AppColors.primaryColor),
        onChanged: (value) {
          if (value.isNotEmpty) {
            value = value.replaceAll(",", "");
            onDataChange((value.isNotEmpty) ? int.parse(value) : 0);
            value = _formatNumber(value.replaceAll(',', ''));
            textEditingController.value = TextEditingValue(
              text: value,
              selection: TextSelection.collapsed(offset: value.length),
            );
          }
        });
  }
}
