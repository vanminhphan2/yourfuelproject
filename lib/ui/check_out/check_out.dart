import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:yourfuel/generated/l10n.dart';
import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/provider/base_provider.dart';
import 'package:yourfuel/ui/check_out/check_out_bloc.dart';
import 'package:yourfuel/utils/app_utils.dart';

import 'debt_widget.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  _CheckOutPageState createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final CheckOutBlock _bloc = CheckOutBlock();
  var toDay;
  late TextStyle labelTextStyle;
  late TextStyle normalTextStyle;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _bloc.getData();
    });

    toDay = DateTime.now();
    labelTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 17);
    normalTextStyle = const TextStyle(
        fontWeight: FontWeight.normal, color: AppColors.black, fontSize: 15);
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pinkLightPurple,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${S.of(context).CheckDay}: ${DateFormat('dd-MM-yyyy').format(toDay)}"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<bool>(
            stream: _bloc.onGetData.stream,
            initialData: false,
            builder: (context, snapshot) {
              return (snapshot.data!)
                  ? Column(
                      children: [
                        Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: StreamBuilder<bool>(
                                stream: _bloc.onClickChangePrice.stream,
                                initialData: _bloc.isChangingPrice,
                                builder: (context, snapshot) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Giá Xăng/Dầu:",
                                              textAlign: TextAlign.start,
                                              style: labelTextStyle,
                                            ),
                                          ),
                                          NormalButton(
                                            onTap: () =>
                                                _bloc.clickChangePrice(),
                                            buttonName: !snapshot.data!
                                                ? "Thay đổi"
                                                : "Lưu",
                                          )
                                        ],
                                      ),
                                      GridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          childAspectRatio: 1.5,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 15,
                                          padding: EdgeInsets.zero,
                                          children: _bloc.fuelPriceList
                                              .skipWhile(
                                                  (value) => value.type <= 1)
                                              .map(
                                            (e) {
                                              return MoneyTextField(
                                                data: e.price.toString(),
                                                isEnable: snapshot.data!,
                                                maxLength: 6,
                                                onDataChange: (value) =>
                                                    e.price = value,
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
                                stream: _bloc
                                    .onClickChangeOldElectronicNumber.stream,
                                initialData:
                                    _bloc.isChangingOldElectronicNumber,
                                builder: (context, snapshot) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              "Số điện tử cũ:",
                                              textAlign: TextAlign.start,
                                              style: labelTextStyle,
                                            ),
                                          ),
                                          NormalButton(
                                            buttonName: !snapshot.data!
                                                ? "Thay đổi"
                                                : "Lưu",
                                            onTap: () => _bloc
                                                .clickChangeOldElectronicNumber(),
                                          )
                                        ],
                                      ),
                                      GridView.count(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          childAspectRatio: 1.5,
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 15,
                                          padding: EdgeInsets.zero,
                                          children: _bloc.fuelStationList.map(
                                            (e) {
                                              return NumberTextField(
                                                isEnable: snapshot.data!,
                                                data: e.oldElectronicNumber
                                                    .toString(),
                                                onDataChange: (value) =>
                                                    e.oldElectronicNumber =
                                                        value,
                                                labelText: e.typeName +
                                                    " Trụ " +
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    childAspectRatio: 1.5,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 15,
                                    padding: EdgeInsets.zero,
                                    children: _bloc.fuelStationList.map(
                                      (e) {
                                        return NumberTextField(
                                          onDataChange: (value) =>
                                              e.newElectronicNumber = value,
                                          labelText: e.typeName +
                                              " Trụ " +
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    childAspectRatio: 1.5,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 15,
                                    padding: EdgeInsets.zero,
                                    children: _bloc.fuelStationList.map(
                                      (e) {
                                        return NumberTextField(
                                          onDataChange: (value) =>
                                              e.engineNumber = value,
                                          labelText: e.typeName +
                                              " Trụ " +
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
                                    stream: _bloc.onClickDebtListener.stream,
                                    initialData: _bloc.debtList,
                                    builder: (context, snapshot) {
                                      _bloc.debtList = [...snapshot.data!];
                                      return Column(
                                        children: snapshot.data!
                                            .map((item) => DebtItem(
                                                  key: ValueKey(
                                                      item.id.toString()),
                                                  item: item,
                                                  priceType:
                                                      _bloc.fuelPriceList,
                                                  onValueChange: (value) {
                                                    item = value;
                                                  },
                                                  onDelete: () =>
                                                      _bloc.removeDebt(
                                                          snapshot.data!,
                                                          item.id),
                                                ))
                                            .toList(),
                                      );
                                    }),
                                OutlinedButton.icon(
                                  icon: const Icon(
                                    Icons.add,
                                    color: AppColors.primaryColorDark,
                                  ),
                                  onPressed: () => _bloc.addDebt(),
                                  style: ElevatedButton.styleFrom(
                                    side: const BorderSide(
                                        color: AppColors.primaryColor,
                                        width: 2),
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
                              stream: _bloc.onClickChangeData.stream,
                              initialData: _bloc.isChangingData,
                              builder: (context, snapshot) {
                                return NormalButton(
                                  onTap: () => _bloc.clickCalculate(),
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
                                      stream:
                                          _bloc.onClickCalculateListener.stream,
                                      initialData: false,
                                      builder: (context, snapshot) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0;
                                                i <
                                                    _bloc
                                                        .fuelStationList.length;
                                                i++)
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _bloc.fuelStationList[i]
                                                            .fullTypeName +
                                                        " ${S.of(context).Station_number} " +
                                                        _bloc.fuelStationList[i]
                                                            .numberStation
                                                            .toString() +
                                                        ":",
                                                    style: labelTextStyle,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "${S.of(mainContext).Electronic}: " +
                                                        _bloc.fuelStationList[i]
                                                            .newElectronicNumber
                                                            .toString() +
                                                        " - " +
                                                        _bloc.fuelStationList[i]
                                                            .oldElectronicNumber
                                                            .toString() +
                                                        " = " +
                                                        (_bloc
                                                                    .fuelStationList[
                                                                        i]
                                                                    .newElectronicNumber -
                                                                _bloc
                                                                    .fuelStationList[
                                                                        i]
                                                                    .oldElectronicNumber)
                                                            .toString() +
                                                        " Lít",
                                                    style: normalTextStyle,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  Text(
                                                    "${S.of(mainContext).Engine}: " +
                                                        _bloc.fuelStationList[i]
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
                            child: StreamBuilder<bool>(
                                stream: _bloc.onClickCalculateListener.stream,
                                initialData: false,
                                builder: (context, snapshot) {
                                  if (snapshot.data!) {
                                    _bloc.checkForCanClickSave();
                                  }
                                  return (!snapshot.data!)
                                      ? Container()
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: _bloc.fuelPriceList
                                                      .skipWhile((value) =>
                                                          value.type <= 1)
                                                      .map((e) {
                                                    int totalFuelByType = _bloc
                                                        .getTotalFuelByType(e);
                                                    int totalMoneyByType =
                                                        totalFuelByType *
                                                            e.price;
                                                    return Text(
                                                      "${e.name}: ${totalFuelByType.toString()} Lít = ${AppConstants.moneyFormat.format(totalMoneyByType)} vnđ",
                                                      style: normalTextStyle,
                                                      textAlign:
                                                          TextAlign.start,
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                              if (_bloc.totalDebt > 0 ||
                                                  _bloc.totalDebtOtherFuel > 0)
                                                Text(
                                                  "Nợ:",
                                                  style: labelTextStyle,
                                                  textAlign: TextAlign.start,
                                                ),
                                              if (_bloc.totalDebt > 0 ||
                                                  _bloc.totalDebtOtherFuel > 0)
                                                debtShowList(),
                                              Text(
                                                "Tổng doanh thu: ${AppConstants.moneyFormat.format(_bloc.totalSale)} vnd",
                                                style: labelTextStyle,
                                                textAlign: TextAlign.start,
                                              ),
                                              Text(
                                                "Tổng nợ X/D: ${AppConstants.moneyFormat.format(_bloc.totalDebt)} vnd",
                                                style: labelTextStyle,
                                                textAlign: TextAlign.start,
                                              ),
                                              if (_bloc.totalDebtOtherFuel > 0)
                                                Text(
                                                  "Tổng nợ nhớt: ${AppConstants.moneyFormat.format(_bloc.totalDebtOtherFuel)} (vnd/Lit)",
                                                  style: labelTextStyle,
                                                  textAlign: TextAlign.start,
                                                ),
                                              Text(
                                                "Thực nhận: ${AppConstants.moneyFormat.format(_bloc.actuallyReceived)} vnd",
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
                            stream: _bloc.onCanSaveResult.stream,
                            initialData: false,
                            builder: (context, snapshot) {
                              return NormalButton(
                                onTap: () => _bloc.clickSaveResult(context),
                                buttonName: "Lưu kết quả",
                                canClick: snapshot.data!,
                              );
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  : Container();
            }),
      ),
    );
  }

  Widget debtShowList() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: _bloc.debtList.map((e) {
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
