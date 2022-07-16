import 'package:mongo_dart/mongo_dart.dart';
import 'package:sense_task/MongoDBModel.dart';
import 'dart:developer';
import 'constant.dart';

// this dart file is to make a class MongoDatabase which has connection and CRUD functions.
class MongoDatabase {
  static var db, usercollection;

  static connect() async {
    var db = await Db.create(MONGO_URL);

    ///url given as static variable as it changes for different databases created for our application
    await db.open();
    inspect(db);
    var status = db.serverStatus();
    print(status);
    usercollection = db.collection(USER_COLLECTION);

  }

  static Future<String> insert(MongoDbModel data) async {
    ///now the given data will be inserted from mongodbmodel cloass to mongodb
    try {
      var result = await usercollection.insertOne(data.toJson());
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
}
