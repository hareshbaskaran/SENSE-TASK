import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/TaskMango.dart';
import 'package:sense_task/UserMango.dart';
import 'dart:developer';
import 'constant.dart';
import 'AssignTask_Admin.dart';

class MongoDbModel {
  static var db, usercollection, taskcollection, admincollection;
  static connect() async {
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    usercollection = db.collection(USER_COLLECTION);
    taskcollection = db.collection(TASK_COLLECTION);
    admincollection = db.collection(ADMIN_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getTask() async {
    final arrtask = await taskcollection.find().toList();
    return arrtask;
  }

  static Future<List<Map<String, dynamic>>> getQuerryTask() async {
    final querry_data = await taskcollection
        .find(where.eq('faculty', '$username_user'))
        .toList();
    return querry_data;
  }

  static Future<List<Map<String, dynamic>>> getAdmin() async {
    final admin_data = await admincollection
        .find(where
            .eq('username', '$username_admin')
            .eq('password', '$password_admin'))
        .toList();
    return admin_data;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    final user_data = await usercollection
        .find(where
            .eq('username', '$username_user')
            .eq('password', '$password_user'))
        .toList();
    return user_data;
  }

  static Future<void> update_task(TaskMongo task_data) async {
    var result = await taskcollection.findOne({"_id": task_data?.id_t});
    print(result);
    result['category'] = task_data?.categorydb;
    result['title'] = task_data?.titledb;
    result['description'] = task_data?.descriptiondb;
    result['startdate'] = task_data?.startdatedb;
    result['enddate'] = task_data?.enddatedb;
    result['duetime'] = task_data?.duetimedb;
    result['faculty'] = task_data?.facultydb;
    var response = await taskcollection.save(result);

    inspect(response);
  }

  static delete_task(TaskMongo task_delete) async {
    await taskcollection.remove(where.id(task_delete.id_t));
  }

  static Future<String> insert_task(TaskMongo task_data) async {
    print(task_data);
    try {
      var result = await taskcollection.insertOne(task_data.toJson());
      if (result.isSuccess) {
        return "Data inserted";
      } else {
        return "Something wrong while inserting data";
      }
      return result;
    } catch (e) {
      print(e.toString());
      return e.toString();

      ///this method to resolve null issue and return the data to string
    }
  }
}
