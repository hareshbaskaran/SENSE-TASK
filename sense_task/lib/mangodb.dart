import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/AdminMongo.dart';
import 'package:sense_task/LoginPage.dart';
import 'package:sense_task/StaffPage_Admin.dart';
import 'package:sense_task/TaskMango.dart';
import 'package:sense_task/UserMango.dart';
import 'dart:developer';
import 'constant.dart';
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

  static Future<List<Map<String, dynamic>>> getTask() async {
    final arrtask = await taskcollection.find().toList();
    return arrtask;
  }

  static Future<List<Map<String, dynamic>>> getQuerryTask() async {
    final querry_data = await taskcollection
        .find(where.eq('faculty', '${usernamevalue_user.text.trim()}').eq('status', 0))//username_user.trim()}
        .toList();
    print(querry_data);
    return querry_data;
  }
///todo:querry changes to be done
  static Future<List<Map<String, dynamic>>> GetUserReject() async {
    final querry_data = await taskcollection
        .find(where.eq('faculty', '${username_user.trim()}').eq('status', -1 ))
        .toList();
    print(querry_data);
    return querry_data;
  }

  static Future<List<Map<String, dynamic>>> getAdmin() async {
    var admin_data = await admincollection.find().toList();
    var AdminLogin = '${admin_data['username']}';
    if (AdminLogin == username_admin) {
      isAdminLogin = 1;
    } else {
      isAdminLogin = 0;
    }
    print(admin_data);
    print(isAdminLogin);
    print(admin_data);
    return admin_data;
  }

 static Future<List<Map<String, dynamic>>> getUserAll() async {
    var user_data = await taskcollection
        .find(where
            .eq('faculty', '${username_user.trim()}'))
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
    } catch (e) {
      print(e.toString());
      return e.toString();

    }
  }
}
