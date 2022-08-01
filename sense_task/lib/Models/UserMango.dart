import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
///formatted json to a dart class from quicktype.io
UserMongo UserMangoFromJson(String str) => UserMongo.fromJson(json.decode(str));

String mangoDbModelToJson(UserMongo data) => json.encode(data.toJson());

class UserMongo {
  UserMongo({
    required this.id,
    required this.username,
    required this.password,
  });

  ObjectId id;
  String username;
  String password;

  factory UserMongo.fromJson(Map<String, dynamic> json) => UserMongo(
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
