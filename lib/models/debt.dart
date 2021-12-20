import 'fuel_price.dart';

class Debt {
  int id;
  int idDailyCheck;
  String debtorName;
  FuelPrice fuelType;
  int value;
  String engineOilName;

  Debt(this.id, this.idDailyCheck, this.debtorName, this.fuelType,
      this.value, this.engineOilName);

  @override
  String toString() {
    return 'Debt{id: $id, idDailyCheck: $idDailyCheck, debtorName: $debtorName, fuelType: $fuelType, value: $value, engineOilName: $engineOilName}';
  }

  int getValue() {
    if(fuelType.type==0) return value;
    if(fuelType.type==1) return 0;
    return value* fuelType.price;
  }
}
