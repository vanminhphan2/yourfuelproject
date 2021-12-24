class User{

  String phone;
  String name;
  String pass;
  String createDate;

  User({this.phone="", this.name="",this.createDate="",this.pass=""});

  Map<String, dynamic> toJson()=> {
    "createDate":createDate,
    "pass":pass
  };

  factory User.fromJson(json){
    return User(
      phone: json["phone"]??"",
      name: json["name"]??"",
      pass: json["pass"]??"",
      createDate: json["createDate"]??""
    );
  }

  @override
  String toString() {
    return 'User{phone: $phone, name: $name, pass: $pass, createDate: $createDate}';
  }
}