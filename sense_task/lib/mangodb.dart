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
  static Future<String> insert(UserMongo data) async{
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

///

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
  static Future<List<Map<String,dynamic>>>getTask()async{
    final arrtask = await taskcollection.find().toList();
    return arrtask;
  }

  static Future<void> update_task(TaskMongo updatetask)
  async {
    var result = await taskcollection
        .findOne(task_data.toJson())({"_id": task_data.id_t});
    result['category'] = task_data.categorydb;
    result['title']=task_data.titledb;
    result['description']=task_data.descriptiondb;
    result['startdate']=task_data.startdatedb;
    result['enddate']=task_data.enddatedb;
    result['duetime']=task_data.duetimedb;
    result['faculty']=task_data.facultydb;
    var response = await taskcollection.save(result);
    inspect(response);
  }
  static delete_task(TaskMongo task_delete)async{
    await taskcollection.remove(where.id(task_delete.id_t));
  }

  static Future<String> insert_task(TaskMongo task_data) async{
    print(task_data);
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