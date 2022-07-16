import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';
///formatted json to a dart class from quicktype.io
UserMango UserMangoFromJson(String str) => UserMango.fromJson(json.decode(str));

String mangoDbModelToJson(UserMango data) => json.encode(data.toJson());

class UserMango {
  UserMango({
    required this.id,
    required this.username,
    required this.password,
  });

  ObjectId id;
  String username;
  String password;

  factory UserMango.fromJson(Map<String, dynamic> json) => UserMango(
    id: json["_id"],
    username: json["username"],
    password: json["password"],
    /// TODO : ADD THE GIVEN STRINGS LIKE ID,USERNAME,PASSWORD as given
    /// TODO: ALSO MAP TO JSON
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "username": username,
    "password": password,
  };
}
