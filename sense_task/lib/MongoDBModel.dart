import 'dart:convert';
import 'package:mongo_dart/mongo_dart.dart';

MangoDbModel mangoDbModelFromJson(String str) => MangoDbModel.fromJson(json.decode(str));

String mangoDbModelToJson(MangoDbModel data) => json.encode(data.toJson());

class MangoDbModel {
  MangoDbModel({
    required this.id,
    required this.username,
    required this.password,
  });

  ObjectId id;
  String username;
  String password;

  factory MangoDbModel.fromJson(Map<String, dynamic> json) => MangoDbModel(
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
