class FuelPrice {
  int
      type; //0: TIEN MAT; 1:other fuel
  int price;
  String name;


  FuelPrice(this.type, this.price, this.name);

  @override
  String toString() {
    return 'FuelPrice{type: $type, price: $price, name: $name}';
  }
}
