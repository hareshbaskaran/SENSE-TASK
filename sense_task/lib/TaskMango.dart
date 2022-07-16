// To parse this JSON data, do
//
//     final taskMango = taskMangoFromJson(jsonString);

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

TaskMango taskMangoFromJson(String str) => TaskMango.fromJson(json.decode(str));

String taskMangoToJson(TaskMango data) => json.encode(data.toJson());

class TaskMango {
  TaskMango({
    required this.id,
    required this.categorydb,
    required this.titledb,
    required this.descriptiondb,
    required this.startdatedb,
    required this.enddatedb,
    required this.duedatedb,
    required this.duetimedb,
    required this.facultydb,
  });

  ObjectId id;
  String categorydb;
  String titledb;
  String descriptiondb;
  String startdatedb;
  String enddatedb;
  String duedatedb;
  String duetimedb;
  String facultydb;

  factory TaskMango.fromJson(Map<String, dynamic> json) => TaskMango(
    id: json["_id"],
    categorydb: json["category"],
    titledb: json["title"],
    descriptiondb: json["description"],
    startdatedb: json["startdate"],
    enddatedb: json["enddate"],
    duedatedb: json["duedate"],
    duetimedb: json["duetime"],
    facultydb: json["faculty"],
  );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "category": categorydb,
        "title": titledb,
        "description": descriptiondb,
        "startdate": startdatedb,
        "enddate": enddatedb,
        "duedate": duedatedb,
        "duetime": duetimedb,
        "faculty":facultydb,
      };
}