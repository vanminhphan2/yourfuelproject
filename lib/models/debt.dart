import 'fuel_price.dart';

class Debt {
  int id;
  int idDailyCheck;
  String debtorName;
  FuelPrice fuelType;
  int value;
  String engineOilName;

  Debt(
      {required this.id,
      required this.idDailyCheck,
      required this.debtorName,
      required this.fuelType,
      required this.value,
      this.engineOilName = ""});

  Map<String, dynamic> toJson() => {
        "id": id,
        "idDailyCheck": idDailyCheck,
        "debtorName": debtorName,
        "fuelType": fuelType.toJson(),
        "value": value,
        "engineOilName": engineOilName
      };

  factory Debt.fromJson(json) {
    return Debt(
        id: json["id"] ?? 0,
        idDailyCheck: json["idDailyCheck"] ?? 0,
        debtorName: json["debtorName"] ?? "",
        fuelType: FuelPrice.fromJson(json["fuelType"]),
        value: json["value"] ?? 0,
        engineOilName: json["engineOilName"] ?? "");
  }

  @override
  String toString() {
    return 'Debt{id: $id, idDailyCheck: $idDailyCheck, debtorName: $debtorName, fuelType: $fuelType, value: $value, engineOilName: $engineOilName}';
  }

  int getValue() {
    if (fuelType.type == 0) return value;
    if (fuelType.type == 1) return 0;
    return value * fuelType.price;
  }
}
