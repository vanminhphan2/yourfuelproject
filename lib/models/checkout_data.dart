import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/fuel_station.dart';

class CheckOutData{
  int id;
  int numberCheckout;
  int totalSale;
  int totalDebt;
  int actuallyReceived;
  String date;
  List<Debt> debtList;
  List<FuelPrice> fuelPriceList;
  List<FuelStation> fuelStationList;

  CheckOutData({
      required this.id,
      required this.numberCheckout,
      required this.totalSale,
      required this.totalDebt,
      required this.actuallyReceived,
      required this.date,
      required this.debtList,
      required this.fuelPriceList,
      required this.fuelStationList});

  Map<String, dynamic> toJson() => {
    "id": id,
    "numberCheckout": numberCheckout,
    "totalSale": totalSale,
    "totalDebt": totalDebt,
    "actuallyReceived": actuallyReceived,
    "date": date,
    "debtList": debtList,
    "fuelPriceList": fuelPriceList,
    "fuelStationList": fuelStationList
  };

  factory CheckOutData.fromJson(json) {
    return CheckOutData(
        id: json["id"] ?? 0,
        numberCheckout: json["numberCheckout"] ?? 1,
        totalSale: json["totalSale"] ?? 0,
        totalDebt: json["totalDebt"] ?? 0,
        actuallyReceived: json["actuallyReceived"] ?? 0,
      date: json["date"] ?? 0,
      debtList: json["debtList"],
      fuelPriceList: json["fuelPriceList"],
      fuelStationList: json["fuelStationList"],);
  }


}