import 'package:yourfuel/models/debt.dart';
import 'package:yourfuel/models/fuel_price.dart';
import 'package:yourfuel/models/fuel_station.dart';

class CheckOutData {
  int id;
  int numberCheckout;
  int totalSale;
  int totalDebt;
  int actuallyReceived;
  int totalDebtOtherFuel;
  String date;
  List<Debt> debtList;
  List<FuelPrice> fuelPriceList;
  List<FuelStation> fuelStationList;

  CheckOutData(
      {required this.id,
      required this.numberCheckout,
      required this.totalSale,
      required this.totalDebt,
      required this.actuallyReceived,
      required this.date,
        required this.debtList,
        required this.totalDebtOtherFuel,
      required this.fuelPriceList,
      required this.fuelStationList});

  Map<String, dynamic> toJson() => {
        "id": id,
        "numberCheckout": numberCheckout,
        "totalSale": totalSale,
    "totalDebt": totalDebt,
    "totalDebtOtherFuel": totalDebtOtherFuel,
        "actuallyReceived": actuallyReceived,
        "date": date,
        "debtList":
            (debtList.isEmpty) ? [] : debtList.map((e) => e.toJson()).toList(),
        "fuelPriceList": (fuelPriceList.isEmpty)
            ? []
            : fuelPriceList.map((e) => e.toJson()).toList(),
        "fuelStationList": (fuelStationList.isEmpty)
            ? []
            : fuelStationList.map((e) => e.toJson()).toList()
      };

  factory CheckOutData.fromJson(json) {
    return CheckOutData(
        id: json["id"] ?? 0,
        numberCheckout: json["numberCheckout"] ?? 1,
        totalSale: json["totalSale"] ?? 0,
        totalDebt: json["totalDebt"] ?? 0,
        totalDebtOtherFuel: json["totalDebtOtherFuel"] ?? 0,
        actuallyReceived: json["actuallyReceived"] ?? 0,
        date: json["date"] ?? "",
        debtList: List<Debt>.from(json["debtList"].map((e) => Debt.fromJson(e)))
            .toList(),
        fuelPriceList: List<FuelPrice>.from(
            json["fuelPriceList"].map((e) => FuelPrice.fromJson(e))).toList(),
        fuelStationList: List<FuelStation>.from(
                json["fuelStationList"].map((e) => FuelStation.fromJson(e)))
            .toList());
  }

  @override
  String toString() {
    return 'CheckOutData{id: $id, numberCheckout: $numberCheckout, totalSale: $totalSale, totalDebt: $totalDebt, actuallyReceived: $actuallyReceived, totalDebtOtherFuel: $totalDebtOtherFuel, date: $date, debtList: $debtList, fuelPriceList: $fuelPriceList, fuelStationList: $fuelStationList}';
  }
}
