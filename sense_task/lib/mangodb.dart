import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/Models/AdminMongo.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/StaffPage_Admin.dart';
import 'package:sense_task/Models/TaskMango.dart';
import 'package:sense_task/Models/UserMango.dart';
import 'dart:developer';
import 'Models/constant.dart';
import 'AssignTask_Admin.dart';

var isAdminLogin;

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

  static Future<List<Map<String, dynamic>>> getAllTasks() async {
    final arrtask = await taskcollection.find().toList();
    return arrtask;
  }

  static Future<List<Map<String, dynamic>>> getAllAssignedTasks() async {
    /* var querry_data = await taskcollection*/
    final querry_data = await taskcollection
        .find(where
            .eq('faculty', '${usernamevalue_user.text.trim()}')
            .eq('status', 0)) //username_user.trim()}
        .toList();
    print(querry_data);
    return querry_data;
  }

  static Future<List<Map<String, dynamic>>> getAllAcceptedTasks() async {
    /* var querry_data = await taskcollection*/
    final querry_data = await taskcollection
        .find(where
            .eq('faculty', '${usernamevalue_user.text.trim()}')
            .eq('status', 1)) //username_user.trim()}
        .toList();
    print(querry_data);
    return querry_data;
  }

  static Future<List<Map<String, dynamic>>> getAllRejectedTasks() async {
    final querry_data = await taskcollection
        .find(where
            .eq('faculty', '${usernamevalue_user.text.trim()}')
            .eq('status', -1))

        ///todo:changed querry data for checking
        .toList();
    print(querry_data);
    return querry_data;
  }

  static Future<List<Map<String, dynamic>>> getAllOverdueTasks() async {
    /* var querry_data = await taskcollection*/
    final querry_data = await taskcollection
        .find(where
            .eq('faculty', '${usernamevalue_user.text.trim()}')
            .eq('status', 2)) //username_user.trim()}
        .toList();
    print(querry_data);
    return querry_data;
  }

  static Future<List<Map<String, dynamic>>> getAdmin() async {
    var admin_data = await admincollection
        .find(where
            .eq('username', '$username_admin')
            .eq('password', '$password_admin'))
        .toArray();
    return admin_data;
    // var admin_data = await admincollection.find().toList();
    // var AdminLogin = '${admin_data['username']}';
    // if (AdminLogin == username_admin) {
    //   isAdminLogin = 1;
    // } else {
    //   isAdminLogin = 0;
    // }
    // print(admin_data);
    // print(isAdminLogin);
    // return admin_data;
  }

  static Future<List<Map<String, dynamic>>> getUser() async {
    var user_data = await usercollection
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
    result['duedate'] = task_data?.duedatedb;
    result['duetime'] = task_data?.duetimedb;
    result['faculty'] = task_data?.facultydb;
    result['status'] = task_data?.statusdb;
    result['reason'] = task_data?.reasondb;

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
    } catch (e) {
      print(e.toString());
      return e.toString();

      ///this method to resolve null issue and return the data to string
    }
  }

  static Future<String> insert_user(UserMongo user_data) async {
    print(task_data);
    try {
      var result = await usercollection.insertOne(user_data.toJson());
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

  static Future<String> insert_admin(AdminMongo admin_data) async {
    print(task_data);
    try {
      var result = await admincollection.insertOne(admin_data.toJson());
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
