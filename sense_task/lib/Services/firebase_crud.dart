import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sense_task/Models/FirebaseResponse.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _Collection = _firestore.collection('SenseTask');
class FirebaseCrud {
  static Future<Response> addUserDetails({
    required String username,
  }) async {

    Response response = Response();
    DocumentReference documentReferencer =
    _Collection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "username": username
    };

    var result = await documentReferencer
        .set(data)
        .whenComplete(() {
      response.code = 200;
      response.message = "Sucessfully added to the database";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
  static Stream<QuerySnapshot> readItems() {
    CollectionReference notesItemCollection =
    _Collection.doc().collection('SenseTask');
print(notesItemCollection.snapshots());
    return notesItemCollection.snapshots();
  }
}
