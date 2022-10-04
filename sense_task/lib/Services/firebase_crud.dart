import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sense_task/Models/FirebaseResponse.dart';
import 'package:sense_task/adminview/adminpage.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _UserCollection = _firestore.collection('SenseTask');
final CollectionReference _taskCollection = _firestore.collection('Tasks');

class FirebaseCrud {
  static Future<Response> addUserDetails({
    required String username,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _UserCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{"username": username};

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
        _UserCollection.doc().collection('SenseTask');
    print(notesItemCollection.snapshots());
    return notesItemCollection.snapshots();
  }
}

class FirebaseTask {
  ///add
  static Future<Response> addTask(
      {required String categorydb,
      required String titledb,
      required String descriptiondb,
      required String startdatedb,
      required String enddatedb,
      required String duedatedb,
      required String duetimedb,
      required String facultydb,
      required int statusdb,
      required String reasondb}) async {
    Response response = Response();
    DocumentReference documentReferencer = _taskCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "category": categorydb,
      "title": titledb,
      "description": descriptiondb,
      "startdate": startdatedb,
      "enddate": enddatedb,
      "duedate": duedatedb,
      "duetime": duetimedb,
      "faculty": facultydb,
      "status": statusdb,
      "reason": reasondb
    };

    var result = await documentReferencer.set(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  ///read
  static Stream<QuerySnapshot> readTask() {
    CollectionReference notesItemCollection = _taskCollection;
    return notesItemCollection.snapshots();
  }

  ///querry results
  static Stream<QuerySnapshot> QueryFaculty() {
    CollectionReference notesItemCollection = _taskCollection;
    return notesItemCollection
        .where(
          "faculty",

          ///todo:add querry search string inside equal to
          isEqualTo: "",
        )
        .snapshots();
  }

  static Future<List<QuerySnapshot<Object?>>> DropdownFaculty() {
    CollectionReference notesItemCollection = _taskCollection;
    return notesItemCollection
        .where(
          "faculty",

          ///todo:add querry search string inside equal to
          isEqualTo: "",
        )
        .snapshots()
        .toList();
  }

  ///edit
  static Future<Response> updateTask(
      {
        required String categorydb,
      required String titledb,
      required String descriptiondb,
      required String startdatedb,
      required String enddatedb,
      required String duedatedb,
      required String duetimedb,
      required String facultydb,
      required int statusdb,
      required String reasondb,
      required String docId}) async {
    Response response = Response();
    DocumentReference documentReferencer = _taskCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "category": categorydb,
      "title": titledb,
      "description": descriptiondb,
      "startdate": startdatedb,
      "enddate": enddatedb,
      "duedate": duedatedb,
      "duetime": duetimedb,
      "faculty": facultydb,
      "status": statusdb,
      "reason": reasondb
    };

    await documentReferencer.update(data).whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully updated Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }

  ///delete
  static Future<Response> deleteTask({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer = _taskCollection.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    }).catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}
class AdminQuery{

  static Stream<QuerySnapshot> AdminStatus() {
    CollectionReference notesItemCollection = _taskCollection;
    return notesItemCollection
        .where(
      "status",
      isEqualTo: adminquery,
    ).snapshots();
  }
}