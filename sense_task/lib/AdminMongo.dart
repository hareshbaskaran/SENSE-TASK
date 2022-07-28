import 'dart:convert';

AdminMongo adminMongoFromJson(String str) => AdminMongo.fromJson(json.decode(str));

String adminMongoToJson(AdminMongo data) => json.encode(data.toJson());

class AdminMongo {
  AdminMongo({
    required this.id,
    required this.username,
    required this.password,
  });

  String id;
  String username;
  String password;

  factory AdminMongo.fromJson(Map<String, dynamic> json) => AdminMongo(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "password": password,
  };
}