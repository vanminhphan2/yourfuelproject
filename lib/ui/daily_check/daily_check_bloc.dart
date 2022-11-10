import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/models/checkout_data.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/fuel_station.dart';
import 'package:yourfuel/service/firebase.dart';

class DailyCheckBloc{

  final today= DateTime.now();
  DateTime currentDay= DateTime.now();
  final onGetData= PublishSubject<List<CheckOutData>>();
  final onChangeTitleDay= PublishSubject<DateTime>();


  Future<void> getData(DateTime dayTime)async{

    appController.loading.show();
    String getDay= "${dayTime.day.toString().padLeft(2, "0")}/${dayTime.month.toString().padLeft(2, "0")}/${dayTime.year}";

    final listCheckoutData= await FireBase().getCheckoutListByDate(getDay);
    appController.loading.hide();
    onGetData.add(listCheckoutData);
  }


  int getTotalFuelByType(FuelPrice item, List<FuelStation> fuelStationList ) {
    int total = 0;
    for (var e in fuelStationList) {
      if (e.type == item.type) {
        total = total + (e.newElectronicNumber - e.oldElectronicNumber);
      }
    }
    return total;
  }
}