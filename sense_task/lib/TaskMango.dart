// To parse this JSON data, do
//
//     final taskMango = taskMangoFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

TaskMongo taskMangoFromJson(String str) => TaskMongo.fromJson(json.decode(str));

String taskMangoToJson(TaskMongo data) => json.encode(data.toJson());

class TaskMongo {
  TaskMongo({
    required this.id_t,
    required this.categorydb,
    required this.titledb,
    required this.descriptiondb,
    required this.startdatedb,
    required this.enddatedb,
    required this.duedatedb,
    required this.duetimedb,
    required this.facultydb,
  });

  ObjectId id_t;
  String categorydb;
  String titledb;
  String descriptiondb;
  String startdatedb;
  String enddatedb;
  String duedatedb;
  String duetimedb;
  String facultydb;

  factory TaskMongo.fromJson(Map<String, dynamic> json) => TaskMongo(
        id_t: json["_id"],
        categorydb: json["category"],
        titledb: json["title"],
        descriptiondb: json["description"],
        startdatedb: json["startdate"],
        enddatedb: json["enddate"],
        duedatedb: json["duedate"],
        duetimedb: json["duetime"],
        facultydb: json["faculty"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id_t,
        "category": categorydb,
        "title": titledb,
        "description": descriptiondb,
        "startdate": startdatedb,
        "enddate": enddatedb,
        "duedate": duedatedb,
        "duetime": duetimedb,
        "faculty": facultydb,
      };
}
