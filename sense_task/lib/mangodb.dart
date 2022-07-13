import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/MongoDBModel.dart';
import 'dart:developer';
import 'constant.dart';

class MongoDatabase{
  static var db,usercollection;
  static connect() async{
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
     usercollection = db.collection(COLLECTION_NAME);
  }
  static Future<String> insert(MangoDbModel data) async{
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
      return e.toString();
    }
  }
}