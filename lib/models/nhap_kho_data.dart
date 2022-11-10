class NhapKhoData {
  int id;
  String date;
  int type;
  String typeName;
  int soLuong;
  int giaNhap;

  NhapKhoData({this.id=0, this.date="", this.type=0, this.typeName="", this.soLuong=0,
      this.giaNhap=0});


  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "type": type,
    "typeName": typeName,
    "soLuong": soLuong,
    "giaNhap": giaNhap,};
  factory NhapKhoData.fromJson(json) {
    return NhapKhoData(
        id: json["id"] ?? 0,
        date: json["date"] ?? "",
        type: json["type"] ?? 0,
        typeName: json["typeName"] ?? "",
        soLuong: json["soLuong"] ?? 0,
        giaNhap: json["giaNhap"] ?? 0);}
}
