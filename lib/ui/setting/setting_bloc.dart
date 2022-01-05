import 'package:rxdart/rxdart.dart';
import 'package:yourfuel/controller/app_controller.dart';
import 'package:yourfuel/models/fuel_station.dart';
import 'package:yourfuel/service/firebase.dart';

class SettingBloc {
  final List<FuelStation> yourStations = [];
  final List<FuelStation> stations = [];

  final onYourFuelStationChange = PublishSubject<List<FuelStation>>();
  final onStationsChange = PublishSubject<List<FuelStation>>();
  final onGetData = PublishSubject<bool>();
  final onVisibleIconToHome = PublishSubject<bool>();

  void getData()async{

    appController.loading.show();
    final listData= await FireBase().getStationsUser();

    final listStationDefault= await FireBase().getStationsDefault();

    // print("rio2444 => ${listData.toString()}");
    yourStations.addAll(listData);
    stations.addAll(listStationDefault);
    appController.loading.hide();
    onGetData.add(true);
  }

  void removeStation(int index) async {
    if (yourStations.length > 1) {
      appController.dialog.showCallbackDialog(
          title: "Thong bao!",
          message: "Are you sure to remove?",
          callback: () async {
            appController.loading.show();

            yourStations.removeAt(index);
            await FireBase()
                .updateStationUser(yourStations,false)
                .whenComplete(() => appController.loading.hide());

            onYourFuelStationChange.add(yourStations);
          });
    }
  }

  void addFuelStations() async {
    print("_addFuelStations CLick");
    if (stations.any((element) => element.totalStation > 0)) {
      appController.dialog.showCallbackDialog(
          title: "Thong bao!",
          message: "Are you sure to add?",
          callback: () async {
            for (var element in stations) {
              if (element.totalStation > 0) {
                List<FuelStation> newList = List<FuelStation>.generate(
                    element.totalStation,
                    (index) => FuelStation(
                        id: ((yourStations.isNotEmpty)?yourStations.last.id:0) + index+1,
                        type: element.type,
                        typeName: element.typeName,
                        fullTypeName: element.fullTypeName,
                        numberStation:
                            getNumberStation(element, index + 1))).toList();

                yourStations.addAll(newList);
              }
            }
            appController.loading.show();
            await FireBase()
                .updateStationUser(yourStations,true)
                .whenComplete(() => appController.loading.hide());

            stations.forEach((element) {
              element.totalStation = 0;
            });

            onStationsChange.add(stations);
            onYourFuelStationChange.add(yourStations);
            onVisibleIconToHome.add(true);
          });
    }
  }

  int getNumberStation(FuelStation element, int count) {
    if (yourStations.isEmpty) {
      return count;
    }

    if (yourStations.any((e) {
      if (e.type == element.type) return true;
      return false;
    })) {
      return yourStations
              .lastWhere((e) => e.type == element.type)
              .numberStation +
          count;
    }
    return count;
  }

  void dispose(){
    onYourFuelStationChange.close();
    onStationsChange.close();
    onGetData.close();
    onVisibleIconToHome.close();
  }
}
