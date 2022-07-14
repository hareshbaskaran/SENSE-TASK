import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/MongoDBModel.dart';
import 'dart:developer';
import 'constant.dart';

class MongoDatabase{
  static var db,usercollection;
  static connect() async{
    var db = await Db.create(MONGO_URL);///url given as static variable as it changes for different databases created for our application
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
     usercollection = db.collection(COLLECTION_NAME);///usercollection driven from constant.dart constant
  }
  static Future<String> insert(MangoDbModel data) async{
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