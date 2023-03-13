class Account {
  Account({
    required this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.phone,
  });
  String id;
  String name;
  String username;
  String password;
  String phone;

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        password: json["password"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "password": password,
        "phone": phone,
      };
}
