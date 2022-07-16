// To parse this JSON data, do
//
//     final taskMango = taskMangoFromJson(jsonString);

import 'dart:convert';

TaskMango taskMangoFromJson(String str) => TaskMango.fromJson(json.decode(str));

String taskMangoToJson(TaskMango data) => json.encode(data.toJson());

class TaskMango {
  TaskMango({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.eventdate,
    required this.duedate,
    required this.eventtime,
    required this.duetime,
    required this.faculty,
  });

  String id;
  String category;
  String title;
  String description;
  String eventdate;
  String duedate;
  String eventtime;
  String duetime;
  String faculty;

  factory TaskMango.fromJson(Map<String, dynamic> json) => TaskMango(
    id: json["_id"],
    category: json["category"],
    title: json["title"],
    description: json["description"],
    eventdate: json["eventdate"],
    duedate: json["duedate"],
    eventtime: json["eventtime"],
    duetime: json["duetime"],
    faculty: json["faculty"],
  );

  Map<String, dynamic> toJson() =>
      {
        "_id": id,
        "category": category,
        "title": title,
        "description": description,
        "eventdate": eventdate,
        "duedate": duedate,
        "eventtime": eventtime,
        "duetime": duetime,
      };
}