class FuelPrice {
  int
      type; //0: TIEN MAT; 1:other fuel
  int price;
  String name;


  FuelPrice({this.type=0, this.price=0, this.name=""});

  @override
  String toString() {
    return 'FuelPrice{type: $type, price: $price, name: $name}';
  }


  Map<String, dynamic> toJson()=> {
    "type":type,
    "price":price,
    "name":name
  };

  factory FuelPrice.fromJson(json){
    return FuelPrice(
        type: json["type"]??0,
        price: json["price"]??0,
        name: json["name"]??""
    );
  }
}
