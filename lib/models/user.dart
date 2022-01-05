class User {
  String phone;
  String name;
  String pass;
  String createDate;
  bool hasBeenSet;

  User(
      {this.phone = "",
      this.name = "",
      this.createDate = "",
      this.pass = "",
      this.hasBeenSet = false});

  static User instance = User();

  Map<String, dynamic> toJson() => {
        "createDate": createDate,
        "phone": phone,
        "pass": pass,
        "hasBeenSet": hasBeenSet
      };

  factory User.fromJson(json) {
    return User(
        phone: json["phone"] ?? "",
        name: json["name"] ?? "",
        pass: json["pass"] ?? "",
        createDate: json["createDate"] ?? "",
        hasBeenSet: json["hasBeenSet"] ?? false);
  }

  @override
  String toString() {
    return 'User{phone: $phone, name: $name, pass: $pass, createDate: $createDate, hasBeenSet: $hasBeenSet}';
  }
}
