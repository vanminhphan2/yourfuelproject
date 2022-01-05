class FuelStation {
  int id;
  int type; //0: Tien mat, 1: Other Fuel, 2: diesel DO 0,005%S, 3: diesel DO 0,25%S, 4: Gasoline A92, 5: Gasoline A95,6: Gasoline E5
  int oldElectronicNumber;
  int newElectronicNumber;
  int engineNumber;
  int numberStation;
  int totalStation;
  String typeName;
  String fullTypeName;

  FuelStation({this.id =0, this.type=1, this.oldElectronicNumber=0,
      this.newElectronicNumber=0, this.engineNumber=0, this.numberStation=0,this.totalStation=0,this.fullTypeName="",this.typeName=""});

  @override
  String toString() {
    return 'FuelStation{id: $id, type: $type, oldElectronicNumber: $oldElectronicNumber, newElectronicNumber: $newElectronicNumber, engineNumber: $engineNumber, numberStation: $numberStation, totalStation: $totalStation, typeName: $typeName, fullTypeName: $fullTypeName}';
  }


  Map<String, dynamic> toJson()=> {
    "id":id,
    "type":type,
    "oldElectronicNumber":oldElectronicNumber,
    "newElectronicNumber":newElectronicNumber,
    "engineNumber":engineNumber,
    "numberStation":numberStation,
    "totalStation":totalStation,
    "typeName":typeName,
    "fullTypeName":fullTypeName,
  };

  factory FuelStation.fromJson(json){
    return FuelStation(
        id: json["id"]??"",
        type: json["type"]??"",
        oldElectronicNumber: json["oldElectronicNumber"]??"",
        newElectronicNumber: json["newElectronicNumber"]??"",
        engineNumber: json["engineNumber"]??"",
        numberStation: json["numberStation"]??"",
        totalStation: json["totalStation"]??"",
        typeName: json["typeName"]??"",
        fullTypeName: json["fullTypeName"]??""
    );
  }
}
