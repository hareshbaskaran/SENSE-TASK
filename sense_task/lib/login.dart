import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:sense_task/MongoDBModel.dart';
import 'package:sense_task/mangodb.dart';
TextEditingController usernamevalue = new TextEditingController();
TextEditingController passwordvalue = new TextEditingController();
String username = usernamevalue.text;
String password = passwordvalue.text;
bool grey = true;
class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool grey = true;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:SafeArea(
        child:Column(
          mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
           padding: EdgeInsets.fromLTRB(
               MediaQuery.of(context).size.width * 0.1, 0, MediaQuery.of(context).size.width *0.02, MediaQuery.of(context).size.width * 0.1),
            child:
            Text(
              'SENSE TASK MANAGEMENT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.06
              ),
            ),
          ),
         SizedBox( height: MediaQuery.of(context).size.height * 0.05),
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.75,
              child:
          Image(image:AssetImage('assets/images/vit-logo.png') )),
          SizedBox( height: MediaQuery.of(context).size.height * 0.05),
          Container(
            padding: EdgeInsets.fromLTRB(
                0, 0, MediaQuery.of(context).size.width * 0.7, 2),
            child: Text(
              'username',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
          ),

          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: new BoxDecoration(
                color: Color(0xFFF7F8F8),
                shape: BoxShape.rectangle,
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 60,
                      child: TextField(
                        onChanged: (_) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.black,
                            border: InputBorder.none,
                            labelText: 'username',
                            labelStyle: TextStyle(color: Colors.black)),
                        keyboardType: TextInputType.multiline,
                        maxLines: 20,
                        cursorColor: Colors.black,
                        controller: usernamevalue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: MediaQuery.of(context).size.height * 0.025),
          Container(
            padding: EdgeInsets.fromLTRB(
                0, 0, MediaQuery.of(context).size.width * 0.7, 2),
            child: Text(
              'password',
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: new BoxDecoration(
                color: Color(0xFFF7F8F8),
                shape: BoxShape.rectangle,
                border: Border.all(width: 2.0),
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(minHeight: 60),
                      child: TextField(
                        maxLines: null,
                        onChanged: (_) {
                          setState(() {});
                        },
                        decoration: InputDecoration(
                            fillColor: Colors.black,
                            border: InputBorder.none,
                            labelText: 'password',
                            labelStyle: TextStyle(color: Colors.black)),
                        //keyboardType: TextInputType.multiline,
                        // maxLines: 20,
                        cursorColor: Colors.black,
                        controller:passwordvalue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox( height: MediaQuery.of(context).size.height * 0.025),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  _insertData(usernamevalue.text, passwordvalue.text);
                },
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: new BoxDecoration(
                      color: Color(0xFFF7F8F8),
                      shape: BoxShape.rectangle,
                      border: Border.all(width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    )
                )
            ),
          ),
        ],
      ),
    ));
  }
}
Future<void> _insertData (String name,String pass) async{
  var _id = M.ObjectId();
  final data = MangoDbModel(id: _id, username: name, password: pass);
  var result = await MongoDatabase.insert(data);
  ///add a snack bar for ID insertion
  //_clearall();
}
/*
String nameController = username;
String passController = password;
void _clearall(){
 nameController = "";
 passController = "";
}
*/

