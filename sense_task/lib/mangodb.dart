import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/MongoDBModel.dart';
import 'dart:developer';
import 'constant.dart';

class MongoDatabase{
  static connect() async{
    var db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    var collection = db.collection(COLLECTION_NAME);
  }
  static Future<void> insert(MangoDbModel data) async{
    try{
    } catch (e){
      print(e.toString());
    }
  }
}