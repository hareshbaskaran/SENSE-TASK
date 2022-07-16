import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/TaskMango.dart';
import 'package:sense_task/UserMango.dart';
import 'dart:developer';
import 'constant.dart';
import 'AssignTask_Admin.dart';

class UserMangoDB{
  static var db,usercollection;
  static connect() async{
    var db = await Db.create(MONGO_URL);///url given as static variable as it changes for different databases created for our application
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
     usercollection = db.collection(USER_COLLECTION);///usercollection driven from constant.dart constant
  }
  static Future<String> insert(UserMango data) async{
    ///now the given data will be inserted from mangodbmodel cloass to mangodb
    try{
      var result = await usercollection.insertOne(data.toJson());
      if(result.isSuccess){
        return "Data inserted";
      }
      else{
        return "Something wrong while inserting data";
      }
      return result;
    } catch (e){
      print(e.toString());
      return e.toString();///this method to resolve null issue and return the data to string
    }
  }
}
class TaskMangoDB{
  static var db,taskcollection;
  static connect() async{
    var db = await Db.create(MONGO_URL);///url given as static variable as it changes for different databases created for our application
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    taskcollection = db.collection(TASK_COLLECTION);
  }
  static Future<String> insert_task(TaskMango task_data) async{
    ///now the given data will be inserted from mangodbmodel cloass to mangodb
    try{
      var result = await taskcollection.insertOne(task_data.toJson());
      if(result.isSuccess){
        return "Data inserted";
      }
      else{
        return "Something wrong while inserting data";
      }
      return result;
    } catch (e){
      print(e.toString());
      return e.toString();///this method to resolve null issue and return the data to string
    }
  }
}