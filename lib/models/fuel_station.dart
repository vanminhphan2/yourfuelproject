class FuelStation {
  int id;
  int type; //1: diesel DO 0,005%S, 2: diesel DO 0,25%S, 3: Gasoline A92, 4: Gasoline A95,5: Gasoline E5
  int oldElectronicNumber;
  int newElectronicNumber;
  int engineNumber;
  int numberStation;

  String fullTypeName() {
    switch (type) {
      case 1:
        return "Diesel 0,05%S station ";
      case 2:
        return "Diesel 0,025%S station ";
      case 3:
        return "Gasoline A92 station ";
      case 4:
        return "Gasoline A95 station ";
      case 5:
        return "Gasoline E5 station ";
      default:
        return "Diesel 0,05%S station ";
    }
  }

  String compactTypeName() {
    switch (type) {
      case 1:
        return "DO 05 S";
      case 2:
        return "DO 025 S";
      case 3:
        return "A92 S";
      case 4:
        return "A95 S";
      case 5:
        return "E5 S";
      default:
        return "DO 05 S";
    }
  }

  FuelStation({this.id =0, this.type=1, this.oldElectronicNumber=0,
      this.newElectronicNumber=0, this.engineNumber=0, this.numberStation=0});
}
