import 'package:flutter/material.dart';
import 'package:yourfuel/generated/l10n.dart';
import 'package:yourfuel/models/checkout_data.dart';
import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/provider/base_provider.dart';
import 'package:yourfuel/ui/daily_check/daily_check_bloc.dart';
import 'package:yourfuel/utils/app_utils.dart';
import 'package:intl/intl.dart';

class DailyCheckPage extends StatelessWidget {
  DailyCheckPage({Key? key}) : super(key: key);

  final _bloc = DailyCheckBloc();

  late TextStyle labelTextStyle;
  late TextStyle normalTextStyle;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      _bloc.getData(_bloc.today);
    });

    labelTextStyle = const TextStyle(
        fontWeight: FontWeight.bold, color: AppColors.black, fontSize: 17);
    normalTextStyle = const TextStyle(
        fontWeight: FontWeight.normal, color: AppColors.black, fontSize: 15);

    return Scaffold(
        backgroundColor: AppColors.pinkLightPurple,
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: StreamBuilder<DateTime>(
            stream: _bloc.onChangeTitleDay.stream,
            initialData: _bloc.today,
            builder: (context, snapshot) {
              return Text("${S.of(context).CheckDay}: ${DateFormat('dd-MM-yyyy').format(snapshot.data!)}");
            }
          ),
          backgroundColor: AppColors.primaryColor,
          actions: [IconButton(onPressed: (){
            _selectDate(context);


          }, icon: const Icon(Icons.calendar_today, color: AppColors.white,))],
        ),
        body: StreamBuilder<List<CheckOutData>>(
          initialData: const [],
          stream: _bloc.onGetData.stream,
          builder: (context, snapshot) {
            return (snapshot.data!.isEmpty)
                ? Container(alignment: Alignment.center,child:const Text("Không có dũ liệu ngày này!"),)
                : dataUI(snapshot.data!);
          },
        ));
  }

  Widget dataUI(List<CheckOutData> data) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          for (int item = 0; item < data.length; item++)
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
                          "Lần chốt ${data[item].numberCheckout}:",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (int i = 0;
                              i < data[item].fuelStationList.length;
                              i++)
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[item].fuelStationList[i].fullTypeName +
                                      " ${S.of(mainContext).Station_number} " +
                                      data[item]
                                          .fuelStationList[i]
                                          .numberStation
                                          .toString() +
                                      ":",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.black,
                                      fontSize: 17),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "${S.of(mainContext).Electronic}: " +
                                      data[item]
                                          .fuelStationList[i]
                                          .newElectronicNumber
                                          .toString() +
                                      " - " +
                                      data[item]
                                          .fuelStationList[i]
                                          .oldElectronicNumber
                                          .toString() +
                                      " = " +
                                      (data[item]
                                                  .fuelStationList[i]
                                                  .newElectronicNumber -
                                              data[item]
                                                  .fuelStationList[i]
                                                  .oldElectronicNumber)
                                          .toString() +
                                      " Lít",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black,
                                      fontSize: 15),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  "${S.of(mainContext).Engine}: " +
                                      data[item]
                                          .fuelStationList[i]
                                          .engineNumber
                                          .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: AppColors.black,
                                      fontSize: 15),
                                  textAlign: TextAlign.start,
                                ),

                              ],
                            )
                        ],
                      ),
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
                          children: data[item].fuelPriceList
                              .skipWhile((value) =>
                          value.type <= 1)
                              .map((e) {
                            int totalFuelByType = _bloc
                                .getTotalFuelByType(e,data[item].fuelStationList);
                            int totalMoneyByType =
                                totalFuelByType *
                                    e.price;
                            return Text(
                              "${e.name}: ${totalFuelByType.toString()} L = ${AppConstants.moneyFormat.format(totalMoneyByType)} vnd",
                              style: normalTextStyle,
                              textAlign:
                              TextAlign.start,
                            );
                          }).toList(),
                        ),
                      ),
                      if (data[item].totalDebt > 0 ||
                          data[item].totalDebtOtherFuel > 0)
                        Text(
                          "Nợ:",
                          style: labelTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      if (data[item].totalDebt > 0 ||
                          data[item].totalDebtOtherFuel > 0)
                        debtShowList(data[item].debtList),
                      Text(
                        "Doanh thu: ${AppConstants.moneyFormat.format(data[item].totalSale)} vnd",
                        style: labelTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Tổng nợ xăng dầu: ${AppConstants.moneyFormat.format(data[item].totalDebt)} vnd",
                        style: labelTextStyle,
                        textAlign: TextAlign.start,
                      ),
                      if (data[item].totalDebtOtherFuel > 0)
                        Text(
                          "Tổng nợ nhớt: ${AppConstants.moneyFormat.format(data[item].totalDebtOtherFuel)} (vnd/Lit)",
                          style: labelTextStyle,
                          textAlign: TextAlign.start,
                        ),
                      Text(
                        "Thực nhận: ${AppConstants.moneyFormat.format(data[item].actuallyReceived)} vnd",
                        style: labelTextStyle,
                        textAlign: TextAlign.start,
                      ),
                    ]),
              ),
            ),
        ],
      ),
    );
  }

  Widget debtShowList(List<Debt> debtList) {
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

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
        context: context,
        initialDate: _bloc.currentDay,
        firstDate: DateTime(2022),
        lastDate: DateTime(2025));
    if(picked!=null){
      print("rio get date: "+picked.day.toString());
      _bloc.currentDay=picked;
      _bloc.onChangeTitleDay.add(picked);
      _bloc.getData(picked);
    }
  }
}
