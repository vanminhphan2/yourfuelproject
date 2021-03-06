import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/generated/l10n.dart';
import 'package:yourfuel/models/checkout_data.dart';
import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/fuel_station.dart';
import 'package:yourfuel/provider/base_provider.dart';
import 'package:yourfuel/service/firebase.dart';

class CheckOutBlock {
  final onGetData = PublishSubject<bool>();
  final onClickChangePrice = PublishSubject<bool>();
  final onClickChangeData = PublishSubject<bool>();
  final onClickChangeOldElectronicNumber = PublishSubject<bool>();
  final onClickDebtListener = PublishSubject<List<Debt>>();
  final onClickCalculateListener = PublishSubject<bool>();
  final onCanSaveResult = PublishSubject<bool>();

  List<Debt> debtList = [];

  final List<FuelStation> fuelStationList = [];
  List<FuelPrice> fuelPriceList = [];

  var totalSale = 0;
  var totalDebt = 0;
  var totalDebtOtherFuel = 0;
  var actuallyReceived = 0;

  bool isChangingPrice = false;
  bool isChangingOldElectronicNumber = false;
  bool isChangingData = false;

  Future<void> getData() async {
    try {
      appController.loading.show();

      final stationList = await FireBase().getStationsUser();
      List<FuelPrice> fuelPrices = await FireBase().getPriceList();

      // print("rio2444 => ${listData.toString()}");
      stationList.sort((a, b) => a.type.compareTo(b.type));
      fuelStationList.addAll(stationList);

      if (fuelPrices.isEmpty) {
        fuelPrices = initPriceListByStations();
      }
      fuelPrices.insert(0, FuelPrice(type: 1, price: 0, name: "Other fuel"));
      fuelPrices.insert(0, FuelPrice(type: 0, price: 0, name: "vnd"));

      fuelPriceList.addAll(fuelPrices);
      appController.loading.hide();
      onGetData.add(true);
    } catch (e) {
      appController.loading.hide();
      print(e.toString());
    }
  }

  List<FuelPrice> initPriceListByStations() {
    List<FuelPrice> list = [];
    for (var e in fuelStationList) {
      if (list.isEmpty) {
        list.add(FuelPrice(type: e.type, price: 0, name: e.typeName));
      } else if (!list.any((element) => element.type == e.type)) {
        list.add(FuelPrice(type: e.type, price: 0, name: e.typeName));
      }
    }

    return list;
  }

  void clickChangePrice() async {
    bool _hasEmpty = false;
    if (isChangingPrice) {
      //neu dang thay doi => luu thay doi
      _hasEmpty = fuelPriceList
          .any((element) => element.type > 1 && element.price <= 0);

      if (!_hasEmpty) {
        //save to server

        appController.loading.show();
        await FireBase()
            .updateFuelPrices(
                fuelPriceList.skipWhile((value) => value.type <= 1).toList())
            .whenComplete(() => appController.loading.hide());

        isChangingPrice = false;
        onClickChangePrice.add(isChangingPrice); // doi lai UI

        //set can click calculate
        if (!isChangingOldElectronicNumber) {
          isChangingData = false;
          onClickChangeData.add(isChangingData);
        }
      } else {
        appController.dialog.showDefaultDialog(
            title: S.of(mainContext).Notify, message: "Nhap gia xang dau!");
      }
    } else {
      //dang khong thay doi=> co the thay doi
      isChangingPrice = true;
      onClickChangePrice.add(isChangingPrice);

      isChangingData = true;
      onClickChangeData.add(isChangingData);
    }
  }

  void clickChangeOldElectronicNumber() async {
    if (isChangingOldElectronicNumber) {
      //neu dang thay doi => luu thay doi

      try {
        //save to server

        await FireBase()
            .updateStationUser(fuelStationList, false)
            .whenComplete(() => appController.loading.hide());

        isChangingOldElectronicNumber = false;
        onClickChangeOldElectronicNumber
            .add(isChangingOldElectronicNumber); // doi lai UI

        //set can click calculate
        if (!isChangingPrice) {
          isChangingData = false;
          onClickChangeData.add(isChangingData);
        }
      } catch (e) {
        appController.loading.hide();
        print(e.toString());
      }
    } else {
      //dang khong thay doi=> co the thay doi
      isChangingOldElectronicNumber = true;
      onClickChangeOldElectronicNumber.add(isChangingOldElectronicNumber);

      isChangingData = true;
      onClickChangeData.add(isChangingData);
    }
  }

  void clickCalculate() {
    print("_onClickCalculate");
    if (fuelPriceList
        .any((element) => element.type > 1 && element.price <= 0)) {
      appController.dialog.showDefaultDialog(
          title: S.of(mainContext).Notify, message: "Nhap gia xang dau!");
      return;
    }
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

  void checkForCanClickSave() {
    fuelPriceList.skipWhile((value) => value.type <= 1).forEach((element) {
      int totalFuelByType = getTotalFuelByType(element);
      int totalMoneyByType = totalFuelByType * element.price;

      totalSale = totalSale + totalMoneyByType;
    });

    actuallyReceived = totalSale - totalDebt;
    onCanSaveResult.add(totalSale > 0);
  }

  void addDebt() {
    debtList.add(Debt(
        id: debtList.length + 1,
        idDailyCheck: 1,
        debtorName: "",
        fuelType: fuelPriceList.first,
        value: 0));
    onClickDebtListener.add(debtList);
  }

  void removeDebt(List<Debt> debtList, int id) {
    debtList.removeWhere((element) => element.id == id);

    onClickDebtListener.add(debtList);
  }

  int getPrice(int type) {
    return fuelPriceList.firstWhere((element) => element.type == type).price;
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

  void clickSaveResult(BuildContext context) async {
    print("clickSaveResult");
    //save data

    appController.dialog.showCallbackDialog(
        title: S.of(context).Notify,
        message: "S??? tho??t sau khi l??u! B???n mu???n l??u kh??ng?",
        callback: () async {
          try {
            appController.loading.show();
            final date = DateTime.now();
            final daytime =
                "${date.day.toString().padLeft(2, "0")}/${date.month.toString().padLeft(2, "0")}/${date.year}";

            final list = await FireBase().getCheckoutListByDate(daytime);
            print("rio => ${list.toString()}");

            int numberCheck = (list.isEmpty) ? 1 : list.length + 1;
            final dataCheckout = CheckOutData(
                id: 1,
                numberCheckout: numberCheck,
                totalSale: totalSale,
                totalDebt: totalDebt,
                actuallyReceived: actuallyReceived,
                date: daytime,
                debtList: debtList,
                fuelPriceList: fuelPriceList
                    .skipWhile((value) => value.type <= 1)
                    .toList(),
                fuelStationList: fuelStationList);
            await FireBase().addCheckoutData(dataCheckout,date.millisecondsSinceEpoch);

            fuelStationList.forEach((e) {
              e.oldElectronicNumber = e.newElectronicNumber;
              e.newElectronicNumber = 0;
              e.engineNumber = 0;
            });

            await FireBase().updateStationUser(fuelStationList, false);

            ScaffoldMessenger.of(mainContext).showSnackBar(
                SnackBar(content: Text(S.of(mainContext).Result_saved)));
            appController.loading.hide();
            Navigator.of(context).pop();
          } catch (e) {
            appController.loading.hide();
            print("rio error: " + e.toString());
          }
        });
  }

  void dispose() {
    onGetData.close();
  }
}
