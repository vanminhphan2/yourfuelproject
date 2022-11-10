import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/generated/l10n.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/nhap_kho_data.dart';
import 'package:yourfuel/provider/base_provider.dart';
import 'package:yourfuel/service/firebase.dart';
import 'package:intl/intl.dart';

class NhapKhoBloc {
  final today = DateTime.now();
  DateTime currentDay = DateTime.now();
  final onChangeDate = PublishSubject<String>();
  final onChangeFuelType = PublishSubject<FuelPrice>();
  var itemNhapKho = NhapKhoData();
  List<FuelPrice> fuelPriceList = [];

  FuelPrice? dropdownValue;

  Future<void> getData() async {
    List<FuelPrice> fuelPrices = await FireBase().getPriceList();
    itemNhapKho.date=DateFormat('dd-MM-yyyy').format(currentDay);
    fuelPriceList.addAll(fuelPrices);
    dropdownValue = fuelPriceList.first;
    onChangeFuelType.add(dropdownValue!);
  }

  Future<void> onSave(BuildContext context) async {
    if (dropdownValue != null) {
      appController.dialog.showCallbackDialog(
          title: S.of(context).Notify,
          message: "Sẽ thoát sau khi lưu! Bạn muốn lưu không?",
          callback: () async {
            try {
              appController.loading.show();

              itemNhapKho.type = dropdownValue!.type;
              itemNhapKho.typeName = dropdownValue!.name;
              await FireBase().addImportFuelData(
                  itemNhapKho, currentDay.millisecondsSinceEpoch);

              ScaffoldMessenger.of(mainContext).showSnackBar(
                  SnackBar(content: Text(S.of(mainContext).Result_saved)));
              appController.loading.hide();
            } catch (e) {
              appController.loading.hide();
              print("rio error: " + e.toString());
            }
          });
    }
  }
}
